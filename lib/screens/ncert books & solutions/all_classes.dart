import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/glass_container.dart';
import 'subjects_screen.dart';

class AllClasses extends StatelessWidget {
  final Map<String, dynamic> category;

  const AllClasses({super.key, required this.category});

  // bool isBannerLoaded = false;

  void _selectClass(BuildContext ctx, String std) {
    bool isSolutions = false;
    if (category['name'] == 'NCERT Solutions') isSolutions = true;
    Navigator.of(ctx).push(CupertinoPageRoute(
        builder: (ctx) => SubjectsScreen(std: std, isSolutions: isSolutions)));
  }

  @override
  Widget build(BuildContext context) {
    final List classes = [
      'I',
      'II',
      'III',
      'IV',
      'V',
      'VI',
      'VII',
      'VIII',
      'IX',
      'X',
      'XI',
      'XII',
    ];
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              tooltip: 'Back',
              icon: const Icon(CupertinoIcons.chevron_back),
            ),
            title: Text(
              category['name'],
              style: const TextStyle(
                fontSize: 20,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
              ),
            )),
        // bottomNavigationBar: isBannerLoaded
        //     ? SizedBox(height: 50, child: AdWidget(ad: bannerAd))
        //     : const SizedBox(),
        body: GridView.builder(
          padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemCount: classes.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => _selectClass(context, classes[index]),
              borderRadius: BorderRadius.circular(60),
              child: GlassContainer.circularGlassContainer(
                  child: Text(classes[index])),
            );
          },
        ));
  }
}
