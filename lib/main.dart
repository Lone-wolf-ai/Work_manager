import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:work_manger_tool/app/core/utils/constants/string_const.dart';
import 'package:work_manger_tool/app/core/utils/local_storage/sqlitestroage.dart';
import 'package:work_manger_tool/app/modules/auth/login/login_screen.dart';
import 'package:work_manger_tool/app/modules/onboarding/onboarding_screen.dart';
import 'package:work_manger_tool/app/navigation.dart';
import 'package:work_manger_tool/firebase_options.dart';
import 'package:work_manger_tool/pages.dart';
import 'app/core/utils/local_storage/hive_storage.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAppCheck.instance.activate(
      webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
      androidProvider: AndroidProvider.debug,
      appleProvider: AppleProvider.appAttest,
    );

  } on FirebaseException catch (e) {
    if (kDebugMode) {
      print("Firebase initialization failed: ${e.message}");
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final LocalStorage localStorage = LocalStorage();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: ((localStorage.readData(StringConst.isfirst)) == null)
          ? const OnboardingScreen()
          : (localStorage.readData(StringConst.loggedin) == null ||
                  localStorage.readData(StringConst.loggedin) == false)
              ? const LoginScreen()
              : const NavigationScreen(),
      getPages: AppPages.pages,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Push Notifications'),
      ),
      body: const Center(
        child: Text('Waiting for notifications...'),
      ),
    );
  }
}
