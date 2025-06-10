import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchPlaceFromGoogleApiService(String input, String apiKey) async {
  // Get place_id from input
  final placeIdRes = await http.get(Uri.parse(
    'https://maps.googleapis.com/maps/api/place/findplacefromtext/json'
    '?input=${Uri.encodeComponent(input)}'
    '&inputtype=textquery'
    '&fields=place_id'
    '&key=$apiKey',
  ));

  final placeIdJson = json.decode(placeIdRes.body);
  final candidates = placeIdJson['candidates'] as List;

  if (candidates.isEmpty) throw Exception('No place_id found for input: $input');
  final placeId = candidates[0]['place_id'];

  // Get place details from place_id
  final detailRes = await http.get(Uri.parse(
    'https://maps.googleapis.com/maps/api/place/details/json'
    '?place_id=$placeId'
    '&key=$apiKey',
  ));

  final detailJson = json.decode(detailRes.body);
  return detailJson; // 👈 Entire Google response JSON
}
