import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants.dart';
import '../pdf_viewer_screen.dart';

class ChaptersScreen extends StatelessWidget {
  final String std;
  final String subjectId;
  final String subjectName;
  final String subjectCode;

  const ChaptersScreen({
    super.key,
    required this.std,
    required this.subjectId,
    required this.subjectName,
    required this.subjectCode,
  });

  Future<List<Map<String, dynamic>>> _getChapters() async {
    final subCollectionSnapshot = await FirebaseFirestore.instance
        .collection('NCERT Books')
        .doc(std)
        .collection('Subjects')
        .doc(subjectId)
        .collection('Chapters')
        .get();
    return subCollectionSnapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
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
          title: Text('$subjectName ($std)')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getChapters(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No chapters found.'));
          } else {
            final chapters = snapshot.data!;
            return ListView.builder(
              itemCount: chapters.length,
              itemBuilder: (context, index) {
                final chapter = chapters[index];
                final chapterNo = chapter['id'];
                String pdfUrl = Constants.isExemplar
                    ? '${Constants.exemplarBaseUrl}$subjectCode$chapterNo.pdf'
                    : '${Constants.ncertBaseUrl}$subjectCode$chapterNo.pdf';
                log(pdfUrl);
                return Card(
                  child: ListTile(
                    onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => PdfViewerScreen(
                                  isDownloaded: false,
                                  pdfName:
                                      chapter[Constants.isEng ? 'eng' : 'hin'],
                                  pdfUrl: pdfUrl,
                                ))),
                    leading: CircleAvatar(
                      child: Text(
                        '${int.parse(chapterNo)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    title: Text(
                      chapter[Constants.isEng ? 'eng' : 'hin'],
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
