import 'package:supabase_flutter/supabase_flutter.dart';

class TagDataSource {
  final supabase = Supabase.instance.client;
  final mock_selected_tags = [
      {
        "id": "1",
        "name": "Adventure Travel 🏞️",
        "createdAt": "#FFB554",
        "createdBy": "assets/icons/adventure_travel.svg",
        "updatedAt": "2025-02-01T00:00:00.000",
        "updatedBy": "2025-02-01T00:00:00.000",
        "delete": "2025-02-01T00:00:00.000",
        "deletedAt": "2025-02-01T00:00:00.000",
        "deletedBy": "2025-02-01T00:00:00.000",
      },
      {
        "id": "2",
        "name": "City Breaks 🌇",
        "createdAt": "#FFB554",
        "createdBy": "assets/icons/city_breaks.svg",
        "updatedAt": "2025-02-01T00:00:00.000",
        "updatedBy": "2025-02-01T00:00:00.000",
        "delete": "2025-02-01T00:00:00.000",
        "deletedAt": "2025-02-01T00:00:00.000",
        "deletedBy": "2025-02-01T00:00:00.000",
      },
      {
        "id": "3",
        "name": "Cultural Exploration 🏛️",
        "createdAt": "#FFB554",
        "createdBy": "assets/icons/cultural_exploration.svg",
        "updatedAt": "2025-02-01T00:00:00.000",
        "updatedBy": "2025-02-01T00:00:00.000",
        "delete": "2025-02-01T00:00:00.000",
        "deletedAt": "2025-02-01T00:00:00.000",
        "deletedBy": "2025-02-01T00:00:00.000",
      },
      {
        "id": "4",
        "name": "Glamping ⛺️",
        "createdAt": "#FFB554",
        "createdBy": "assets/icons/glamping.svg",
        "updatedAt": "2025-02-01T00:00:00.000",
        "updatedBy": "2025-02-01T00:00:00.000",
        "delete": "2025-02-01T00:00:00.000",
        "deletedAt": "2025-02-01T00:00:00.000",
        "deletedBy": "2025-02-01T00:00:00.000",
      },
      {
        "id": "5",
        "name": "Beach Vacation 🏖️",
        "createdAt": "#FFB554",
        "createdBy": "assets/icons/beach_vacation.svg",
        "updatedAt": "2025-02-01T00:00:00.000",
        "updatedBy": "2025-02-01T00:00:00.000",
        "delete": "2025-02-01T00:00:00.000",
        "deletedAt": "2025-02-01T00:00:00.000",
        "deletedBy": "2025-02-01T00:00:00.000",
      },
      {
        "id": "6",
        "name": "Nature Escape 🌿",
        "createdAt": "#FFB554",
        "createdBy": "assets/icons/nature_escape.svg",
        "updatedAt": "2025-02-01T00:00:00.000",
        "updatedBy": "2025-02-01T00:00:00.000",
        "delete": "2025-02-01T00:00:00.000",
        "deletedAt": "2025-02-01T00:00:00.000",
        "deletedBy": "2025-02-01T00:00:00.000",
      },
    ];
  
  final totalTags = [
      {
        "id": "1",
        "name": "Adventure Travel 🏞️",
        "createdAt": "#FFB554",
        "createdBy": "assets/icons/adventure_travel.svg",
        "updatedAt": "2025-02-01T00:00:00.000",
        "updatedBy": "2025-02-01T00:00:00.000",
        "delete": "2025-02-01T00:00:00.000",
        "deletedAt": "2025-02-01T00:00:00.000",
        "deletedBy": "2025-02-01T00:00:00.000",
      },
      {
        "id": "2",
        "name": "City Breaks 🌇",
        "createdAt": "#FFB554",
        "createdBy": "assets/icons/city_breaks.svg",
        "updatedAt": "2025-02-01T00:00:00.000",
        "updatedBy": "2025-02-01T00:00:00.000",
        "delete": "2025-02-01T00:00:00.000",
        "deletedAt": "2025-02-01T00:00:00.000",
        "deletedBy": "2025-02-01T00:00:00.000",
      },
      {
        "id": "3",
        "name": "Cultural Exploration 🏛️",
        "createdAt": "#FFB554",
        "createdBy": "assets/icons/cultural_exploration.svg",
        "updatedAt": "2025-02-01T00:00:00.000",
        "updatedBy": "2025-02-01T00:00:00.000",
        "delete": "2025-02-01T00:00:00.000",
        "deletedAt": "2025-02-01T00:00:00.000",
        "deletedBy": "2025-02-01T00:00:00.000",
      },
      {
        "id": "4",
        "name": "Glamping ⛺️",
        "createdAt": "#FFB554",
        "createdBy": "assets/icons/glamping.svg",
        "updatedAt": "2025-02-01T00:00:00.000",
        "updatedBy": "2025-02-01T00:00:00.000",
        "delete": "2025-02-01T00:00:00.000",
        "deletedAt": "2025-02-01T00:00:00.000",
        "deletedBy": "2025-02-01T00:00:00.000",
      },
      {
        "id": "5",
        "name": "Beach Vacation 🏖️",
        "createdAt": "#FFB554",
        "createdBy": "assets/icons/beach_vacation.svg",
        "updatedAt": "2025-02-01T00:00:00.000",
        "updatedBy": "2025-02-01T00:00:00.000",
        "delete": "2025-02-01T00:00:00.000",
        "deletedAt": "2025-02-01T00:00:00.000",
        "deletedBy": "2025-02-01T00:00:00.000",
      },
      {
        "id": "6",
        "name": "Nature Escape 🌿",
        "createdAt": "#FFB554",
        "createdBy": "assets/icons/nature_escape.svg",
        "updatedAt": "2025-02-01T00:00:00.000",
        "updatedBy": "2025-02-01T00:00:00.000",
        "delete": "2025-02-01T00:00:00.000",
        "deletedAt": "2025-02-01T00:00:00.000",
        "deletedBy": "2025-02-01T00:00:00.000",
      },
      {
        "id": "7",
        "name": "Relaxing Getaways 🏨",
        "createdAt": "#FFB554",
        "createdBy": "assets/icons/relaxing_getaways.svg",
        "updatedAt": "2025-02-01T00:00:00.000",
        "updatedBy": "2025-02-01T00:00:00.000",
        "delete": "2025-02-01T00:00:00.000",
        "deletedAt": "2025-02-01T00:00:00.000",
        "deletedBy": "2025-02-01T00:00:00.000",
      },
      {
        "id": "8",
        "name": "Road Trips 🚙",
        "createdAt": "#FFB554",
        "createdBy": "assets/icons/road_trips.svg",
        "updatedAt": "2025-02-01T00:00:00.000",
        "updatedBy": "2025-02-01T00:00:00.000",
        "delete": "2025-02-01T00:00:00.000",
        "deletedAt": "2025-02-01T00:00:00.000",
        "deletedBy": "2025-02-01T00:00:00.000",
      },
      {
        "id": "9",
        "name": "Food Tourism 🥗",
        "createdAt": "#FFB554",
        "createdBy": "assets/icons/food_tourism.svg",
        "updatedAt": "2025-02-01T00:00:00.000",
        "updatedBy": "2025-02-01T00:00:00.000",
        "delete": "2025-02-01T00:00:00.000",
        "deletedAt": "2025-02-01T00:00:00.000",
        "deletedBy": "2025-02-01T00:00:00.000",
      },
      {
        "id": "10",
        "name": "Backpacking 🎒",
        "createdAt": "#FFB554",
        "createdBy": "assets/icons/backpacking.svg",
        "updatedAt": "2025-02-01T00:00:00.000",
        "updatedBy": "2025-02-01T00:00:00.000",
        "delete": "2025-02-01T00:00:00.000",
        "deletedAt": "2025-02-01T00:00:00.000",
        "deletedBy": "2025-02-01T00:00:00.000",
      },
      {
        "id": "11",
        "name": "Cruise Vacations 🚢",
        "createdAt": "#FFB554",
        "createdBy": "assets/icons/cruise_vacations.svg",
        "updatedAt": "2025-02-01T00:00:00.000",
        "updatedBy": "2025-02-01T00:00:00.000",
        "delete": "2025-02-01T00:00:00.000",
        "deletedAt": "2025-02-01T00:00:00.000",
        "deletedBy": "2025-02-01T00:00:00.000",
      },
      {
        "id": "12",
        "name": "Staycations 🏡",
        "createdAt": "#FFB554",
        "createdBy": "assets/icons/staycations.svg",
        "updatedAt": "2025-02-01T00:00:00.000",
        "updatedBy": "2025-02-01T00:00:00.000",
        "delete": "2025-02-01T00:00:00.000",
        "deletedAt": "2025-02-01T00:00:00.000",
        "deletedBy": "2025-02-01T00:00:00.000",
      },
      {
        "id": "13",
        "name": "Skiing/Snowboarding ⛷️",
        "createdAt": "#FFB554",
        "createdBy": "assets/icons/skiing_snowboarding.svg",
        "updatedAt": "2025-02-01T00:00:00.000",
        "updatedBy": "2025-02-01T00:00:00.000",
        "delete": "2025-02-01T00:00:00.000",
        "deletedAt": "2025-02-01T00:00:00.000",
        "deletedBy": "2025-02-01T00:00:00.000",
      },
      {
        "id": "14",
        "name": "Wine Tours 🍷",
        "createdAt": "#FFB554",
        "createdBy": "assets/icons/wine_tours.svg",
        "updatedAt": "2025-02-01T00:00:00.000",
        "updatedBy": "2025-02-01T00:00:00.000",
        "delete": "2025-02-01T00:00:00.000",
        "deletedAt": "2025-02-01T00:00:00.000",
        "deletedBy": "2025-02-01T00:00:00.000",
      },
      {
        "id": "15",
        "name": "Wildlife Safaris 🦁",
        "createdAt": "#FFB554",
        "createdBy": "assets/icons/wildlife_safaris.svg",
        "updatedAt": "2025-02-01T00:00:00.000",
        "updatedBy": "2025-02-01T00:00:00.000",
        "delete": "2025-02-01T00:00:00.000",
        "deletedAt": "2025-02-01T00:00:00.000",
        "deletedBy": "2025-02-01T00:00:00.000",
      },
      {
        "id": "16",
        "name": "Art Galleries 🎨",
        "createdAt": "#FFB554",
        "createdBy": "assets/icons/art_galleries.svg",
        "updatedAt": "2025-02-01T00:00:00.000",
        "updatedBy": "2025-02-01T00:00:00.000",
        "delete": "2025-02-01T00:00:00.000",
        "deletedAt": "2025-02-01T00:00:00.000",
        "deletedBy": "2025-02-01T00:00:00.000",
      },
      {
        "id": "17",
        "name": "Historical Sites 🏰",
        "createdAt": "#FFB554",
        "createdBy": "assets/icons/historical_sites.svg",
        "updatedAt": "2025-02-01T00:00:00.000",
        "updatedBy": "2025-02-01T00:00:00.000",
        "delete": "2025-02-01T00:00:00.000",
        "deletedAt": "2025-02-01T00:00:00.000",
        "deletedBy": "2025-02-01T00:00:00.000",
      },
      {
        "id": "18",
        "name": "Eco-Tourism 🌿",
        "createdAt": "#FFB554",
        "createdBy": "assets/icons/eco_tourism.svg",
        "updatedAt": "2025-02-01T00:00:00.000",
        "updatedBy": "2025-02-01T00:00:00.000",
        "delete": "2025-02-01T00:00:00.000",
        "deletedAt": "2025-02-01T00:00:00.000",
        "deletedBy": "2025-02-01T00:00:00.000",
      },
    ];


  List<Map<String, Object>> getTagsByPlanId(int planId) {
    return mock_selected_tags;
  }

  void updateSelectedTags(tagId, planId){
    Map<String, String> tag = totalTags.firstWhere((tag) => tag['id'] == tagId, orElse: () => {});
    if (tag.isEmpty) {
      throw Exception("Tag with id $tagId not found");
    }else{
      mock_selected_tags.add(tag);
    }
  }

  List<Map<String, Object>> getTags() {
    return totalTags;
  }
}


// get tag by plan id
// import 'package:supabase_flutter/supabase_flutter.dart';
// import '../models/tag.dart';
// class TagDataSource {
//   final supabase = Supabase.instance.client;
//   Future<List<Tag>> getTagsByPlanId(String planId) async {
//     final response = await supabase
//         .from('plans_tag')
//         .select('tag_id, tags(*)') // adjust field names as your db structure
//         .eq('plan_id', planId)
//         .execute();
//     if (response.error != null) {
//       throw Exception(response.error!.message);
//     }
//     final data = response.data as List<dynamic>;
//     // Parse to Tag model
//     return data.map((e) => Tag.fromJson(e['tags'])).toList();
//   }
// }