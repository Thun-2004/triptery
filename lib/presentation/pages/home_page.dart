//Cupertino
// import 'package:flutter/cupertino.dart';
// import '../widgets/search_bar.dart';
// import '../widgets/destination_card.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       navigationBar: const CupertinoNavigationBar(
//         middle: Text('Home'),
//         backgroundColor: CupertinoColors.systemGrey6,
//       ),
//       child: SafeArea(
//         child: CustomScrollView(
//           slivers: [
//             SliverToBoxAdapter(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 16),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: const [
//                             Text(
//                               "What's your",
//                               style: TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               "destination?",
//                               style: TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         CupertinoButton(
//                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                           color: CupertinoColors.black,
//                           borderRadius: BorderRadius.circular(20),
//                           child: Row(
//                             children: const [
//                               Text('Enter Plan'),
//                               SizedBox(width: 4),
//                               Icon(CupertinoIcons.add, size: 16),
//                             ],
//                           ),
//                           onPressed: () {},
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   const CustomSearchBar(), // Assume this is already adapted
//                   const SizedBox(height: 16),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Row(
//                       children: [
//                         _buildInfoChip(
//                           icon: CupertinoIcons.calendar,
//                           text: 'Start → End',
//                         ),
//                         const SizedBox(width: 8),
//                         _buildInfoChip(
//                           icon: CupertinoIcons.person,
//                           text: '2 adults',
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   _buildSectionHeader('Top Bangkok tours'),
//                   const SizedBox(height: 8),
//                   SizedBox(
//                     height: 200,
//                     child: ListView(
//                       scrollDirection: Axis.horizontal,
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       children: const [
//                         DestinationCard(
//                           title: 'Temple of dawn (Wat Arun)',
//                           imageUrl: 'https://example.com/wat-arun.jpg',
//                           rating: 4.5,
//                           reviews: 317,
//                           distance: '2km',
//                         ),
//                         DestinationCard(
//                           title: 'Wat Pho',
//                           imageUrl: 'https://example.com/wat-pho.jpg',
//                           rating: 4.5,
//                           reviews: 317,
//                           distance: '2km',
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   _buildSectionHeader('Popular things to do in Thailand'),
//                   const SizedBox(height: 50),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoChip({required IconData icon, required String text}) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: CupertinoColors.white,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, size: 16),
//           const SizedBox(width: 4),
//           Text(text, style: const TextStyle(fontSize: 14)),
//         ],
//       ),
//     );
//   }

//   Widget _buildSectionHeader(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           CupertinoButton(
//             padding: EdgeInsets.zero,
//             onPressed: () {},
//             child: const Text('SEE ALL', style: TextStyle(fontSize: 14)),
//           ),
//         ],
//       ),
//     );
//   }
// }

//Scaffold
import 'package:flutter/material.dart';
import '../widgets/search_bar.dart';
import '../widgets/destination_card.dart';
import '../widgets/bottom_navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "What's your",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "destination?",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: const [
                          Text('Enter Plan'),
                          SizedBox(width: 4),
                          Icon(Icons.add, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const CustomSearchBar(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.calendar_today, size: 16),
                          SizedBox(width: 4),
                          Text('Start'),
                          Icon(Icons.arrow_forward, size: 16),
                          Text('End'),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.person_outline, size: 16),
                          SizedBox(width: 4),
                          Text('2 adults'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Top Bangkok tours',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(onPressed: () {}, child: const Text('SEE ALL')),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: const [
                    DestinationCard(
                      title: 'Temple of dawn (Wat Arun)',
                      imageUrl: 'https://example.com/wat-arun.jpg',
                      rating: 4.5,
                      reviews: 317,
                      distance: '2km',
                    ),
                    DestinationCard(
                      title: 'Wat Pho',
                      imageUrl: 'https://example.com/wat-pho.jpg',
                      rating: 4.5,
                      reviews: 317,
                      distance: '2km',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Popular things to do in thailand',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(onPressed: () {}, child: const Text('SEE ALL')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
