import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../widgets/glass_container.dart';

class HomeOtherBooksGrid extends StatelessWidget {
  const HomeOtherBooksGrid({super.key});

  Future<List<Map<String, dynamic>>> fetchCategories() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Other Books').get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      throw Exception('$e');
    }
  }

  void _selectCategory(BuildContext ctx, Map<String, dynamic> category) {
    // Navigator.of(ctx).push(
    //     CupertinoPageRoute(builder: (ctx) => AllClasses(category: category)));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchCategories(),
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
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: categories.length < 6 ? categories.length : 6,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => _selectCategory(context, categories[index]),
              borderRadius: BorderRadius.circular(30),
              child: GlassContainer.boxGlassContainer(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // CachedNetworkImage(
                  //   imageUrl: categories[index]['url'],
                  //   width: 40,
                  // ),
                  Text(
                    categories[index]['name'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )),
            );
          },
        );
      },
    );
  }
}
