import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../models/content_item.dart';

/// A premium streaming-style hover hero card shown in an [OverlayEntry].
class HeroHoverCard {
  OverlayEntry? _entry;
  VideoPlayerController? _videoController;

  void show(BuildContext context, RenderBox box, ContentItem item, {ValueChanged<bool>? onHoverChanged}) {
    if (_entry != null) return;

    final size = box.size;
    final offset = box.localToGlobal(Offset.zero);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // Responsive hover card dimensions
    double cardWidth;
    double cardHeight;
    if (screenWidth >= 1200) {
      cardWidth = 520.0;
      cardHeight = 350.0;
    } else if (screenWidth >= 800) {
      cardWidth = 420.0;
      cardHeight = 300.0;
    } else if (screenWidth >= 600) {
      cardWidth = 360.0;
      cardHeight = 280.0;
    } else {
      cardWidth = screenWidth * 0.92;
      cardHeight = cardWidth * 0.78;
    }
    final left = (offset.dx + size.width / 2) - cardWidth / 2;
    final top = (offset.dy - 12).clamp(8.0, screenHeight - cardHeight - 8.0);

    // Initialize video controller if available.
    if (item.previewVideo.isNotEmpty) {
      _videoController = VideoPlayerController.network(item.previewVideo)
        ..setVolume(0)
        ..setLooping(true)
        ..initialize().then((_) {
          _videoController?.play();
        });
    }

    final sourceRect = Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height);
    // fixed target size for hover card (responsive)
    final targetRect = Rect.fromLTWH(left.clamp(8.0, screenWidth - cardWidth - 8.0), top, cardWidth, cardHeight);

    _entry = OverlayEntry(
      builder: (context) {
        return Positioned.fill(
          child: _HoverCardContent(item: item, videoController: _videoController, onClose: hide, onHoverChanged: onHoverChanged, sourceRect: sourceRect, targetRect: targetRect),
        );
      },
    );

    Overlay.of(context).insert(_entry!);
  }

  static Future<void> showModal(BuildContext context, ContentItem item) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Preview',
      transitionDuration: const Duration(milliseconds: 360),
      pageBuilder: (ctx, a1, a2) {
        return SafeArea(
          child: Center(
            child: Builder(
              builder: (ctx2) {
                final modalWidth = MediaQuery.of(ctx2).size.width;
                double mw, mh;
                if (modalWidth >= 1200) {
                  mw = 520.0;
                  mh = 350.0;
                } else if (modalWidth >= 800) {
                  mw = 420.0;
                  mh = 300.0;
                } else if (modalWidth >= 600) {
                  mw = 360.0;
                  mh = 280.0;
                } else {
                  mw = modalWidth * 0.92;
                  mh = mw * 0.78;
                }

                return ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: mw, height: mh),
                  child: _HoverCardContent(item: item, videoController: null, onClose: () => Navigator.of(ctx).pop()),
                );
              },
            ),
          ),
        );
      },
      transitionBuilder: (ctx, a1, a2, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: a1, curve: Curves.easeOut),
          child: child,
        );
      },
    );
  }

  void hide() {
    _videoController?.pause();
    _videoController?.dispose();
    _videoController = null;
    _entry?.remove();
    _entry = null;
  }
}

class _HoverCardContent extends StatefulWidget {
  final ContentItem item;
  final VideoPlayerController? videoController;
  final VoidCallback onClose;
  final ValueChanged<bool>? onHoverChanged;
  final Rect? sourceRect;
  final Rect? targetRect;

  const _HoverCardContent({super.key, required this.item, this.videoController, required this.onClose, this.onHoverChanged, this.sourceRect, this.targetRect});

  @override
  State<_HoverCardContent> createState() => _HoverCardContentState();
}

class _HoverCardContentState extends State<_HoverCardContent> with SingleTickerProviderStateMixin {
  late final AnimationController _anim;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(vsync: this, duration: const Duration(milliseconds: 380));
    _anim.forward();
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final radius = 10.0;

    // If both source/target rects are provided, run a shared-element transition
    final inTransition = widget.sourceRect != null && widget.targetRect != null && _anim.value < 0.98;
    if (inTransition) {
      return Positioned.fill(
        child: Listener(
          onPointerHover: (ev) {
            // If pointer moves over the target rect, report hover; if not, don't close yet until transition finishes
            if (widget.targetRect != null) {
              final inside = widget.targetRect!.contains(ev.position);
              widget.onHoverChanged?.call(inside);
            }
          },
          child: AnimatedBuilder(
            animation: _anim,
            builder: (context, child) {
              final t = Curves.easeOut.transform(_anim.value);
              final rect = Rect.lerp(widget.sourceRect, widget.targetRect, t)!;
              final border = BorderRadius.circular(lerpDouble(6, radius, t)!);

              return Stack(
                children: [
                  // dim background progressively
                  GestureDetector(
                    onTap: widget.onClose,
                    child: Container(color: Colors.black.withOpacity(0.25 * t)),
                  ),
                  Positioned.fromRect(
                    rect: rect,
                    child: ClipRRect(
                      borderRadius: border,
                      child: Container(
                        width: widget.targetRect?.width,
                        color: Colors.black,
                        child: Column(
                          children: [
                            widget.videoController != null && widget.videoController!.value.isInitialized
                                ? FittedBox(
                                    fit: BoxFit.cover,
                                    child: SizedBox(width: widget.videoController!.value.size.width, height: widget.videoController!.value.size.height, child: VideoPlayer(widget.videoController!)),
                                  )
                                : (widget.item.bannerImage.isNotEmpty ? Image.network(widget.item.bannerImage, fit: BoxFit.cover) : Image.network(widget.item.thumbnail, fit: BoxFit.cover)),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(radius),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.82),
                                    borderRadius: BorderRadius.circular(radius),
                                    border: Border.all(color: Colors.white12, width: 0.3),
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Action row
                                      _buildActions(),
                                      const SizedBox(height: 5),
                                      // Metadata
                                      _buildMetadata(),

                                      // Genres
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    }

    // Otherwise show the full overlay content (post-transition or modal fallback)
    return Listener(
      onPointerHover: (ev) {
        // If the popup has a targetRect, consider pointer inside when within it
        if (widget.targetRect != null) {
          final inside = widget.targetRect!.contains(ev.position);
          widget.onHoverChanged?.call(inside);
        }
      },
      onPointerCancel: (ev) => widget.onHoverChanged?.call(false),
      child: MouseRegion(
        onEnter: (_) => widget.onHoverChanged?.call(true),
        onExit: (_) => widget.onHoverChanged?.call(false),
        child: FadeTransition(
          opacity: CurvedAnimation(parent: _anim, curve: Curves.easeOut),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.96, end: 1.0).animate(CurvedAnimation(parent: _anim, curve: Curves.elasticOut)),
            child: Material(
              color: Colors.transparent,
              child: Stack(
                children: [
                  // ambient glow
                  Positioned.fill(
                    child: Container(
                      margin: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.6), blurRadius: 40, spreadRadius: 4),
                          BoxShadow(color: Colors.deepPurple.withOpacity(0.07), blurRadius: 60, spreadRadius: 20),
                        ],
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radius),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.82),
                          borderRadius: BorderRadius.circular(radius),
                          border: Border.all(color: Colors.white12, width: 0.3),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Top hero section
                            _buildHero(context),
                            const SizedBox(height: 10),
                            // Action row
                            _buildActions(),
                            const SizedBox(height: 8),
                            // Metadata
                            _buildMetadata(),
                            const SizedBox(height: 6),
                            // Genres
                            _buildGenres(),
                            const SizedBox(height: 8),
                            // Description
                            Text(
                              widget.item.description,
                              style: const TextStyle(color: Colors.white70, fontSize: 12),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // close area (when mouse leaves the overlay, close after a small delay)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    final height = 140.0;
    final video = widget.videoController;

    return SizedBox(
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // banner image
          if (widget.item.bannerImage.isNotEmpty)
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 800),
              tween: Tween(begin: 0.0, end: 1.0),
              builder: (context, v, child) => Transform.translate(offset: Offset(0, -6 * (1 - v)), child: child),
              child: Image.network(widget.item.bannerImage, fit: BoxFit.cover),
            ),

          // video preview with subtle parallax
          if (video != null && video.value.isInitialized)
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(milliseconds: 350),
              child: Transform.translate(
                offset: const Offset(0, -4),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(width: video.value.size.width, height: video.value.size.height, child: VideoPlayer(video)),
                ),
              ),
            ),

          // gradient overlay for readability
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 72,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black87]),
              ),
            ),
          ),

          // mute icon
          Positioned(
            right: 8,
            bottom: 8,
            child: Container(
              decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.all(6),
              child: const Icon(Icons.volume_off, color: Colors.white70, size: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      children: [
        // Play button
        _actionCircle(
          child: Row(children: const [Icon(Icons.play_arrow, size: 18, color: Colors.black)]),
          background: Colors.white,
          onTap: () {},
        ),
        const SizedBox(width: 10),
        _iconButton(Icons.add, tooltip: 'Add to list'),
        const SizedBox(width: 10),
        _iconButton(Icons.thumb_up, tooltip: 'Like'),
        const Spacer(),
        _iconButton(Icons.expand_more, tooltip: 'More'),
      ],
    );
  }

  Widget _actionCircle({required Widget child, required Color background, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(30)),
        child: child,
      ),
    );
  }

  Widget _iconButton(IconData icon, {String? tooltip}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: Colors.white70, size: 18),
        ),
      ),
    );
  }

  Widget _buildMetadata() {
    final badges = <Widget>[];
    badges.add(_chipText(widget.item.maturity));
    if ((widget.item.genre ?? '').isNotEmpty) badges.add(_chipText(widget.item.genre!));
    badges.add(_chipText('${widget.item.year}'));

    return Row(
      children: badges.map((w) => Padding(padding: const EdgeInsets.only(right: 8), child: w)).toList(),
    );
  }

  Widget _chipText(String text) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(6)),
        child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 9)),
      ),
    );
  }

  Widget _buildGenres() {
    final genres = widget.item.categories.join(' • ');
    return Text(genres, style: const TextStyle(color: Colors.white60, fontSize: 12));
  }
}
