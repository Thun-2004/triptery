import 'package:flutter/material.dart';
import 'package:triptery/constant/colors.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key, this.controller, this.onChanged, this.onSearch});

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final void Function(String)? onSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Search for places or routes',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor:
              AppColors.lightGray, // Assuming AppColors.lightGray is defined
        ),
        onChanged: onChanged,
        onSubmitted: onSearch,
      ),
    );
  }
}
