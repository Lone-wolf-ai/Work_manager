 
 
 
 ///ADD Flutter perim
 
 
 
 
  // Future<void> _requestCameraPermission(BuildContext context) async {
  //   final status = await Permission.camera.request();

  //   if (status.isGranted) {
  //     // Initialize the camera and navigate to the camera screen
  //     final cameras = await availableCameras();
  //     final firstCamera = cameras.first;

  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => CameraScreen(camera: firstCamera),
  //       ),
  //     );
  //   } else if (status.isDenied) {
  //     // Permission is denied by the user, show a dialog or message
  //     _showPermissionDeniedDialog(context);
  //   } else if (status.isPermanentlyDenied) {
  //     // Permission is permanently denied, open app settings
  //     await openAppSettings();
  //   }
  // }

  // void _showPermissionDeniedDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text("Permission Denied"),
  //       content: const Text(
  //           "Camera permission is required to scan images. Please enable it in the settings."),
  //       actions: [
  //         TextButton(
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //           child: const Text("OK"),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Future<void> _pickImageFromGallery(BuildContext context) async {
  //   final ImagePicker _picker = ImagePicker();
  //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     if (kDebugMode) {
  //       print("Photo picked: ${pickedFile.path}");
  //     }
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) =>
  //             DisplayPictureScreen(imagePath: pickedFile.path),
  //       ),
  //     );
  //   }
  // }





