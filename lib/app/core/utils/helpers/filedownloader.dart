import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

Future<String> downloadFile(String url, String fileName) async {
  try {
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      throw Exception('Storage permission denied');
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String? path = await FilePicker.platform.saveFile(
        dialogTitle: 'Please select an output file:',
        fileName: fileName,
      );

      if (path == null) {
        throw Exception('File save canceled by user');
      }

      final file = File(path);

      await file.writeAsBytes(response.bodyBytes);
      print('File downloaded successfully: $path');
      return path;
    } else {
      throw Exception('Failed to download file: ${response.statusCode}');
    }
  } catch (e) {
    print('Error downloading file: $e');
    throw Exception('Failed to download file: $e');
  }
}
