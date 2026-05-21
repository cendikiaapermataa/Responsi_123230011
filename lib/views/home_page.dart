import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/book_controller.dart';
import '../controllers/main_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainCtrl = Get.find<MainController>();
    final bookCtrl = Get.find<BookController>();

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text("Halo, ${mainCtrl.username.value}! 👋")),
        backgroundColor: Colors.pink.shade100,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Get.toNamed('/cart'),
          ),
        ],
      ),
      body: Obx(() {
        // Animasi ketika data sedang loading (+5 poin)
        if (bookCtrl.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
            ),
          );
        }

        if (bookCtrl.booksList.isEmpty) {
          return const Center(child: Text("Tidak ada data buku."));
        }

        // List card yang berisi highlight informasi dari API (+5 poin)
        return ListView.builder(
          itemCount: bookCtrl.booksList.length,
          itemBuilder: (context, index) {
            final book = bookCtrl.booksList[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                title: Text(
                  book.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                leading: book.coverImage.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          book.coverImage,
                          width: 50,
                          height: 70,
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) =>
                              const Icon(Icons.book, size: 50),
                        ),
                      )
                    : const Icon(Icons.book, size: 50, color: Colors.grey),

                // Detailed subtitle with authors, id, released, pages
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (book.authors.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        'By ${book.authors.join(', ')}',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13,
                        ),
                      ),
                    ],
                    const SizedBox(height: 6),
                    Text(
                      "ID: ${book.isbn}",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Released: ${book.publishedDate}",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.menu_book,
                          color: Colors.pink,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "Pages: ${book.pageCount}",
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                isThreeLine: true,
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.pink,
                ),
                onTap: () {
                  // Navigasi ke Detail Page jika card ditekan (+5 poin)
                  Get.toNamed('/detail', arguments: book);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
