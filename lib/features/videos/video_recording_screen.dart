import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:kill_tiktok/constants/gaps.dart';
import 'package:kill_tiktok/constants/sizes.dart';
import 'package:kill_tiktok/features/videos/video_preview_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
//애니메이션이 두개라서 싱글말고 그냥 티커프로바이더
    with
        TickerProviderStateMixin {
  bool _hasperMission = false;
  bool _isSelfieMode = false;
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
    initPermissions();
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
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPreviewScreen(video: file),
        ));
  }

  @override
  void dispose() {
    _buttonAnimationController.dispose();
    _cameraController.dispose();
    _progressAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: !_hasperMission || !_cameraController.value.isInitialized
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
                  CameraPreview(
                    _cameraController,
                  ),
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
                    bottom: 10,
                    child: GestureDetector(
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
                  ),
                ],
              ),
      ),
    );
  }
}
