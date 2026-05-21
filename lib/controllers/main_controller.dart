import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_controller.dart';

class MainController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final RxString username = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUsername();
  }

  void _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('username') ?? '';
  }

  void changeTab(int index) {
    currentIndex.value = index;
  }

  void logout() async {
    try {
      final AuthController auth = Get.find<AuthController>();
      auth.logout();
      return;
    } catch (_) {}

    // Fallback: langsung clear prefs and go to login
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    Get.offAllNamed('/login');
  }
}
