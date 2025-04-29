import 'package:flutter/material.dart';
import '../widgets/search_bar.dart';
import '../widgets/destination_card.dart';

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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '',
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import '../widgets/search_bar.dart';
// import '../widgets/destination_card.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       child: SafeArea(
//         child: Stack(
//           children: [
//             SingleChildScrollView(
//               padding: const EdgeInsets.only(bottom: 60), // add bottom padding for tab bar
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
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
//                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                           color: CupertinoColors.black,
//                           borderRadius: BorderRadius.circular(20),
//                           onPressed: () {},
//                           child: Row(
//                             children: const [
//                               Text('Enter Plan', style: TextStyle(fontSize: 16)),
//                               SizedBox(width: 4),
//                               Icon(CupertinoIcons.add, size: 18),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const CustomSearchBar(),

//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                           decoration: BoxDecoration(
//                             color: CupertinoColors.white,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Row(
//                             children: const [
//                               Icon(CupertinoIcons.calendar, size: 16),
//                               SizedBox(width: 4),
//                               Text('Start'),
//                               Icon(CupertinoIcons.forward, size: 16),
//                               Text('End'),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                           decoration: BoxDecoration(
//                             color: CupertinoColors.white,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Row(
//                             children: const [
//                               Icon(CupertinoIcons.person, size: 16),
//                               SizedBox(width: 4),
//                               Text('2 adults'),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 24),

//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           'Top Bangkok tours',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         CupertinoButton(
//                           padding: EdgeInsets.zero,
//                           onPressed: () {},
//                           child: const Text('SEE ALL'),
//                         ),
//                       ],
//                     ),
//                   ),

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

//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           'Popular things to do in Thailand',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         CupertinoButton(
//                           padding: EdgeInsets.zero,
//                           onPressed: () {},
//                           child: const Text('SEE ALL'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Bottom TabBar fixed at bottom
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: CupertinoTabBar(
//                 backgroundColor: CupertinoColors.systemGrey6,
//                 activeColor: CupertinoColors.activeBlue,
//                 items: const [
//                   BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
//                   BottomNavigationBarItem(icon: Icon(CupertinoIcons.compass)),
//                   BottomNavigationBarItem(icon: Icon(CupertinoIcons.search)),
//                   BottomNavigationBarItem(icon: Icon(CupertinoIcons.person)),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

