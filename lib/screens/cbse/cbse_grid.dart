import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../widgets/glass_container.dart';

class CbseGrid extends StatefulWidget {
  const CbseGrid({super.key});

  @override
  State<CbseGrid> createState() => _CbseGridState();
}

class _CbseGridState extends State<CbseGrid> {
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
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('CBSE').get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  void _selectClass(BuildContext ctx, Map<String, dynamic> categories) {
    // Navigator.of(ctx).push(CupertinoPageRoute(
    //     builder: (ctx) => PdfScreen(categories: categories)));
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
          title: const Text('CBSE')),
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
                onTap: () => _selectClass(context, categories[index]),
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
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
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
