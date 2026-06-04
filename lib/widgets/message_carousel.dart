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
      height: 550,
      child: CarouselSlider.builder(
        carouselController: controller,
        itemCount: widget.messages.length,
        options: CarouselOptions(
          height: 500,
          viewportFraction: 0.3,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.zoom,

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
              if (flipped) {
                _stopTimer();
              } else {
                _startTimer();
              }
            },
          );
        },
      ),
    );
  }
}
