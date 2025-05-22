
import 'package:flutter/material.dart';
import 'package:triptery/presentation/widgets/trip_page/components/trip_tag.dart';

class TripSummaryWindow extends StatefulWidget{
  @override
  _TripSummaryWindowState createState() => _TripSummaryWindowState();
  
}

class _TripSummaryWindowState extends State<TripSummaryWindow> {

  bool _isPublic = true; 

  @override
  Widget build(BuildContext context){
    return Align(
      alignment: Alignment.bottomCenter, 
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )
        ), 
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              
              children: [
                Text('Review Summary'),

                const SizedBox(height: 30),
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                Icon(Icons.location_on), 
                                Text('Trip Name')
                              ]), 
                              
                              Icon(Icons.arrow_back_ios, 
                              textDirection: TextDirection.rtl, 
                              size: 16,)
                            ]
                          ), 
                          const SizedBox(height: 10),
                          Container(
                            height: 100,
                            width: 200,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 225, 225, 225),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              )
                            )
                          )
                        ]
                      )
                    ), 
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start ,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                Icon(Icons.location_on), 
                                Text('Party')
                              ]), 
                              
                              Icon(Icons.arrow_back_ios, 
                              textDirection: TextDirection.rtl, 
                              size: 16,)
                            ]
                          ), 
                          const SizedBox(height: 10),

                          Row(
                            children: [
                              const SizedBox(width: 10),
                              Text("A couple")
                            ],
                          )
                          
                        ]
                      )
                    ), 

                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start ,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                Icon(Icons.location_on), 
                                Text('Trip Dates')
                              ]), 
                              
                              Icon(Icons.arrow_back_ios, 
                              textDirection: TextDirection.rtl, 
                              size: 16,)
                            ]
                          ), 
                          const SizedBox(height: 10),

                          Row(
                            children: [
                              const SizedBox(width: 10),
                              Text("May 25 to May 27, 2025")
                            ],
                          )
                          
                        ]
                      )
                    ), 

                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start ,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                Icon(Icons.location_on), 
                                Text('Tags')
                              ]), 
                              
                              Icon(Icons.arrow_back_ios, 
                              textDirection: TextDirection.rtl, 
                              size: 16,)
                            ]
                          ), 
                          const SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(width: 10),
                              TripTag(tag: 'Party'),
                              TripTag(tag: 'Adventure'),
                              TripTag(tag: 'Beach')
                            ],
                          )
                          
                        ]
                      )
                    ), 

                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start ,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                Icon(Icons.location_on), 
                                Text('Budget')
                              ]),
                              
                              Icon(Icons.arrow_back_ios, 
                              textDirection: TextDirection.rtl, 
                              size: 16,)
                            ]
                          ), 
                          const SizedBox(height: 10),

                          Row(
                            children: [
                              const SizedBox(width: 10),
                              Text("Luxury")
                            ],
                          )
                          
                        ]
                      )
                    ), 

                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start ,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                Icon(Icons.location_on), 
                                Text('Set visibility public')
                              ]), 

                              Transform.scale(
                                scale: 0.8,
                                child: Switch(
                                  value: _isPublic, 
                                  onChanged: (bool value){
                                    setState(() {
                                      _isPublic = value;
                                    }); 
                                  },
                                  activeColor: const Color.fromARGB(255, 81, 234, 160),
                                )
                              )
                              
                            ]
                          ), 
                         
                          
                        ]
                      )
                    )
                    
                  ],
                ) 
                // Add your trip summary details here
              ],
            ),
          )
        )
      )
    ); 
  }
}