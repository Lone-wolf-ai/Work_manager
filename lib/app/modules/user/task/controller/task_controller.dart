import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../../core/utils/constants/string_const.dart';
import '../../../../core/utils/exceptions/firebase_exceptions.dart';
import '../../../../core/utils/exceptions/platform_exceptions.dart';
import '../../../../core/utils/helpers/uniqueid.dart';
import '../../../../data/models/taskmodel.dart';
import '../../../../data/service/repository/authrepository.dart';

class TaskController extends GetxController {
  static TaskController get instance => Get.find();
  final firebaserepo = Get.put(FirebaseRepo());
  final todolist = <TaskModel>[].obs;
  final ongoinglist = <TaskModel>[].obs;
  final completedlist = <TaskModel>[].obs;
  final reviewinglist = <TaskModel>[].obs;
  final tasklist = <TaskModel>[].obs;
  Logger logger = Logger();

  @override
  void onInit() {
    super.onInit();
    setupTaskListener();
  }

  void setupTaskListener() {
    FirebaseFirestore.instance
        .collection(StringConst.task)
        .where(StringConst.assignedTo,
            arrayContains: "DinaRWE7j7aGROlmWIU0LTSuAE12")
        .snapshots()
        .listen((snapshot) {
      List<TaskModel> tasks = snapshot.docs.map((doc) {
        TaskModel task = TaskModel.fromJson(doc.data());
        task.id = doc.id;
        return task;
      }).toList();

      logger.d("Data fetched ${tasks.toString()}");

      tasklist.assignAll(tasks);
      completedlist.assignAll(
          tasks.where((task) => task.status == StringConst.completed));
      ongoinglist
          .assignAll(tasks.where((task) => task.status == StringConst.ongoing));
      todolist
          .assignAll(tasks.where((task) => task.status == StringConst.todo));
      reviewinglist.assignAll(
          tasks.where((task) => task.status == StringConst.reviewing));
    }, onError: (error) {
      if (error is FirebaseExceptionString) {
        logger.e(FirebaseExceptionString(error.code).message);
      } else if (error is PlatformException) {
        logger.e(PlatformExceptionString(error.code).message);
      } else {
        logger.e('An unexpected error occurred: $error');
      }
    });
  }

  List<TaskModel> filterTasksByStatus(String priority) {
    return tasklist.where((task) => task.priority == priority).toList();
  }

  Future<void> taskupdate(String taskId, String status) async {
    try {
      TaskModel? task = tasklist.firstWhereOrNull((task) => task.id == taskId);

      if (task != null) {
        task.status = status;
        await FirebaseFirestore.instance
            .collection(StringConst.task)
            .doc(taskId)
            .update(task.toJson());

        logger.d('Task updated successfully!');
      } else {
        logger.w('Task not found!');
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

  Future<String> uploadFile() async {
    try {
      // Pick a file
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

          Reference ref = storage.ref().child('subtask_attachment/$uuid');

          // Upload the file
          TaskSnapshot uploadTask = await ref.putFile(File(file.path!));

          // Get the download link
          String downloadUrl = await ref.getDownloadURL();
          logger.d('File uploaded successfully. Download link: $downloadUrl');
          return downloadUrl;
        }
        return '';
      } else {
        logger.w('File picking cancelled.');
        return '';
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

  Future<void> updateSubtask({required String taskId, required String subtaskTitle,
      bool? newDoneStatus,  String newAttachmentLink=''}) async {
    try {
      TaskModel? task = tasklist.firstWhereOrNull((task) => task.id == taskId);

      if (task != null) {
        int subtaskIndex = task.subtasks
                ?.indexWhere((subtask) => subtask.title == subtaskTitle) ??
            -1;

        if (subtaskIndex != -1) {
          if (newDoneStatus!=null)task.subtasks![subtaskIndex].done = newDoneStatus;
          if(newAttachmentLink!='')task.subtasks![subtaskIndex].attachmentLink = newAttachmentLink;
        
          await FirebaseFirestore.instance
              .collection(StringConst.task)
              .doc(taskId)
              .update(task.toJson());
          
          logger.d('Subtask updated successfully!');
        } else {
          logger.w('Subtask not found!');
        }
      } else {
        logger.w('Task not found!');
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
}
