import 'dart:ui';

import 'package:birthday_website/models/birthday_message.dart';
import 'package:flutter/material.dart';

class BirthdayMessageCard extends StatefulWidget {
  final BirthdayMessage data;
  final bool isActive;
  final ValueChanged<bool>? onFlip; // notify parent when flipped (pause autoplay)

  const BirthdayMessageCard({super.key, required this.data, required this.isActive, this.onFlip});

  @override
  State<BirthdayMessageCard> createState() => _BirthdayMessageCardState();
}

class _BirthdayMessageCardState extends State<BirthdayMessageCard> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;
  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _setFlipped(bool v) {
    if (_isFlipped == v) return;
    setState(() {
      _isFlipped = v;
      if (_isFlipped) {
        _ctrl.forward();
      } else {
        _ctrl.reverse();
      }
    });
    widget.onFlip?.call(_isFlipped);
  }

  void _handleTap() => _setFlipped(!_isFlipped);

  void _handleHover(bool hovering) {
    // On desktop, flip while hovered; on touch devices, hover won't fire.
    if (!Theme.of(context).platform.toString().toLowerCase().contains('android') && !Theme.of(context).platform.toString().toLowerCase().contains('ios')) {
      _setFlipped(hovering);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [BoxShadow(color: widget.isActive ? Colors.red.withOpacity(.15) : Colors.black26, blurRadius: widget.isActive ? 40 : 15, spreadRadius: widget.isActive ? 4 : 0)],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: MouseRegion(
          onEnter: (_) => _handleHover(true),
          onExit: (_) => _handleHover(false),
          child: InkWell(
            onTap: _handleTap,
            child: AnimatedBuilder(
              animation: _anim,
              builder: (context, child) {
                final angle = _anim.value * 3.1415926535;
                final isFront = _anim.value < 0.5;
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(angle),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Back side (message) - show when flipped
                      Opacity(
                        opacity: isFront ? 0 : 1,
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()..rotateY(3.1415926535), // counter-rotate so text isn't mirrored
                          child: _buildBack(),
                        ),
                      ),

                      // Front side (photo + name) - show when not flipped
                      Opacity(opacity: isFront ? 1 : 0, child: _buildFront()),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFront() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(widget.data.image, fit: BoxFit.fitHeight),

        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(.9)]),
          ),
        ),

        Positioned(
          left: 16,
          right: 16,
          bottom: 20,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.08),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withOpacity(.15)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data.name,
                      style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width < 600 ? 12 : 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBack() {
    final ScrollController _scrollController = ScrollController();
    return Stack(
      fit: StackFit.expand,
      children: [
        // same image as background
        Image.asset(widget.data.image, fit: BoxFit.cover),

        // dark overlay
        Container(color: Colors.black54),

        // blurred panel with message
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                // margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.45),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(.08)),
                ),
                child: Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  child: ListView(
                    controller: _scrollController,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      Text(
                        widget.data.name,
                        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.data.message,
                        style: TextStyle(color: Colors.white70, fontSize: MediaQuery.of(context).size.width < 600 ? 12 : 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
