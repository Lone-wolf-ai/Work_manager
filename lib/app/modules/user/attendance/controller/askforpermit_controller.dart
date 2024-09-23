import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../core/utils/constants/string_const.dart';
import '../../../../core/utils/exceptions/firebase_exceptions.dart';
import '../../../../core/utils/exceptions/platform_exceptions.dart';
import '../../../../core/utils/helpers/uniqueid.dart';
import '../../../../core/utils/popups/loaders.dart';
import '../../../../data/models/leaveapplication.dart';
import '../../../../data/service/api/locationtimecontroller.dart';
import '../../../../data/service/repository/authrepository.dart';


class LeaveApplicationController extends GetxController {
  final firebaserepo = Get.put(FirebaseRepo());

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final attachmentLink="".obs;
  final time = Get.put(LocationTimeController());
  Logger logger=Logger();
  void showConfirmationDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text("Are you sure?"),
        content: const Divider(),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Get.back();
            },
            child: const Text("No"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.greenAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: () {
              // Handle the submit action
              final date = time.datetime.value!.date;
              if (date != null) {
                final application = Leaveapplication(
                    date: date,
                    attachment:attachmentLink.value,
                    description: descriptionController.text.trim(),
                    title: titleController.text.trim());
                firebaserepo
                    .createCollection(
                        StringConst.leaveapplication, application.toMap())
                    .then((v) => Loaders.successSnackBar(
                        title: "Submited",));
                Get.back();
              } else {
                Loaders.warningSnackBar(
                    title: "There's somthing wrong.",
                    message: "Please apply later.");
                Get.back();
              }
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

    Future<void> uploadFile() async {
    try {
      // pick a file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,allowedExtensions: ['zip']
      );

      if (result != null) {
        PlatformFile file = result.files.first;
        if (file.path != null) {
          //generate uuid 24 ch
          final uuid=generate24CharUUID();
          // Create a reference to the Firebase Storage
          FirebaseStorage storage = FirebaseStorage.instance;

          Reference ref = storage.ref().child('Leave_Application/$uuid');

          // upload the file
          TaskSnapshot uploadTask = await ref.putFile(File(file.path!));

          // get the download link
          String downloadUrl = await ref.getDownloadURL();
          logger.d('File uploaded successfully. Download link: $downloadUrl');
          attachmentLink.value=downloadUrl;
          
        }
   
      } else {
        logger.w('File picking cancelled.');
    
      }
    } on FirebaseExceptionString catch (e) {
      throw FirebaseExceptionString(e.code).message;
    } on PlatformException catch (e) {
      throw PlatformExceptionString(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw 'An unexpected error occurred.';
    }
  }


  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
