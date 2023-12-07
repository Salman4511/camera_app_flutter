// file_helper.dart

import 'package:shared_preferences/shared_preferences.dart';

class FileHelper {
  static const String _imagePathsKey = 'imagePaths';

  static Future<List<String>> getImagePaths() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? imagePaths = prefs.getStringList(_imagePathsKey);
    return imagePaths ?? [];
  }

  static Future<void> addImagePath(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> imagePaths = await getImagePaths();
    imagePaths.add(imagePath);
    await prefs.setStringList(_imagePathsKey, imagePaths);
  }
}