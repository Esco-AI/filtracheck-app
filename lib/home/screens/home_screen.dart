import 'package:flutter/material.dart';
import '../widgets/feature_panel.dart';
import '../widgets/about_card.dart';
import '../widgets/news_card.dart';
import '../../widgets/bottom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Changed to white
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Home',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.blue, // Changed to blue
          ),
        ),
      ),
      body: const _HomeTab(),
      bottomNavigationBar: const AppBottomNav(activeIndex: 0),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 112, 16, 16),
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
            color: Colors.black87, // Changed for visibility on white
            fontWeight: FontWeight.w800,
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
