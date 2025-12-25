import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../constants.dart';
import '../pdf_viewer_screen.dart';

class ChaptersSolutionScreen extends StatefulWidget {
  final String std;
  final String subjectName;

  const ChaptersSolutionScreen({
    super.key,
    required this.std,
    required this.subjectName,
  });

  @override
  State<ChaptersSolutionScreen> createState() => _ChaptersSolutionScreenState();
}

class _ChaptersSolutionScreenState extends State<ChaptersSolutionScreen> {
  Future<List<Map<String, String>>> _getPdfFiles(String folderPath) async {
    final storageRef = FirebaseStorage.instance.ref().child(folderPath);
    final listResult = await storageRef.listAll();

    // Extract PDF file information
    final pdfFiles = await Future.wait(listResult.items
        .where((item) => item.name.toLowerCase().endsWith('.pdf'))
        .map((item) async {
      final url = await item.getDownloadURL();
      final downloadUrl = await item.getDownloadURL();
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
        title: Text('${widget.subjectName} Solutions'),
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: _getPdfFiles(Constants.isExemplar
            ? '${widget.std}/${widget.subjectName}/Exemplar'
            : '${widget.std}/${widget.subjectName}'),
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
                    onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => PdfViewerScreen(
                                  isDownloaded: false,
                                  pdfName: pdf['name']!
                                      .split('.')
                                      .first
                                      .split(') ')
                                      .last,
                                  pdfUrl: pdf['url']!,
                                ))),
                    leading:
                        const Icon(Icons.picture_as_pdf, color: Colors.red),
                    title: Text(
                      pdf['name']!.split('.').first,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
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
