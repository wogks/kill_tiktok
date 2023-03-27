// ignore_for_file: avoid_print

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kill_tiktok/constants/gaps.dart';
import 'package:kill_tiktok/constants/sizes.dart';
import 'package:kill_tiktok/features/videos/views/video_preview_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoRecordingScreen extends StatefulWidget {
  static const String routeName = 'postVideo';
  static const String routeURL = '/upload';
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
//애니메이션이 두개라서 싱글말고 그냥 티커프로바이더
    with
        TickerProviderStateMixin,
        //라이프사이클 확인용
        WidgetsBindingObserver {
  bool _hasperMission = false;
  bool _isSelfieMode = false;
  late final bool _noCamera = kDebugMode && Platform.isIOS;
  late FlashMode _flashMode;
  //카메라를 초기화시키기 위해 컨ㅌ롤러를 사용한다
  late CameraController _cameraController;

  //컨트롤러를 만들고
  late final AnimationController _buttonAnimationController =
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 200));
  //애니메이션을 만든다
  late final Animation<double> _buttonAnimation =
      Tween(begin: 1.0, end: 1.3).animate(_buttonAnimationController);

  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
    //애니매이션 밸류를 0에서 1사이로 하고싶다, 10초동안 0에서 1로간다
    upperBound: 1.0,
    lowerBound: 0.0,
  );

  Future<void> initCamera() async {
    //폰에 몇개의 카메라가 있는지 확인
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      return;
    }
    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
      // enableAudio: false,
    );

    await _cameraController.initialize();
    //ios르ㄹ 위한 메서드 가끔 영상 싱크가 안맞는다
    await _cameraController.prepareForVideoRecording();
    //카메라가 가진 플래쉬모드의 값을 가져온다
    _flashMode = _cameraController.value.flashMode;
    setState(() {});
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final microphonePermission = await Permission.microphone.request();
    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenided = microphonePermission.isDenied ||
        microphonePermission.isPermanentlyDenied;
    if (!cameraDenied && !micDenided) {
      _hasperMission = true;
      await initCamera();
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    if (!_noCamera) {
      initPermissions();
    } else {
      setState(() {
        _hasperMission = true;
      });
    }

    //lifcycle check
    WidgetsBinding.instance.addObserver(this);
    _progressAnimationController.addListener(() {
      //매 슈머마이크로세컨마다 10초동안(프로그레스 컨트롤러의 듀레이션) 밸류가 바뀐걸 알려준다
      setState(() {});
      //리스너는 우리에게 밸류가 끝난걸 알려준다
      _progressAnimationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _stopRecording();
        }
      });
    });
  }

  Future<void> toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    //실제로 카메라를 보여주기전에 초기화해야함
    await initCamera();
    setState(() {});
  }

  Future<void> setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  Future<void> _startRecording(TapDownDetails _) async {
    if (_cameraController.value.isRecordingVideo) return;
    await _cameraController.startVideoRecording();
    _buttonAnimationController.forward();
    _progressAnimationController.forward();
    print('start');
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;
    _buttonAnimationController.reverse();
    _progressAnimationController.reset();
    print('stop');
    final file = await _cameraController.stopVideoRecording();
    print(file.name);
    print(file.path);
    //에이싱크에서 컨텍스트 빌드 쓸때 필수
    if (!mounted) return;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              VideoPreviewScreen(video: file, isPicked: false),
        ));
  }

  Future<void> _onPickVideoPressed() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    //만약 유저가 비디오를 선택하지 않았을 경우에는 아무일도 일어나지 않는다
    if (video == null) return;
    if (!mounted) return;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              VideoPreviewScreen(video: video, isPicked: true),
        ));
  }

  @override
  void dispose() {
    _buttonAnimationController.dispose();
    _progressAnimationController.dispose();
    if (!_noCamera) {
      _cameraController.dispose();
    }
    super.dispose();
  }

  //라이프사이클이 바뀌었을때(앱이 백그라운드로 갔을때 cameracontroller 처리)
  //앱보다 권한창이 먼저 실행이 되면 에러가 생긴다(카메라컨트롤러가 초기화가 안되어 있는데 불러버림)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_noCamera) return;
    if (!_hasperMission) return;
    if (!_cameraController.value.isInitialized) return;
    print(state);
    if (state == AppLifecycleState.inactive) {
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      initCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: !_hasperMission
            // || !_cameraController.value.isInitialized 아래 스택 노카메라모드 설정했으니 주석처리
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'requesting permissions...',
                    style:
                        TextStyle(color: Colors.white, fontSize: Sizes.size20),
                  ),
                  Gaps.v20,
                  CircularProgressIndicator()
                ],
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  if (!_noCamera && _cameraController.value.isInitialized)
                    CameraPreview(
                      _cameraController,
                    ),
                  const Positioned(
                      top: Sizes.size40,
                      left: Sizes.size20,
                      child: CloseButton(
                        color: Colors.white,
                      )),
                  //플래쉬모드는 레이트라서 초기화되지 않으면 에러가 뜬다
                  if (!_noCamera && _cameraController.value.isInitialized)
                    Positioned(
                      top: Sizes.size20,
                      right: Sizes.size20,
                      child: Column(
                        children: [
                          IconButton(
                            color: Colors.white,
                            onPressed: toggleSelfieMode,
                            icon: const Icon(Icons.cameraswitch),
                          ),
                          Gaps.v10,
                          IconButton(
                            color: _flashMode == FlashMode.off
                                ? Colors.yellow
                                : Colors.white,
                            onPressed: () => setFlashMode(FlashMode.off),
                            icon: const Icon(Icons.flash_off_rounded),
                          ),
                          IconButton(
                            color: _flashMode == FlashMode.always
                                ? Colors.yellow
                                : Colors.white,
                            onPressed: () => setFlashMode(FlashMode.always),
                            icon: const Icon(Icons.flash_on_rounded),
                          ),
                          IconButton(
                            color: _flashMode == FlashMode.auto
                                ? Colors.yellow
                                : Colors.white,
                            onPressed: () => setFlashMode(FlashMode.auto),
                            icon: const Icon(Icons.flash_auto_rounded),
                          ),
                          IconButton(
                            color: _flashMode == FlashMode.torch
                                ? Colors.yellow
                                : Colors.white,
                            onPressed: () => setFlashMode(FlashMode.torch),
                            icon: const Icon(Icons.flashlight_on_rounded),
                          ),
                        ],
                      ),
                    ),
                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    bottom: 10,
                    child: Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                          onTapDown: _startRecording,
                          //탭업에는 디테일이 필요한데 여기서 넣어줌으로서 다른곳에서 디테일없이 다 불러올수있다
                          onTapUp: (details) => _stopRecording(),
                          //애니메이션을 만들어준다
                          child: ScaleTransition(
                            scale: _buttonAnimation,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: Sizes.size60 + Sizes.size10,
                                  height: Sizes.size60 + Sizes.size10,
                                  child: CircularProgressIndicator(
                                    color: Colors.red,
                                    strokeWidth: 6,
                                    value: _progressAnimationController.value,
                                  ),
                                ),
                                Container(
                                  width: Sizes.size60,
                                  height: Sizes.size60,
                                  decoration: BoxDecoration(
                                      color: Colors.red.shade400,
                                      shape: BoxShape.circle),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            //이걸 안하면 아이콘 주변을 눌러도 아이콘이 클릭됌
                            alignment: Alignment.center,
                            child: IconButton(
                                onPressed: _onPickVideoPressed,
                                icon: const FaIcon(
                                  FontAwesomeIcons.image,
                                  color: Colors.white,
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
