import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:triptery/constant/colors.dart';

class Note extends StatelessWidget {

  final Function(String) onChanged;
  final Icon? placeholderIcon; //? = can be null or optional
  final String? placeholderText; //? = can be null or optional
  final String? initialValue;
  //NOTE: controller can't be used with initialValue, so we use initialValue instead otherwise error

  const Note({super.key, this.initialValue, required this.onChanged, this.placeholderIcon, this.placeholderText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
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
      onChanged: ((value) => onChanged(value)),
      style: TextStyle(color: AppColors.black, fontSize: 12),
    );
  }
}

