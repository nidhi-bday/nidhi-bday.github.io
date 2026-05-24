import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileSelectPage extends StatelessWidget {
  const ProfileSelectPage({super.key});

  Widget _buildProfile(BuildContext context, String name, String imagePath) {
    return GestureDetector(
      onTap: () {
        // When a profile is tapped, navigate to the home screen (replace stack)
        Navigator.of(context).pushReplacementNamed('/home');
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Top-left Netflix logo
            Positioned(left: 16, top: 16, child: SvgPicture.asset('assets/netflix_logo.svg', width: 150)),

            // Center content
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Profiles grid (2x2)
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 32,
                    runSpacing: 24,
                    children: [
                      _buildProfile(context, 'Bub', 'assets/nidhi/profile/2.jpg'),
                      _buildProfile(context, 'nini', 'assets/nidhi/profile/3.jpg'),
                      _buildProfile(context, 'nidhi', 'assets/nidhi/profile/4.jpg'),
                      _buildProfile(context, 'chimu', 'assets/nidhi/profile/5.jpg'),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // White rectangle button (no rounded corners)
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/home');
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 14),
                    ),
                    child: const Text('Manage Profile', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
