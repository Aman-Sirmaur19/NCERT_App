import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../widgets/glass_container.dart';
import 'all_classes.dart';

class NcertBooksAndSolutionsGrid extends StatefulWidget {
  const NcertBooksAndSolutionsGrid({super.key});

  @override
  State<NcertBooksAndSolutionsGrid> createState() =>
      _NcertBooksAndSolutionsGridState();
}

class _NcertBooksAndSolutionsGridState
    extends State<NcertBooksAndSolutionsGrid> {
  // bool isBannerLoaded = false;
  // late BannerAd bannerAd;

  // initializeBannerAd() async {
  //   bannerAd = BannerAd(
  //     size: AdSize.banner,
  //     adUnitId: 'ca-app-pub-9389901804535827/8331104249',
  //     listener: BannerAdListener(
  //       onAdLoaded: (ad) {
  //         setState(() {
  //           isBannerLoaded = true;
  //         });
  //       },
  //       onAdFailedToLoad: (ad, error) {
  //         ad.dispose();
  //         isBannerLoaded = false;
  //       },
  //     ),
  //     request: const AdRequest(),
  //   );
  //   bannerAd.load();
  // }

  Future<List<Map<String, dynamic>>> fetchAllBranches() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('NCERT Books & Solutions')
          .get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // initializeBannerAd();
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
          title: const Text('NCERT Books & Solutions')),
      // bottomNavigationBar: isBannerLoaded
      //     ? SizedBox(height: 50, child: AdWidget(ad: bannerAd))
      //     : const SizedBox(),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchAllBranches(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No categories found.'));
          }

          final categories = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                    builder: (ctx) => AllClasses(category: categories[index]))),
                borderRadius: BorderRadius.circular(30),
                child: GlassContainer.boxGlassContainer(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // CachedNetworkImage(
                    //   imageUrl: branches[index]['url'],
                    //   width: 40,
                    // ),
                    Text(
                      categories[index]['name'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
              );
            },
          );
        },
      ),
    );
  }
}
