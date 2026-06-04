import 'dart:async';

import 'package:birthday_website/models/birthday_message.dart';
import 'package:birthday_website/widgets/message_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BirthdayMessagesCarousel extends StatefulWidget {
  final List<BirthdayMessage> messages;

  const BirthdayMessagesCarousel({super.key, required this.messages});

  @override
  State<BirthdayMessagesCarousel> createState() => _BirthdayMessagesCarouselState();
}

class _BirthdayMessagesCarouselState extends State<BirthdayMessagesCarousel> {
  int current = 0;

  late final CarouselSliderController controller;
  Timer? timer;
  bool scrollingEnabled = true;
  bool _shownScrollDisabledSnack = false;

  @override
  void initState() {
    super.initState();

    controller = CarouselSliderController();
    _startTimer();
  }

  void _startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted) return;

      current++;

      if (current >= widget.messages.length) {
        current = 0;
      }

      controller.animateToPage(current);
    });
  }

  void _stopTimer() {
    timer?.cancel();
    timer = null;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: GestureDetector(
        onHorizontalDragStart: (_) {
          if (!scrollingEnabled && !_shownScrollDisabledSnack) {
            _shownScrollDisabledSnack = true;
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(behavior: SnackBarBehavior.floating, content: Text('Flip the card to re-enable scrolling'), duration: Duration(seconds: 2)));
          }
        },
        child: CarouselSlider.builder(
          carouselController: controller,
          itemCount: widget.messages.length,
          options: CarouselOptions(
            height: 600,
            viewportFraction: MediaQuery.of(context).size.width < 600 ? 0.6 : 0.2,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            scrollPhysics: scrollingEnabled ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
            enlargeFactor: 0.2,
            onPageChanged: (index, reason) {
              setState(() {
                current = index;
              });
            },
          ),
          itemBuilder: (context, index, realIndex) {
            final isActive = index == current;

            return BirthdayMessageCard(
              data: widget.messages[index],
              isActive: isActive,
              onFlip: (flipped) {
                // Heuristic: treat devices with a small shortestSide as touch/no-mouse.
                final isTouchDevice = MediaQuery.of(context).size.shortestSide < 600;
                if (flipped && isTouchDevice) {
                  _stopTimer();
                  setState(() => scrollingEnabled = false);
                } else if (!flipped && isTouchDevice) {
                  _startTimer();
                  setState(() {
                    scrollingEnabled = true;
                    _shownScrollDisabledSnack = false;
                  });
                }
              },
            );
          },
        ),
      ),
    );
  }
}
