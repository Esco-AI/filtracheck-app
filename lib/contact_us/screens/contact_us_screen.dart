import 'package:flutter/material.dart';

import '../../widgets/bottom_navigation_bar.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> locations = [
      'Philippines',
      'Singapore',
      'Indonesia',
      'USA',
      'United Kingdom',
    ];
    String? selectedLocation = 'Singapore';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.blue),
        title: const Text(
          'Contact Us',
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.blue),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: const LinearGradient(
              colors: [Color(0xFF3AADEA), Color(0xFF0D7AC8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  'assets/images/esco-hq.webp',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                '21 Changi South Street 1, Singapore 486777',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 24),

              const Text(
                'Other Locations',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: DropdownButtonFormField<String>(
                  initialValue: selectedLocation,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
                  decoration: const InputDecoration(border: InputBorder.none),
                  items: locations.map((String location) {
                    return DropdownMenuItem<String>(
                      value: location,
                      child: Text(
                        location,
                        style: const TextStyle(color: Colors.black87),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {},
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Social Media',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialIcon(Icons.facebook),
                  const SizedBox(width: 16),
                  _buildSocialIcon(
                    Icons.camera_alt,
                  ), // Placeholder for Twitter/X
                  const SizedBox(width: 16),
                  _buildSocialIcon(
                    Icons.play_circle_fill,
                  ), // Placeholder for YouTube
                  const SizedBox(width: 16),
                  _buildSocialIcon(Icons.business), // Placeholder for LinkedIn
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: const Color(0xFF0D7AC8), size: 30),
    );
  }
}
