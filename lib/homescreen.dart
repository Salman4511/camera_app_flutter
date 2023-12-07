import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cam_app/galleryscreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'filehelper.dart';


class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  homeScreenState createState() => homeScreenState();
}

class homeScreenState extends State<homescreen> {
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;

  

Future<String> _getSaveDirectory() async {
  final directory = await getExternalStorageDirectory(); // Change to your desired directory
  return directory!.path;
}

Future<void> _saveImage(XFile image) async {
  final directory = await _getSaveDirectory();
  final filePath = '$directory/${DateTime.now().millisecondsSinceEpoch}.jpg';

  // Copy the image to the specified folder
  final File newImage = File(filePath);
  await newImage.writeAsBytes(await image.readAsBytes());

  // You can also save the file path to a list or database for gallery display
}


  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[0], ResolutionPreset.medium);
    await _cameraController.initialize();
  }

 Future<void> _takePicture() async {
  try {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      await FileHelper.addImagePath(image.path); // Save the captured image path
      print("Image captured: ${image.path}");
    }
  } catch (e) {
    print("Error taking picture: $e");
  }
}


  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 208, 244, 45),
        title: Text('Camera'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
             Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GalleryScreen()),
    );
          },
          icon: Icon(Icons.browse_gallery),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ElevatedButton.icon(
            onPressed: _takePicture,
            icon: Icon(Icons.camera_alt),
            label: Text('Take Picture'),
          ),
        ),
        
      ),
    );
  }
}



