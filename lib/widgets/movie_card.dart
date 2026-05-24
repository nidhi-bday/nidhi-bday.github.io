import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/content_item.dart';
import 'hero_hover_card.dart';

class MovieCard extends StatefulWidget {
  final ContentItem item;
  final double width;

  const MovieCard({super.key, required this.item, this.width = 180});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool _hover = false;
  HeroHoverCard? _overlayCard;
  Timer? _hideTimer;

  @override
  void dispose() {
    _overlayCard?.hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Responsive card dimensions (mobile, tablet, desktop).
    // If `widget.width` differs from the default, use that explicit size.
    final screenWidth = MediaQuery.of(context).size.width;

    // Treat native mobile platforms as touch devices. Also treat narrow web
    // viewports as touch-capable (mobile web) so taps show the hero popup.
    final isTouchDevice = (!kIsWeb && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS)) || (kIsWeb && screenWidth < 700);
    double cardWidth;
    if (widget.width != 180) {
      cardWidth = widget.width;
    } else if (screenWidth >= 1200) {
      cardWidth = 280.0; // desktop
    } else if (screenWidth >= 800) {
      cardWidth = 220.0; // large tablet / small desktop
    } else if (screenWidth >= 600) {
      cardWidth = 180.0; // tablet
    } else {
      cardWidth = 140.0; // mobile
    }
    final cardHeight = cardWidth * 0.57;

    return MouseRegion(
      onEnter: (_) {
        setState(() => _hover = true);
        _hideTimer?.cancel();
        if (isTouchDevice) return;
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          _overlayCard = HeroHoverCard();
          _overlayCard?.show(
            context,
            box,
            widget.item,
            onHoverChanged: (hover) {
              if (hover) {
                _hideTimer?.cancel();
              } else {
                // If the cursor leaves the popup, close immediately
                _hideTimer?.cancel();
                _overlayCard?.hide();
                _overlayCard = null;
              }
            },
          );
        }
      },
      onExit: (_) {
        setState(() => _hover = false);

        if (!isTouchDevice) {
          _hideTimer?.cancel();

          _hideTimer = Timer(const Duration(milliseconds: 220), () {
            _overlayCard?.hide();
            _overlayCard = null;
          });
        }
      },
      child: GestureDetector(
        onTap: () async {
          if (isTouchDevice) {
            final box = context.findRenderObject() as RenderBox?;

            if (box != null) {
              _overlayCard ??= HeroHoverCard();

              _overlayCard?.show(context, box, widget.item);
            }
          }
        },
        child: AnimatedScale(
          scale: _hover ? 1.06 : 1.0,
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          child: AnimatedSlide(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            offset: _hover ? const Offset(0, -0.03) : Offset.zero,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOutCubic,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: _hover ? [BoxShadow(color: Colors.black.withOpacity(0.45), blurRadius: 30, spreadRadius: 2, offset: const Offset(0, 12))] : [],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: widget.item.thumbnail.isNotEmpty
                        ? Image.asset(
                            widget.item.thumbnail,
                            width: cardWidth,
                            height: cardHeight,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stack) {
                              log('Failed to load image: ${widget.item.thumbnail}\nError: $error');
                              return Container(
                                width: cardWidth,
                                height: cardHeight,
                                color: Colors.grey[800],
                                child: const Center(child: Icon(Icons.broken_image, color: Colors.white38, size: 36)),
                              );
                            },
                          )
                        : Container(
                            width: cardWidth,
                            height: cardHeight,
                            color: Colors.grey[800],
                            child: const Center(child: Icon(Icons.image, color: Colors.white38, size: 36)),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
