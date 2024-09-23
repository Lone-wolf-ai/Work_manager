import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TitleDescriptionController extends GetxController {
  var title = ''.obs;
  var description = ''.obs;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  void clearFields() {
    titleController.clear();
    descriptionController.clear();
    title.value = '';
    description.value = '';
  }

  void submitFields() {
    title.value = titleController.text;
    description.value = descriptionController.text;
    Get.snackbar('Submitted', 'Title: ${title.value}\nDescription: ${description.value}');
  }
}