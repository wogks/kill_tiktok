import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:kill_tiktok/constants/gaps.dart';
import 'package:kill_tiktok/constants/sizes.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
  bool _hasperMission = false;
  //카메라를 초기화시키기 위해 컨ㅌ롤러를 사용한다
  late final CameraController _cameraController;

  Future<void> initCamera() async {
    //폰에 몇개의 카메라가 있는지 확인
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      return;
    }
    _cameraController =
        CameraController(cameras[0], ResolutionPreset.ultraHigh);

    await _cameraController.initialize();
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
                ],
              ),
      ),
    );
  }
}
