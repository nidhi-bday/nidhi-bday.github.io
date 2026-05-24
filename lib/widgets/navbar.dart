import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final bool darken;

  const Navbar({super.key, this.darken = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black.withOpacity(darken ? 0.85 : 0.45), Colors.black.withOpacity(0.05), Colors.transparent],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: preferredSize.height,
          child: Builder(
            builder: (context) {
              final isMobile = MediaQuery.of(context).size.width < 600;
              return Row(
                children: [
                  SvgPicture.asset(isMobile ? 'assets/Netflix_2016_N_logo.svg' : 'assets/netflix_logo.svg', height: 22, placeholderBuilder: (context) => const SizedBox(width: 22, height: 22)),
                  const SizedBox(width: 14),
                  if (isMobile) ...[
                    const _NavItem(label: 'Discover', isSelected: true),
                    const Spacer(),
                  ] else ...[
                    const _NavItem(label: 'Home', isSelected: true),
                    const SizedBox(width: 8),
                    const _NavItem(label: 'TV Shows'),
                    const SizedBox(width: 8),
                    const _NavItem(label: 'Movies'),
                    const SizedBox(width: 8),
                    const _NavItem(label: 'New & Popular'),
                    const SizedBox(width: 8),
                    const _NavItem(label: 'My List'),
                    const SizedBox(width: 8),
                    const _NavItem(label: 'Browse by Languages'),
                    const Spacer(),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);
}

class _NavItem extends StatefulWidget {
  final String label;
  final bool isSelected;

  const _NavItem({required this.label, this.isSelected = false});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> with SingleTickerProviderStateMixin {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.isSelected || _hover;
    final color = active ? Colors.white : Colors.white70;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        transform: Matrix4.identity()..translate(0, _hover ? -2.0 : 0.0),
        curve: Curves.easeOut,
        child: Row(
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 160),
              style: TextStyle(color: color, fontSize: 9, fontWeight: active ? FontWeight.w700 : FontWeight.w500),
              child: Text(widget.label),
            ),
            const SizedBox(width: 6),
          ],
        ),
      ),
    );
  }
}
