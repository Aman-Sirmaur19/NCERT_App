import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'subject_books_screen.dart';

class SubjectsScreen extends StatelessWidget {
  final String std;
  final bool isSolutions;

  const SubjectsScreen({
    super.key,
    required this.std,
    required this.isSolutions,
  });

  Future<List<String>> getSubjects() async {
    final storageRef = FirebaseStorage.instance.ref().child(std);
    final listResult = await storageRef.listAll();
    final subjectsName =
        listResult.prefixes.map((folderRef) => folderRef.name).toList();
    return subjectsName;
  }

  void _selectSubject(BuildContext ctx, String subject) {
    Navigator.of(ctx).push(CupertinoPageRoute(
        builder: (ctx) => SubjectBooksScreen(
            std: std, subject: subject, isSolutions: isSolutions)));
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
            'Class $std',
            style: const TextStyle(
              fontSize: 20,
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
            ),
          )),
      body: FutureBuilder<List<String>>(
        future: getSubjects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No subjects found.'));
          } else {
            final subjects = snapshot.data!;
            return ListView.builder(
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(subjects[index]),
                  leading: const Icon(Icons.folder),
                  onTap: () => _selectSubject(context, subjects[index]),
                );
              },
            );
          }
        },
      ),
    );
  }
}
