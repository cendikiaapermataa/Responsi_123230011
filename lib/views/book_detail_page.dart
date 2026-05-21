import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/book.dart';

class BookDetailPage extends StatelessWidget {
  const BookDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Menerima data dari list yang di-klik
    final Book book = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Book', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.pink[300],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Area Gambar Karakter
            Container(
              height: 200,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: book.coverImage.isNotEmpty
                    ? Image.network(book.coverImage, fit: BoxFit.cover)
                    : Container(
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.book,
                          size: 80,
                          color: Colors.grey,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 24),

            // Text Nama Utama
            Text(
              book.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Kotak-kotak properti (Sesuai Poin 2 PDF)
            _buildInfoCard('Subtitle', book.subtitle),
            _buildInfoCard('Deskripsi', book.description),
            _buildInfoCard(
              'Penulis',
              book.authors.isNotEmpty ? book.authors.join(', ') : '-',
            ),
            _buildInfoCard('Penerbit', book.publisher),
            _buildInfoCard('Tanggal Terbit', book.publishedDate),
            _buildInfoCard('ISBN', book.isbn),
            _buildInfoCard('Jumlah Halaman', book.pageCount),
          ],
        ),
      ),
    );
  }

  // Fungsi pembantu agar kodingan kotak tidak diulang-ulang
  Widget _buildInfoCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120,
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 184, 23, 93),
                ),
              ),
            ),
            const Text(':  '),
            Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
          ],
        ),
      ),
    );
  }
}
