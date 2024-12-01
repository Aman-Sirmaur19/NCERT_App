import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';
import 'ncert books & solutions/ncert_books_&_solutions_grid.dart';
import 'ncert books & solutions/home_ncert_books_&_solutions_grid.dart';
import 'other books/home_other_books_grid.dart';
import 'other books/other_books_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Home',
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
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
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      children: [
        _customRow(
            title: 'NCERT Books & Solutions',
            context: context,
            onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => const NcertBooksAndSolutionsGrid()))),
        const HomeNcertBooksAndSolutionsGrid(),
        const SizedBox(height: 20),
        _customRow(
            title: 'Other Books',
            context: context,
            onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => const OtherBooksGrid()))),
        const HomeOtherBooksGrid(),
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
