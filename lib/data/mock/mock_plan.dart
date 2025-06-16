
import 'package:triptery/domain/entities/trip/plan.dart';
import 'package:triptery/domain/entities/trip/plan_review.dart';
import 'package:triptery/domain/entities/trip/trip.dart';

//mock plan
final Plan mockPlans = Plan(
  id: "1",
  name: "Chill Beach at Samui",
  ownerId: "1",
  ownerName: "Levi",
  ownerProfilePictureUrl: "assets/images/user.jpg",
  coverImageUrl: "assets/images/sea.jpeg",
  totalCopied: 50,
  totalLikes: 20,
  dayStart: DateTime(2025, 2, 1), 
  dayEnd: DateTime(2025, 2, 2), 
  note: "A fun trip to Pattaya with friends.",
  visibility: PlanVisibility.public,
  budget: 0,
  createdAt: DateTime.now()
);

//plan review
final List<PlanReview> mockPlanReview = [
  PlanReview(
    id : "1",
    userId : "1",
    username : "Levi",
    userProfilePictureUrl : "assets/images/user.jpg",
    planId : "1",
    rating : 5,
    description : "Very good no titan",
    createdAt : DateTime.now().millisecondsSinceEpoch,
  ), 
  PlanReview(
    id : "1",
    userId : "2",
    username : "Eren",
    userProfilePictureUrl : "assets/images/user.jpg",
    planId : "1",
    rating : 4,
    description : "Great trip, I love it",
    createdAt : DateTime.now().millisecondsSinceEpoch,
  )
];

//trip
final List<Trip> mockTrips = [
  Trip(
    id: "1",
    planId: "1",
    day: 1,
    type: TripType.dest,
    placeId: "1",
    placeName: "Pattaya walking street",
    placeDescription: "a vibrant entertainment area in Pattaya that has gained notoriety for its go-go bars and adult shows, as well as karaoke bars and nightclubs",
    placeImageUrl: "assets/images/pattaya.jpg",
    arrivalTime: "10:00 AM",
    routeMode: RouteMode.car,
    routeFrom: "1", 
    routeTo: "2",
    routeTotalTime: 60,
    routeTotalCost: 20,
    routeTotalDistance: 30,
    routeDistance: "30 km",
    routeNote: "use highway",
    note: null,
  ), 
  
  Trip(
    id: "2",
    planId: "1",
    day: 1,
    type: TripType.route,
    placeId: "2",
    placeName: "Jomtien Beach",
    placeDescription: "a popular tourist destination located in Pattaya, Thailand, known for its long stretch of sand, vibrant atmosphere, and variety of activities.",
    placeImageUrl: "assets/images/sea.jpeg",
    arrivalTime: "11:00 AM",
    routeMode: RouteMode.publicTransit,
    routeFrom: "2", 
    routeTo: "3",
    routeTotalTime: 30,
    routeTotalCost: 20,
    routeTotalDistance: 30, 
    routeDistance: "30 km",
    routeNote: "train leaves at 11.20AM ",
    note: "Note for place 1",
  ), 
  Trip(
    id: "3",
    planId: "1",
    day: 1,
    type: TripType.dest,
    placeId: "3",
    placeName: "Sanctuary of Truth",
    placeDescription: "an unfinished museum in Pattaya, Thailand designed by Thai businessman Lek Viriyaphan. The museum structure is a hybrid of a temple and a castle that is themed on the Ayutthaya Kingdom and of Buddhist and Hindu beliefs.",
    placeImageUrl: "assets/images/sanctuary.jpg",
    arrivalTime: "12:00 PM",
    routeMode: RouteMode.publicTransit,
    routeFrom: null, 
    routeTo: null,
    routeTotalTime: null,
    routeTotalCost: null,
    routeTotalDistance: null, 
    routeDistance: null,
    routeNote: null,
    note: null,
  ), 
  
  Trip(
    id: "4",
    planId: "1",
    day: 2,
    type: TripType.dest,
    placeId: "3",
    placeName: "Sanctuary of Truth",
    placeDescription: "an unfinished museum in Pattaya, Thailand designed by Thai businessman Lek Viriyaphan. The museum structure is a hybrid of a temple and a castle that is themed on the Ayutthaya Kingdom and of Buddhist and Hindu beliefs.",
    placeImageUrl: "assets/images/sanctuary.jpg",
    arrivalTime: "12:00 PM",
    routeMode: RouteMode.publicTransit,
    routeFrom: null,
    routeTo: null,
    routeTotalTime: null,
    routeTotalCost: null,
    routeTotalDistance: null,
    routeDistance: null,
    routeNote: null,
    note: null,
  ), 
]; 