import 'package:flutter/cupertino.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String)? onSearch;

  const CustomSearchBar({Key? key, this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CupertinoTextField(
        onChanged: onSearch,
        placeholder: 'Enter destination (Country, Region, City)',
        prefix: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: Icon(
            CupertinoIcons.location_solid,
            color: CupertinoColors.systemGrey,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
