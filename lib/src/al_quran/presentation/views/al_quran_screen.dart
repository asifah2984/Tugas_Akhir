import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/resources/colours.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:alquran_app/src/al_quran/presentation/refactors/bookmark_tab_view.dart';
import 'package:alquran_app/src/al_quran/presentation/refactors/juz_tab_view.dart';
import 'package:alquran_app/src/al_quran/presentation/refactors/surah_tab_view.dart';
import 'package:alquran_app/src/al_quran/presentation/widgets/last_read_card.dart';
import 'package:flutter/material.dart';

class AlQuranScreen extends StatelessWidget {
  const AlQuranScreen({super.key});

  static const path = 'alquran';
  static const name = 'alquran';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorScheme.primary,
        title: Text(
          'AL QURAN',
          style: Typographies.bold16.copyWith(
            color: context.colorScheme.onPrimary,
          ),
        ),
        foregroundColor: context.colorScheme.onPrimary,
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Assalamualaikum',
                    style: Typographies.bold16.copyWith(
                      color: context.colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const LastReadCard(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TabBar(
                dividerColor: Colors.grey.shade300,
                unselectedLabelColor: Colours.greyText,
                labelColor: context.colorScheme.secondary,
                tabs: const [
                  Tab(text: 'Surah'),
                  Tab(text: 'Juz'),
                  Tab(text: 'Bookmark'),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  SurahTabView(),
                  JuzTabView(),
                  BookmarkTabView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
