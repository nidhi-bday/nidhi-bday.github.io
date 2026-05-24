import 'package:flutter/material.dart';

import 'intro.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800));

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo));

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _enterExperience() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 1400),
        reverseTransitionDuration: const Duration(milliseconds: 1000),
        pageBuilder: (_, animation, __) => const IntroPage(),

        transitionsBuilder: (_, animation, __, child) {
          final fadeAnimation = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);

          final scaleAnimation = Tween<double>(begin: 1.03, end: 1.0).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutExpo));

          return FadeTransition(
            opacity: fadeAnimation,
            child: ScaleTransition(scale: scaleAnimation, child: child),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      body: GestureDetector(
        onTap: _enterExperience,
        child: SizedBox.expand(
          child: Stack(
            children: [
              Center(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            // soft glow
                            Container(
                              width: 220,
                              height: 220,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [const Color(0xFFE50914).withOpacity(0.22), const Color(0xFFE50914).withOpacity(0.08), Colors.transparent],
                                  stops: const [0.0, 0.45, 1.0],
                                ),
                              ),
                            ),

                            // bloom blur
                            Container(
                              width: 260,
                              height: 260,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [BoxShadow(color: const Color(0xFFE50914).withOpacity(0.20), blurRadius: 120, spreadRadius: 30)],
                              ),
                            ),

                            // logo
                            Image.asset("assets/nlogo.webp", width: 120, height: 120, fit: BoxFit.contain),
                          ],
                        ),

                        const SizedBox(height: 24),

                        const Text(
                          "Best experienced with sound on",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70, fontSize: 16, letterSpacing: 1.2, fontWeight: FontWeight.w400),
                        ),

                        const SizedBox(height: 8),

                        AnimatedOpacity(
                          opacity: 1,
                          duration: const Duration(seconds: 2),
                          child: const Center(
                            child: Text(
                              "tap to enter",
                              style: TextStyle(color: Colors.white38, fontSize: 11, letterSpacing: 2, fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
