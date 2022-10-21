import 'package:aws/screens/camera_screen.dart';
import 'package:aws/screens/gallery_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraHelper extends StatefulWidget {
  final VoidCallback? shouldLogOut;

  const CameraHelper({Key? key, this.shouldLogOut}) : super(key: key);

  @override
  State<CameraHelper> createState() => _CameraHelperState();
}

class _CameraHelperState extends State<CameraHelper> {
  late CameraDescription _camera;
  bool _shouldShowCamera = false;

    List<MaterialPage> get _pages {
      return [
        MaterialPage(child: GalleryScreen(
          shouldLogOut: widget.shouldLogOut,
          shouldShowCamera: () => _toggleCameraOpen(true),
        )),

        if(_shouldShowCamera)
            MaterialPage(child: CameraScreen(
            camera: _camera,
            didProvideImagePath: (imagePath) {
              this._toggleCameraOpen(false);
            },
          ))
      ];
    }

  @override
  void initState() {
    super.initState();
    _getCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: _pages,
      onPopPage: (route, result) => route.didPop(result),
    );
  }

  void _toggleCameraOpen(bool isOpen) {
    setState(() {
      this._shouldShowCamera = isOpen;
    });
  }

  void _getCamera() async {
    final camerasList = await availableCameras();
    setState(() {
      final firstCamera = camerasList.first;
      this._camera = firstCamera;
    });
  }

}