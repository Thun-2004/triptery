import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/entities/plan/plans.dart';

Future<List<Plan>> getTopPlansService({int limit = 3}) async {
  final supabase = Supabase.instance.client;

  final response = await supabase
      .from('plan')
      .select()
      .order('totalLikes', ascending: false)
      .limit(limit);
  print("📦 Supabase raw response: $response");
  if (response.isEmpty) return [];
  return response.map<Plan>((data) {
    return Plan(
      id: data['id'],
      name: data['name'],
      ownerId: data['ownerId'],
      ownerName: data['ownerName'],
      ownerProfilePictureUrl: data['ownerProfilePictureUrl'],
      coverImageUrl: data['coverImageUrl'],
      totalView: data['totalView'] ?? 0,
      totalCopied: data['totalCopied'] ?? 0,
      totalLikes: data['totalLikes'] ?? 0,
      note: data['note'] ?? '',
      visibility: data['visibility'],
      budget: data['budget'] ?? '',
      createdAt: DateTime.parse(data['createdAt']),
    );
  }).toList();
}
