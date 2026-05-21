import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class BookController extends GetxController {
  final RxList<Book> books = <Book>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Dihapus dari onInit agar tidak bertabrakan dengan animasi perpindahan layar
  }

  @override
  void onReady() {
    super.onReady();
    // onReady dipanggil ketika tampilan widget selesai dirender ke layar.
    // Beri jeda kecil ekstra untuk memastikan transisi layar Get.offAllNamed benar-benar selesai
    Future.delayed(const Duration(milliseconds: 200), () {
      fetchBooks();
    });
  }

  Future<void> fetchBooks() async {
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse('https://potterapifedeperin.vercel.app/en/books'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        books.assignAll(data.map((e) => Book.fromJson(e)).toList());
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil data book');
    } finally {
      isLoading.value = false;
    }
  }
}