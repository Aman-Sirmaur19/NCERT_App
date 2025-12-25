import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'tab_screen.dart';
import '../../widgets/glass_container.dart';
import 'subjects_screen.dart';

class AllClasses extends StatelessWidget {
  final Map<String, dynamic> category;

  const AllClasses({super.key, required this.category});

  // bool isBannerLoaded = false;

  @override
  Widget build(BuildContext context) {
    Constants.isExemplar = category['name']?.contains('Exemplar') ?? false;
    Constants.isSolutions = category['name']?.contains('Solutions') ?? false;

    final Map<String, dynamic> classes = {
      '01': Colors.blue,
      '02': Colors.pink,
      '03': Colors.green,
      '04': Colors.red,
      '05': Colors.yellow,
      '06': Colors.cyan,
      '07': Colors.purple,
      '08': Colors.lightGreen,
      '09': Colors.amber,
      '10': Colors.orange,
      '11': Colors.brown,
      '12': Colors.lightGreenAccent,
    };
    final filteredEntries = Constants.isExemplar
        ? classes.entries.where((entry) => int.parse(entry.key) > 5).toList()
        : classes.entries.toList();
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              tooltip: 'Back',
              icon: const Icon(CupertinoIcons.chevron_back),
            ),
            title: Text(category['name'])),
        // bottomNavigationBar: isBannerLoaded
        //     ? SizedBox(height: 50, child: AdWidget(ad: bannerAd))
        //     : const SizedBox(),
        body: GridView.builder(
          padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemCount: filteredEntries.length,
          itemBuilder: (context, index) {
            final entry = filteredEntries[index];
            return InkWell(
              onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                  builder: (ctx) => Constants.isSolutions
                      ? SubjectsScreen(std: entry.key)
                      : TabScreen(std: entry.key))),
              borderRadius: BorderRadius.circular(60),
              child: GlassContainer.circularGlassContainer(
                color: entry.value,
                child: Text(
                  'Class ${int.parse(entry.key)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        ));
  }
}
