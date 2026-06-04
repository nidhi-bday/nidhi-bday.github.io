import 'package:birthday_website/widgets/message_carousel.dart';
import 'package:flutter/material.dart';
import '../data/content_data.dart';
import '../widgets/hero_banner.dart';
import '../widgets/movie_row.dart';
import '../widgets/navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _darken = false;

  void _onScroll(double offset) {
    final shouldDarken = offset > 12.0;
    if (shouldDarken != _darken) setState(() => _darken = shouldDarken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141414),
      appBar: const PreferredSize(preferredSize: Size.fromHeight(56), child: SizedBox.shrink()),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.axis == Axis.vertical) {
            _onScroll(notification.metrics.pixels);
          }
          return false;
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeroBanner(item: ContentData.featured),
                  const SizedBox(height: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "From Loved Ones",
                          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ),

                      BirthdayMessagesCarousel(messages: messages),
                    ],
                  ),
                  for (final entry in ContentData.rows.entries) MovieRow(title: entry.key, items: entry.value),
                  const SizedBox(height: 36),
                ],
              ),
            ),
            // Cinematic gradient overlay (darken top -> transparent)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: Container(
                  height: 520,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black.withOpacity(0.95), Colors.black.withOpacity(0.45), Colors.black.withOpacity(0.15), Colors.transparent],
                      stops: const [0.0, 0.25, 0.6, 1.0],
                    ),
                  ),
                ),
              ),
            ),
            // Navbar overlay
            Positioned(top: 0, left: 0, right: 0, child: Navbar(darken: _darken)),
          ],
        ),
      ),
    );
  }
}
