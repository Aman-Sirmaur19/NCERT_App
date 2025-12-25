import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/glass_container.dart';
import '../widgets/main_drawer.dart';
import 'cbse/cbse_grid.dart';
import 'cbse/home_cbse_grid.dart';
import 'icse - isc/home_icse_grid.dart';
import 'icse - isc/icse_grid.dart';
import 'other books/home_books_and_solutions_grid.dart';
import 'other books/books_and_solutions_grid.dart';
import 'youtube tutorials/home_youtube_tutorials_grid.dart';
import 'youtube tutorials/youtube_tutorials_grid.dart';
import 'ncert books & solutions/ncert_books_&_solutions_grid.dart';
import 'ncert books & solutions/home_ncert_books_&_solutions_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      drawer: const MainDrawer(),
      body: const Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        GlassContainer.stylishGlassContainer(
          topRight: 0,
          bottomLeft: 0,
          children: [
            _customRow(
                title: 'NCERT Books & Solutions',
                context: context,
                onPressed: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) =>
                            const NcertBooksAndSolutionsGrid()))),
            const HomeNcertBooksAndSolutionsGrid(),
          ],
        ),
        const SizedBox(height: 20),
        GlassContainer.stylishGlassContainer(
          topRight: 0,
          bottomLeft: 0,
          children: [
            _customRow(
                title: 'CBSE',
                context: context,
                onPressed: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const CbseGrid()))),
            const HomeCbseGrid(),
          ],
        ),
        const SizedBox(height: 20),
        GlassContainer.stylishGlassContainer(
          topRight: 0,
          bottomLeft: 0,
          children: [
            _customRow(
                title: 'ICSE - ISC',
                context: context,
                onPressed: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const IcseGrid()))),
            const HomeIcseGrid(),
          ],
        ),
        const SizedBox(height: 20),
        GlassContainer.stylishGlassContainer(
          topLeft: 0,
          bottomRight: 0,
          children: [
            _customRow(
                title: 'Books & Solutions',
                context: context,
                onPressed: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const BooksAndSolutionsGrid()))),
            const HomeBooksAndSolutionsGrid(),
          ],
        ),
        const SizedBox(height: 20),
        GlassContainer.stylishGlassContainer(
          topRight: 0,
          bottomLeft: 0,
          children: [
            _customRow(
                title: 'Youtube Tutorials',
                context: context,
                onPressed: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const YoutubeTutorialsGrid()))),
            const HomeYoutubeTutorialsGrid(),
          ],
        ),
      ],
    );
  }

  Widget _customRow({
    required String title,
    required BuildContext context,
    required void Function()? onPressed,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text("Show All",
              style: TextStyle(fontSize: 13, color: Colors.blue)),
        )
      ],
    );
  }
}
