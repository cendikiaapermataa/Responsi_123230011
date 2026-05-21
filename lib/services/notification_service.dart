import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationService {
  // Inisialisasi tidak wajib jika kita hanya menggunakan Get.snackbar
  static Future<void> init() async {
    // placeholder: jika nanti ingin menambahkan notifikasi sistem, implementasikan di sini
    return;
  }

  static void showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red.shade400,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
    );
  }

  static void showSuccess(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green.shade400,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
    );
  }

  static Future<void> showImmediateNotification({
    required String title,
    required String body,
  }) async {
    // Fallback ke snackbar untuk environment tanpa plugin notifikasi
    Get.snackbar(
      title,
      body,
      backgroundColor: Colors.blue.shade400,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
    );
  }
}
