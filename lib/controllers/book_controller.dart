import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class BookController extends GetxController {
  final RxList<Book> booksList = <Book>[].obs;
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
      // Try the assignment-specified URL first, then a known alternative
      final urls = [
        'https://potterapifedeperin.vercel.app/en/books',
        'https://potterapi-fedeperin.vercel.app/en/books',
      ];
      http.Response? response;
      for (final u in urls) {
        try {
          response = await http.get(Uri.parse(u));
          if (response.statusCode == 200) break;
        } catch (_) {
          response = null;
        }
      }

      if (response != null && response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        booksList.assignAll(data.map((e) => Book.fromJson(e)).toList());
        if (data.isNotEmpty) {
          // Print sample object for debugging field names
          // ignore: avoid_print
          print('fetchBooks sample: ${data[0]}');
        }
      } else {
        final code = response?.statusCode ?? 0;
        final body = response?.body ?? 'no response';
        Get.snackbar('Error', 'Gagal mengambil data buku (status $code)');
        // also print body to console for debugging
        // ignore: avoid_print
        print('fetchBooks failed: status=$code body=$body');
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil data book: ${e.toString()}');
      // ignore: avoid_print
      print('fetchBooks exception: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
