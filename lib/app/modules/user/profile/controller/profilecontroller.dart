import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../core/utils/constants/string_const.dart';
import '../../../../core/utils/exceptions/firebase_exceptions.dart';
import '../../../../core/utils/exceptions/platform_exceptions.dart';
import '../../../../core/utils/local_storage/storage_utility.dart';
import '../../../../core/utils/popups/loaders.dart';
import '../../../../data/models/userdata.dart';
import '../../../../data/service/repository/authrepository.dart';
import '../../../auth/login/login_screen.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  // init firebase
  final firebaserepo = Get.put(FirebaseRepo());
  // init local storage
  LocalStorage localStorage = LocalStorage();
  // handle user input
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // assign profile data
  final Rx<UserModel> userdata = UserModel(
    name: '',
    id: '',
    email: '',
    address: '',
    phonenumber: '',
    profilepic: '',
    fullname: '',
  ).obs;

  // logger instance
  final Logger logger = Logger();

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  // check data
  fetchUserData() async {
    try {
      if (localStorage.readData(StringConst.userdata) == null) {
        logger.d("Not Found data in local storage");
        final data = await firebaserepo.readDataUsingIdandColletionname(
          StringConst.userdata,
          firebaserepo.currenuser!.uid,
        );
        if (data.data() != null) {
          userdata.value = UserModel.fromJson(data.data()!);
          localStorage.saveData(StringConst.userdata, userdata.value.toJson());
          logger.d('User data fetched from Firebase and saved locally.');
        }
      } else {
        logger.d("Found data in local storage");
        userdata.value =
            UserModel.fromJson(localStorage.readData(StringConst.userdata));
        logger.d('User data fetched from local storage.');
      }
    } catch (e) {
      logger.e('Failed to fetch user data: $e');
    }
  }

  // update info
Future<void> uploadImage(BuildContext context) async {
  try {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected.')),
      );
      logger.i('No image selected.');
      return; // Exit the function if no image is selected
    }

    // Read the file and convert it to Uint8List
    final Uint8List imageData = await pickedFile.readAsBytes();

    // upload image and get link
    final String link = await firebaserepo.uploadFile(
      imageData,
      "Image/${userdata.value.id}",
    );

    // update user profile pic link
    await firebaserepo.updateData(
      StringConst.userdata,
      userdata.value.id,
      {'profilepic': link},
    );

    // Assign link to userdata
    userdata.update((user) {
      if (user != null) {
        user.profilepic = link;
      }
    });

    // update local storage data
    await localStorage.saveData(
      StringConst.userdata,
      userdata.value.toJson(),
    );

    logger.d('Profile picture updated successfully.');
  } on FirebaseExceptionString catch (e) {
    logger.e('FirebaseExceptionString: ${e.message}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Firebase error: ${e.message}')),
    );
    throw FirebaseExceptionString(e.code).message;
  } on PlatformException catch (e) {
    logger.e('PlatformException: ${e.message}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Platform error: ${e.message}')),
    );
    throw PlatformExceptionString(e.code).message;
  } catch (e) {
    logger.e('Exception: ${e.toString()}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('An unexpected error occurred: ${e.toString()}')),
    );
    throw 'An unexpected error occurred: ${e.toString()}';
  }
}

  Future<void> signout() async {
    try {
      await localStorage.saveData(StringConst.userdata,null).then((v) async {
        await localStorage
            .saveData(StringConst.attendancerecord,null)
            .then((v) async {
          await localStorage.saveData(StringConst.listofrec,null).then((V) async {
            await localStorage
                .saveData(StringConst.checkedIn,null)
                .then((V) async {
              await localStorage.saveData(StringConst.date,null).then((v) async {
                await localStorage
                    .saveData(StringConst.checkedout,null)
                    .then((v) async {
                  await localStorage
                      .saveData(StringConst.listofrec,null)
                      .then((v) async {
                    await localStorage.saveData(StringConst.year,null).then((v) {
                      Future.delayed(const Duration(seconds: 2)).then((v) {
                        firebaserepo.signOut();
                        Loaders.successSnackBar(
                            title: "Successfully signed out");
                        localStorage.saveData(StringConst.loggedin, false);
                        
                         Get.offAll(() => const LoginScreen());
                        logger.d('User signed out successfully.');
                      });
                    });
                  });
                });
              });
            });
          });
        });
      });
    } on FirebaseExceptionString catch (e) {
      logger.e('FirebaseExceptionString: ${e.message}');
      throw FirebaseExceptionString(e.code).message;
    } on PlatformException catch (e) {
      logger.e('PlatformException: ${e.message}');
      throw PlatformExceptionString(e.code).message;
    } catch (e) {
      logger.e('An unexpected error occurred during sign-out: $e');
      if (kDebugMode) {
        print(e.toString());
      }
      throw 'An unexpected error occurred.';
    }
  }
}
