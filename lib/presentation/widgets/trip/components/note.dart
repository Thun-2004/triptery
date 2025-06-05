import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:triptery/constant/colors.dart';

class Note extends StatelessWidget {

  final Function(String) onChanged;
  final Icon? placeholderIcon; //? = can be null or optional
  final String? placeholderText; //? = can be null or optional
  final TextEditingController controller; 

  const Note({super.key, required this.onChanged, this.placeholderIcon, required this.controller, this.placeholderText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(
          (placeholderIcon ?? LucideIcons.notepadText) as IconData?,
          color: AppColors.darkGray,
          size: 16,
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 30, minHeight: 30),

        hintText: placeholderText,
        filled: true,
        fillColor: AppColors.lightGray,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      controller: controller,
      onChanged: onChanged,
      style: TextStyle(color: AppColors.black, fontSize: 12),
    );
  }
}

