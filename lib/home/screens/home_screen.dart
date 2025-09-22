import 'package:flutter/material.dart';
import '../../chemical_dictionary/widgets/gradient_background.dart';
import '../widgets/feature_panel.dart';
import '../widgets/about_card.dart';
import '../widgets/news_card.dart';
import '../../widgets/bottom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        // Frosted top bar feel
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: const Alignment(0, -1.2),
              end: const Alignment(0, 1),
              colors: [
                Colors.black.withValues(alpha: 0.25),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
      body: const _HomeTab(),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const GradientBackground(),
        ListView(
          padding: const EdgeInsets.fromLTRB(16, 112, 16, 16),
          children: const [
            FeaturePanel(),
            SizedBox(height: 16),
            AboutCard(),
            SizedBox(height: 16),
            _NewsfeedSection(),
          ],
        ),
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
            color: Colors.white,
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
