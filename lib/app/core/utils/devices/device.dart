import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDeviceUtils {
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus(); // Remove focus to hide keyboard
  }

  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: color,
      ),
    );
  }

  static bool isLandscapeOrientation(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.orientation == Orientation.landscape;
  }

  static bool isPortraitOrientation(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.orientation == Orientation.portrait;
  }

  static void setFullscreen(bool enable) {
    // Handle setting fullscreen mode responsibly
    if (enable) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getPixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  static double getStatusBarHeight(BuildContext context) {
    // Handle potential issues with Get dependency if used
    return MediaQuery.of(context).padding.top;
  }
}
