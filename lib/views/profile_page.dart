import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainCtrl = Get.find<MainController>();

    return Scaffold(
      appBar: AppBar(title: const Text("My Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CircleAvatar(
              radius: 50, 
              backgroundColor: Colors.pinkAccent, 
              child: Icon(Icons.person, size: 50, color: Colors.white)
            ),
            const SizedBox(height: 16),
            Obx(() => Text(mainCtrl.username.value, textAlign: TextAlign.center, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
            const SizedBox(height: 32),
            
            _buildTextBox("Kesan", "Prak ini jujur keren si, jadi tau gmn cara buat app kaya versi hp gitu"),
            _buildTextBox("Pesan", "semoga dpt A, plis kasih aku A, semoga asslab nya ipk 4 atau cumlaud 3 tahun lulus makjos."),
            _buildTextBox("Kritik & Saran", "gada si, seru seru aja, tpi soalnya bikin bingung trimsi"),
            
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                Get.defaultDialog(
                  title: "Konfirmasi", titleStyle: const TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold),
                  middleText: "Apakah Anda yakin ingin logout?",
                  textCancel: "Batal", textConfirm: "Logout",
                  confirmTextColor: Colors.white, cancelTextColor: Colors.pinkAccent, buttonColor: Colors.pinkAccent,
                  onConfirm: () { Get.back(); mainCtrl.logout(); },
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text("Logout", style: TextStyle(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink.shade50, foregroundColor: Colors.pinkAccent,
                padding: const EdgeInsets.all(16), elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextBox(String title, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.pink.shade50)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.pinkAccent, fontSize: 16)),
          const SizedBox(height: 8),
          Text(content, style: const TextStyle(color: Colors.black87, height: 1.5)),
        ],
      ),
    );
  }
}