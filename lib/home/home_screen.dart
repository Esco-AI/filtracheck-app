import 'package:flutter/material.dart';
import 'widgets/feature_panel.dart';
import 'widgets/about_card.dart';
import 'widgets/news_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: const _HomeTab(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (i) {
          if (i == 0) {
            // Home
          }
          // i == 1 would normally be About, but disabled for now
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_rounded),
            label: 'About',
          ),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        FeaturePanel(),
        SizedBox(height: 16),
        AboutCard(),
        SizedBox(height: 16),
        _NewsfeedSection(),
      ],
    );
  }
}

class _NewsfeedSection extends StatelessWidget {
  const _NewsfeedSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Newsfeed',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: const Color(0xFF1E88E5),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        // Sample cards
        const NewsCard(),
        const SizedBox(height: 12),
        const NewsCard(),
        const SizedBox(height: 12),
        const NewsCard(),
      ],
    );
  }
}