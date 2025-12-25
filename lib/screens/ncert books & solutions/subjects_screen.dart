import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../main.dart';
import '../../constants.dart';
import 'chapters_screen.dart';
import 'chapters_solution_screen.dart';

class SubjectsScreen extends StatelessWidget {
  final String std;

  const SubjectsScreen({super.key, required this.std});

  Future<List<Map<String, dynamic>>> _getSubjects() async {
    final subCollectionSnapshot = await FirebaseFirestore.instance
        .collection('NCERT Books')
        .doc(std)
        .collection(Constants.isExemplar ? 'Exemplar' : 'Subjects')
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
          title: Text(Constants.isEng
              ? 'Class ${int.parse(std)}'
              : 'कक्षा ${int.parse(std)}')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getSubjects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No subjects found.'));
          } else {
            final subjects = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 220,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final subject = subjects[index];
                final subjectName = subject[Constants.isEng ? 'eng' : 'hin'];
                final subjectCode = subject[Constants.isExemplar
                    ? 'img'
                    : Constants.isEng
                        ? 'engKey'
                        : 'hinKey'];
                String imageUrl =
                    '${Constants.ncertBaseUrl}${subjectCode}cc.jpg';
                return InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => Navigator.of(context).push(
                    CupertinoPageRoute(
                        builder: (ctx) => Constants.isSolutions
                            ? ChaptersSolutionScreen(
                                std: std,
                                subjectName: subject['eng'],
                              )
                            : ChaptersScreen(
                                std: std,
                                subjectId: subject['id'],
                                subjectName: subjectName,
                                subjectCode: subjectCode,
                              )),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: imageUrl,
                            width: (mq.width - 30) / 2,
                            height: 175,
                            fit: BoxFit.fill,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          subjectName,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                      ],
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
