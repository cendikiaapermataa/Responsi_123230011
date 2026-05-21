import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/notification_service.dart';

class AuthController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordHidden = true.obs;

  // --- HARDCODE PASSWORD DENGAN 3 DIGIT TERAKHIR NIM KAMU ---
  final String nimPassword = "011"; // GANTI DENGAN 3 DIGIT TERAKHIR NIM KAMU!

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void login() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

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

    // 3. Validasi: Password harus 3 digit terakhir NIM (+2 poin)
    if (password == nimPassword) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);

      // Notifikasi sukses login
      NotificationService.showSuccess(
        "Login Berhasil",
        "Selamat datang kembali, $username! 💕",
      );

      Get.offAllNamed('/main'); // Berhasil, arahkan ke Halaman Utama
    } else {
      NotificationService.showError(
        "Login Gagal",
        "Password harus 3 digit terakhir NIM!",
      );
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}