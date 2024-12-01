import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PdfListScreen extends StatefulWidget {
  final String std;
  final String subject;
  final String book;
  final bool isSolutions;

  const PdfListScreen({
    super.key,
    required this.std,
    required this.subject,
    required this.book,
    required this.isSolutions,
  });

  @override
  State<PdfListScreen> createState() => _PdfListScreenState();
}

class _PdfListScreenState extends State<PdfListScreen> {
  Future<List<Map<String, String>>> getPdfFiles(String folderPath) async {
    final storageRef = FirebaseStorage.instance.ref().child(folderPath);
    final listResult = await storageRef.listAll();

    // Extract PDF file information
    final pdfFiles = await Future.wait(listResult.items
        .where((item) => item.name.toLowerCase().endsWith('.pdf'))
        .map((item) async {
      final url =
          await item.getDownloadURL();
      final downloadUrl = await item
          .getDownloadURL();
      return {
        'name': item.name,
        'url': url,
        'downloadUrl': downloadUrl,
      };
    }).toList());

    return pdfFiles;
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
          widget.isSolutions ? '${widget.book} Solutions' : widget.book,
          style: const TextStyle(
            fontSize: 20,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: getPdfFiles(widget.isSolutions
            ? '${widget.std}/${widget.subject}/${widget.book}/Solutions'
            : '${widget.std}/${widget.subject}/${widget.book}'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No PDF files found.'));
          } else {
            final pdfFiles = snapshot.data!;
            return ListView.builder(
              itemCount: pdfFiles.length,
              itemBuilder: (context, index) {
                final pdf = pdfFiles[index];
                return Card(
                  child: ListTile(
                    onTap: () {},
                    leading:
                        const Icon(Icons.picture_as_pdf, color: Colors.red),
                    title: Text(
                      pdf['name']!.split('.').first,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      onPressed: () {},
                      tooltip: 'Download',
                      icon: const Icon(Icons.file_download_outlined),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
