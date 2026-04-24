import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  static const _key = 'profile_picture_path';

  final ImagePicker _picker = ImagePicker();
  String? _imagePath;
  int _imageVersion = 0;

  String? get imagePath => _imagePath;
  int get imageVersion => _imageVersion;
  bool get hasImage => _imagePath != null && File(_imagePath!).existsSync();

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString(_key);
    if (path != null && File(path).existsSync()) {
      _imagePath = path;
    } else {
      _imagePath = null;
      if (path != null) await prefs.remove(_key);
    }
    notifyListeners();
  }

  Future<void> pickImage() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
    );
    if (picked == null) return;

    // Evict the old image from Flutter's image cache
    if (_imagePath != null) {
      FileImage(File(_imagePath!)).evict();
    }

    final appDir = await getApplicationDocumentsDirectory();
    final ext = p.extension(picked.path);
    final destPath = p.join(appDir.path, 'profile_picture$ext');

    final destFile = await File(picked.path).copy(destPath);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, destFile.path);
    _imagePath = destFile.path;
    _imageVersion++;
    notifyListeners();
  }

  Future<void> removeImage() async {
    if (_imagePath != null) {
      FileImage(File(_imagePath!)).evict();
      final file = File(_imagePath!);
      if (file.existsSync()) await file.delete();
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
    _imagePath = null;
    _imageVersion++;
    notifyListeners();
  }
}
