import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../models/content_item.dart';
import 'movie_card.dart';

class MovieRow extends StatefulWidget {
  final String title;
  final List<ContentItem> items;

  const MovieRow({super.key, required this.title, required this.items});

  @override
  State<MovieRow> createState() => _MovieRowState();
}

class _MovieRowState extends State<MovieRow> {
  final ScrollController _scrollController = ScrollController();
  bool _hovering = false;
  double _scrollPos = 0;
  double _maxScroll = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateMaxScroll());
  }

  void _onScroll() {
    setState(() {
      _scrollPos = _scrollController.hasClients ? _scrollController.position.pixels : 0;
      _maxScroll = _scrollController.hasClients ? _scrollController.position.maxScrollExtent : 0;
    });
  }

  void _updateMaxScroll() {
    if (!mounted) return;
    setState(() {
      _maxScroll = _scrollController.hasClients ? _scrollController.position.maxScrollExtent : 0;
      _scrollPos = _scrollController.hasClients ? _scrollController.position.pixels : 0;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollBy(double amount) {
    final target = (_scrollController.hasClients ? _scrollController.position.pixels : 0) + amount;
    final clamped = target.clamp(0.0, _scrollController.hasClients ? _scrollController.position.maxScrollExtent : 0.0);
    _scrollController.animateTo(clamped, duration: const Duration(milliseconds: 600), curve: Curves.easeOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    // Brightening matrix used to subtly brighten cards on hover
    final List<double> brightMatrix = [
      1.06, 0, 0, 0, 0, // r
      0, 1.06, 0, 0, 0, // g
      0, 0, 1.06, 0, 0, // b
      0, 0, 0, 1, 0, // a
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Text(
            widget.title,
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        // Row with stack overlay so arrows/gradients can sit above the list
        LayoutBuilder(
          builder: (context, outerConstraints) {
            final viewportWidth = outerConstraints.maxWidth;
            // Choose 4 cards on narrow screens, 5 on wide screens
            final visibleCount = viewportWidth < 900 ? 4 : 5;
            final sidePadding = 40.0; // matches ListView symmetric horizontal padding (20 + 20)
            final itemSpacing = 12.0; // each item's horizontal padding (6 left + 6 right collapsed)
            final rawCardWidth = ((viewportWidth - sidePadding) - (visibleCount - 1) * itemSpacing) / visibleCount;
            final clampedCardWidth = rawCardWidth.clamp(120.0, 320.0);
            final cardHeight = clampedCardWidth * 0.67;
            final rowHeight = cardHeight + 32; // allow room for padding/labels
            final scrollAmount = viewportWidth * 0.8; // 80% of visible width
            final isInfinite = widget.items.isNotEmpty;

            return SizedBox(
              height: rowHeight,
              child: MouseRegion(
                onEnter: (_) => setState(() => _hovering = true),
                onExit: (_) => setState(() => _hovering = false),
                child: Stack(
                  children: [
                    // The horizontal list
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: NotificationListener<OverscrollIndicatorNotification>(
                          onNotification: (overscroll) {
                            overscroll.disallowIndicator();
                            return true;
                          },
                          child: Listener(
                            onPointerSignal: (event) {
                              // Convert vertical wheel scroll into horizontal movement on desktop
                              if (event is PointerScrollEvent && !isMobile) {
                                final delta = event.scrollDelta.dy;
                                _scrollController.jumpTo((_scrollController.position.pixels + delta).clamp(0.0, _maxScroll));
                              }
                            },
                            child: ListView.builder(
                              controller: _scrollController,
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              physics: const BouncingScrollPhysics(),
                              // No itemCount -> infinite builder; we map index -> item using modulo
                              itemBuilder: (context, index) {
                                if (widget.items.isEmpty) return const SizedBox.shrink();
                                final item = widget.items[index % widget.items.length];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                  child: ColorFiltered(
                                    colorFilter: _hovering ? ColorFilter.matrix(brightMatrix) : const ColorFilter.matrix(<double>[1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0]),
                                    child: MovieCard(item: item, width: clampedCardWidth),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Left gradient edge
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      width: 100,
                      child: IgnorePointer(
                        ignoring: true,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Colors.black.withOpacity(0.9), Colors.black.withOpacity(0.5), Colors.black.withOpacity(0.0)],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Right gradient edge
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      width: 100,
                      child: IgnorePointer(
                        ignoring: true,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [Colors.black.withOpacity(0.9), Colors.black.withOpacity(0.5), Colors.black.withOpacity(0.0)],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Left arrow (hide at start for finite lists; always available for infinite)
                    if (isInfinite || !(_scrollPos <= 5))
                      Positioned(
                        left: 5,
                        top: 0,
                        bottom: 0,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: (_hovering || isMobile) ? 1.0 : 0.0,
                          child: Center(
                            child: _ArrowButton(icon: Icons.chevron_left, onTap: () => _scrollBy(-scrollAmount)),
                          ),
                        ),
                      ),

                    // Right arrow (hide at end for finite lists; always available for infinite)
                    if (isInfinite || !(_scrollPos >= (_maxScroll - 5)))
                      Positioned(
                        right: 5,
                        top: 0,
                        bottom: 0,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: (_hovering || isMobile) ? 1.0 : 0.0,
                          child: Center(
                            child: _ArrowButton(icon: Icons.chevron_right, onTap: () => _scrollBy(scrollAmount)),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _ArrowButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ArrowButton({required this.icon, required this.onTap});

  @override
  State<_ArrowButton> createState() => _ArrowButtonState();
}

class _ArrowButtonState extends State<_ArrowButton> with SingleTickerProviderStateMixin {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: Matrix4.identity()..scale(_hover ? 1.06 : 1.0),

          padding: const EdgeInsets.all(6),
          child: SizedBox(height: 44, width: 44, child: Icon(widget.icon, color: Colors.white.withAlpha(159), size: 28)),
        ),
      ),
    );
  }
}
