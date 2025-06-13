import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:triptery/constant/colors.dart';

class TripSearchBar extends StatelessWidget {
  final Function(String)? onSearch;
  const TripSearchBar({super.key, this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        onChanged: onSearch,
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: const Icon(LucideIcons.search, color: Colors.grey),
          suffixIcon: const Icon(LucideIcons.x, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
