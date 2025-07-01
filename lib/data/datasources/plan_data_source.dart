import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;

class PlanDataSource {
  final supabase = Supabase.instance.client;

  Map<String, Object> getPlanbyId() {
    // final response = await http.get(
    //   Uri.parse('$baseUrl/movie/popular?api_key=$apiKey')
    // );
    // if (response.statusCode == 200) {
    //   final data = json.decode(response.body);
    //   return data['results'];
    // } else {
    //   throw Exception('Failed to load movies');
    // }
    final mock_response = {
      "id": "1",
      "name": "Chill Beach at Samui",
      "ownerId": "1",
      "ownerName": "Levi",
      "ownerProfilePictureUrl": "assets/images/user.jpg",
      "coverImageUrl":
          "/Users/benn/Library/Developer/CoreSimulator/Devices/F307C51E-8567-4F8F-903B-D11B2BA3042A/data/Containers/Data/Application/5D591FA4-479C-488B-BE8F-89DF5D9B37E8/tmp/image_picker_C5A1E4BE-D236-48B8-B791-59B4C570D205-20556-00000A35570D8F9C.jpg",
      "totalCopied": 50,
      "totalLikes": 20,
      "dayStart": "2025-07-01T00:00:00.000",
      "dayEnd": "2025-07-05T00:00:00.000",
      "dayCount": 2,
      "location": "Pattaya, Thailand",
      "note": "A fun trip to Pattaya with friends.",
      "visibility": "public",
      "budget": "cheap",
      "party": "friends",
      "createdAt": "2025-02-01T00:00:00.000",
    };
    return mock_response;
  }

  List<Map<String, Object>> getPlanReviews() {
    final mock_response = [
      {
        "id": "1",
        "userId": "1",
        "username": "Levi",
        "userProfilePictureUrl": "assets/images/user.jpg",
        "planId": "1",
        "rating": 5,
        "description": "Very good no titan",
        "createdAt": 1729113623000,
      },
      {
        "id": "1",
        "userId": "2",
        "username": "Eren",
        "userProfilePictureUrl": "assets/images/user.jpg",
        "planId": "1",
        "rating": 4,
        "description": "Great trip, I love it",
        "createdAt": 1729113623000,
      },
    ];
    return mock_response;
  }
}
