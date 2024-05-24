import 'package:get/get.dart';
import 'package:webbrains_task/controller/user_controller.dart';

class UserBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserController());
  }
}
