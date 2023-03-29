import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kill_tiktok/constants/gaps.dart';
import 'package:kill_tiktok/constants/sizes.dart';
import 'package:kill_tiktok/features/videos/view_models/playback_config_vm.dart';
import 'package:kill_tiktok/features/videos/views/widgets/video_button.dart';
import 'package:kill_tiktok/features/videos/views/widgets/video_comments.dart';
import 'package:marquee/marquee.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends ConsumerStatefulWidget {
  final Function onVideoFinished;
  final int index;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  @override
  VideoPostState createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  //위드에 믹스인을 사용하면 그 클래스를 복사해온다는 뜻이다. 그 클래스의 메서드와 속성을 다 가져온다
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset('assets/videos/video.mp4');

  bool _isPaused = false;
  final Duration _animationDuration = const Duration(milliseconds: 200);

  late final AnimationController _animationController;

  bool _seeMore = false;
  bool _isMuted = false;

  void _onSeeMoreClick() {
    setState(() {
      _seeMore = !_seeMore;
    });
  }

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      //컨트롤러의 길이가 사용자가 보고있는 위치와 같다면 피니쉬드 위젯을 실행
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    _videoPlayerController.addListener(_onVideoChange);
    _onplaybackConfigChanged();
    setState(() {});
    //k를 입력하면 모든 콘스탄트를 볼수있다
    //kisweb 만약에 퉵이라면
    if (kIsWeb) {
      //웹에서 바로 비디오플레이를 하려면 소리가 안나야된다. 정책이다
      await _videoPlayerController.setVolume(0);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _animationController = AnimationController(
      //브이싱크는 오프스크린의 불필요한 리소스 사용을 막는것이다. 위젯이 안보일때는 애니메이션이 작동하지 않는다. 이걸 사용하려면 SingleTickerProviderStateMixin를 믹스인해야한다.
      //
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      //defalut 값. 이렇게하면 작아짐
      value: 1.5,
      duration: _animationDuration,
    );
    //listen muted or not
    // context
    //     .read<PlaybackConfigViewModel>()
    //     .addListener(_onplaybackConfigChanged);
  }

  void _onplaybackConfigChanged({bool toggle = false}) {
    //live or not mounted = alive
    if (!mounted) return;
    _isMuted = toggle ? !_isMuted : ref.read(playbackConfigProvider).muted;
    _videoPlayerController.setVolume(_isMuted ? 0 : 1);
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _onvisibilityChanged(VisibilityInfo info) {
    //모든 스테이트풀에는 마운트 프로퍼티가 있다 마운트가 안됐다 = 사용자들에게 더이상 안보여진다
    if (!mounted) return;
    //화면이 다 보이고 동영상이 재생이 안되고 있을때 그때 재생시키는 함수. 올리는동안 밑에 동영상은 재생이 안된다.
    if (info.visibleFraction == 1 &&
        //paused 일때 새로고침하면 재생아이콘뜨면서 재생되는 버그를 해결
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      if (ref.read(playbackConfigProvider).autoplay) {
        _videoPlayerController.play();
      }
    }
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      //동영상이 재생되고 있는 상황에서 화면이 보이지않으면(화면 넘어가면 동영상 정지)
      _ontoglePause();
    }
  }

  void _ontoglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onCommentTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _ontoglePause();
    }
    //댓글창
    await showModalBottomSheet(
        //모달 바텀시트의 사이즈를 변경할수 있게 된다
        isScrollControlled: true,
        //끝부분 둥글게
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.size16),
        ),
        context: context,
        builder: (context) => const VideoComments());
    //모달바텀시트가 퓨처이기때문데 밑에 토글포즈를 한번 더 할수 있다. 그럼 댓글창을 닫으면 동영상이 다시 재생된다
    _ontoglePause();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('${widget.index}'),
      onVisibilityChanged: _onvisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
            //일시정지
            child: GestureDetector(
              onTap: _ontoglePause,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              //클릭 안되게 하는 위젯. 포지션드는 항상 스택의 차일드여야 되서 센터를 감싼다
              child: Center(
                child: AnimatedBuilder(
                  //애니메이션을 받고 애니메이션의 변화를 감지한다
                  animation: _animationController,
                  //애니메이션컨트롤러가 바뀔때마다 빌더부분 메서드를 실행한다한다
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      //애니메이티드 오파시티를 넘겨준다. animated하고싶은 child
                      child: child,
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1 : 0,
                    duration: _animationDuration,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              left: 20,
              top: 40,
              child: IconButton(
                icon: FaIcon(
                  ref.watch(playbackConfigProvider).muted
                      ? FontAwesomeIcons.volumeOff
                      : FontAwesomeIcons.volumeHigh,
                  color: Colors.white,
                ),
                onPressed: () {
                  _onplaybackConfigChanged(toggle: true);
                },
              )),
          Positioned(
            bottom: 20,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '@yaman.',
                  style: TextStyle(
                      fontSize: Sizes.size20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Gaps.v10,
                const Text(
                  'This is my hous in Thailand',
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    color: Colors.white,
                  ),
                ),
                Gaps.v10,
                SizedBox(
                  width: 300,
                  child: _seeMore
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'datadatadatadatadatadatadatadatadatadatadatadata',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Sizes.size16,
                                  fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: _onSeeMoreClick,
                              child: const Text(
                                'See less',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Sizes.size16,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )
                      : Row(
                          children: [
                            const Flexible(
                              child: Text(
                                'datadatadatadatadatadatatadatadatadatadatadatadata',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Sizes.size16,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: _onSeeMoreClick,
                              child: const Text(
                                "See more",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Sizes.size16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
                Gaps.v10,
                Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.music,
                      size: 16,
                      color: Colors.white,
                    ),
                    Gaps.h8,
                    SizedBox(
                      width: 200,
                      height: 16,
                      child: Marquee(
                          text:
                              "This text is to long to be shown in just one line",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: Sizes.size16,
                          )),
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 25,
                  foregroundImage: NetworkImage(
                      'http://t1.daumcdn.net/cfile/177954254A2880EA7F'),
                ),
                Gaps.v24,
                const VideoButton(
                    icon: FontAwesomeIcons.solidHeart, text: '3m'),
                Gaps.v24,
                GestureDetector(
                    onTap: () => _onCommentTap(context),
                    child: const VideoButton(
                        icon: FontAwesomeIcons.solidComment, text: '402')),
                Gaps.v24,
                const VideoButton(icon: FontAwesomeIcons.share, text: 'share'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}