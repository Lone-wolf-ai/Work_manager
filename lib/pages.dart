import 'package:get/get.dart';
import 'app/modules/auth/emailvarification/emailverificationscreen.dart';
import 'app/modules/auth/forgotPass/forgot_screen.dart';
import 'app/modules/auth/login/login_screen.dart';
import 'app/modules/auth/register/register_screen.dart';
import 'app/modules/onboarding/onboarding_screen.dart';
import 'app/modules/user/attendance/attendance_view.dart';
import 'app/modules/user/home/home_view.dart';
import 'app/modules/user/notice/notice_list.dart';
import 'app/modules/user/notice/notice_view.dart';
import 'app/modules/user/profile/profile_view.dart';
import 'app/modules/user/task/task_view.dart';
import 'app/modules/user/task/widget/completedtasks.dart';
import 'app/modules/user/task/widget/reviewingtask.dart';

class  AppPages {
  static List<GetPage> pages=[
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/register', page: () => const RegisterScreen()),
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/emailver', page: () => const Emailverificationscreen()),
        GetPage(name: '/forgot', page: () => const ForgotPasswordScreen()),
        GetPage(name: '/profile', page: () => const ProfileView()),
        GetPage(name: '/notice_list', page: () => const NoticeList()),
        GetPage(name: '/notice_view', page: () => const NoticeView()),
        GetPage(name: '/task-manager', page: () => const TaskView()),
        GetPage(name: '/review', page: () => const Reviewingtask()),
        GetPage(name: '/completed', page: () => const CompletedTasks()),
        GetPage(name: '/attendance_view', page: () => const AttendanceView()),
        GetPage(name: '/onboard', page: () => const OnboardingScreen())
      ];
}