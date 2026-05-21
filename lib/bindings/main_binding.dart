import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import '../controllers/book_controller.dart';
import '../controllers/spell_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
    Get.lazyPut(() => BookController());
    Get.lazyPut(() => SpellController());
  }
}