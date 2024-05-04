import 'package:flutter/material.dart';

import '../../../core/constants/palette.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    required this.titleWidget,
    required this.badgeCount,
    required this.isLoading,
  });
  final Widget titleWidget;
  final int badgeCount;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: titleWidget,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Badge(
            backgroundColor: const Color(0xFFED6A32),
            label: Text(
              badgeCount.toString(),
              style: const TextStyle(
                color: Palette.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            child: const Icon(
              Icons.fastfood_outlined,
              color: Color(0xFF2EACAA),
              size: 35,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
