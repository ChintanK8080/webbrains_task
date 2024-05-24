import 'package:get/get.dart';
import 'package:webbrains_task/view/screen/home_screen.dart';
import 'package:webbrains_task/view/screen/login_screen.dart';
import 'package:webbrains_task/view/screen/signup_screen.dart';
import 'package:webbrains_task/view/screen/splash_screen.dart';

import 'bindings.dart';

final routes = [
  GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
      binding: UserBindings()),
  GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: UserBindings()),
  GetPage(
      name: Routes.signup,
      page: () => const SignUpPage(),
      binding: UserBindings()),
  GetPage(
    name: Routes.home,
    page: () => const HomePage(),
    binding: UserBindings(),
  ),
];

class Routes {
  static const splash = "/";
  static const login = "/login";
  static const signup = "/signup";
  static const home = "/home";
}
