import 'package:flutter/material.dart';

class HeaderSection extends StatefulWidget {
  const HeaderSection({super.key});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 198, 198, 198),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.arrow_back),
                    Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 8),
                        Icon(Icons.share),
                        SizedBox(width: 8),
                        Icon(Icons.more_vert),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 70),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [   
                    Text('1-3 May 2025'),
                    Text('One day Trip BKK'),
                    Row(
                      children: [
                        Icon(Icons.remove_red_eye_outlined),
                        Text('1.2k'),
                        const SizedBox(width: 8),

                        Icon(Icons.remove_red_eye_outlined),
                        Text('1.2k'),
                        const SizedBox(width: 8),

                        Icon(Icons.remove_red_eye_outlined),
                        Text('1.2k'),
                        const SizedBox(width: 8),

                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
