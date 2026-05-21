import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/main_controller.dart';
import '../controllers/book_controller.dart';
import '../controllers/spell_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => MainController());
    Get.lazyPut(() => BookController());
    Get.lazyPut(() => SpellController());
  }
}