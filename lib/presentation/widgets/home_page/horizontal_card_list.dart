import 'package:flutter/material.dart';
import '../../../domain/entities/place/place.dart';
import '../destination_card.dart';

class HorizontalCardList extends StatelessWidget {
  final String title;
  final List<Place> cards; // ✅ still called cards, but it's List<Place>
  final String actionLabel;
  final VoidCallback? onActionTap;

  const HorizontalCardList({
    super.key,
    required this.title,
    required this.cards, // ✅ keeping param name for compatibility
    this.actionLabel = 'SEE ALL',
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Title + Action Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: onActionTap,
                  child: Text(
                    actionLabel,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // 🔸 Horizontal scroll of DestinationCards (generated from Place)
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: cards.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final place = cards[index]; // ✅ still called cards internally
                return DestinationCard(place: place);
              },
            ),
          ),
        ],
      ),
    );
  }
}
