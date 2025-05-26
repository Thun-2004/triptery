import 'package:flutter/material.dart';

import '../../../domain/entities/category.dart';

class Categories extends StatelessWidget {
  final List<Category> categories;

  const Categories({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🏷 Title + See All
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "I’m looking for...",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // 🟠 Horizontal Category List
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16, right: 32),
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final category = categories[index];
              return Column(
                children: [
                  ClipOval(
                    child: Image.asset(
                      category.imagePath,
                      width: 75,
                      height: 75,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    category.name,
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
