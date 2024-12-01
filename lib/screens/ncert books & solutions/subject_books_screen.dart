import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'pdf_list_screen.dart';
import 'pdfs_screen.dart';

class SubjectBooksScreen extends StatelessWidget {
  final String std;
  final String subject;
  final bool isSolutions;

  const SubjectBooksScreen({
    super.key,
    required this.std,
    required this.subject,
    required this.isSolutions,
  });

  Future<List<String>> getBooks() async {
    final storageRef = FirebaseStorage.instance.ref().child('$std/$subject');
    final listResult = await storageRef.listAll();
    final booksName =
        listResult.prefixes.map((folderRef) => folderRef.name).toList();
    return booksName;
  }

  void _selectBook(BuildContext ctx, String book) {
    Navigator.of(ctx).push(CupertinoPageRoute(
        builder: (ctx) => PdfListScreen(
            std: std, subject: subject, book: book, isSolutions: isSolutions)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            tooltip: 'Back',
            icon: const Icon(CupertinoIcons.chevron_back),
          ),
          title: Text(
            '$subject ($std)',
            style: const TextStyle(
              fontSize: 20,
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
            ),
          )),
      body: FutureBuilder<List<String>>(
        future: getBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No books found.'));
          } else {
            final books = snapshot.data!;
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(books[index]),
                  leading: const Icon(CupertinoIcons.book),
                  onTap: () => _selectBook(context, books[index]),
                );
              },
            );
          }
        },
      ),
    );
  }
}
