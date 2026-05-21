import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/notification_service.dart';

class AuthController extends GetxController {
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  var isPasswordHidden = true.obs;
  final RxBool isLoading = false.obs;

  // --- HARDCODE PASSWORD DENGAN 3 DIGIT TERAKHIR NIM KAMU ---
  final String nimPassword = "011"; // GANTI DENGAN 3 DIGIT TERAKHIR NIM KAMU!

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void login() async {
    String username = usernameCtrl.text.trim();
    String password = passwordCtrl.text.trim();

    // 1. Validasi: Username dan password tidak boleh kosong (+4 poin)
    if (username.isEmpty || password.isEmpty) {
      NotificationService.showError(
        "Error",
        "Username dan password tidak boleh kosong!",
      );
      return;
    }

    // 2. Validasi: Username minimal harus 5 karakter (+2 poin)
    if (username.length < 5) {
      NotificationService.showError(
        "Error",
        "Username minimal harus 5 karakter!",
      );
      return;
    }

    isLoading.value = true;

    // 3. Validasi: Password harus 3 digit terakhir NIM (+2 poin)
    await Future.delayed(const Duration(milliseconds: 300));
    if (password == nimPassword) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);

      // Notifikasi sukses login
      NotificationService.showSuccess(
        "Login Berhasil",
        "Selamat datang kembali, $username! 💕",
      );

      isLoading.value = false;
      Get.offAllNamed('/main'); // Berhasil, arahkan ke Halaman Utama
    } else {
      isLoading.value = false;
      NotificationService.showError(
        "Login Gagal",
        "Password harus 3 digit terakhir NIM!",
      );
    }
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    Get.offAllNamed('/login');
  }

  @override
  void onClose() {
    usernameCtrl.dispose();
    passwordCtrl.dispose();
    super.onClose();
  }
}
