import 'package:triptery/domain/entities/trip/plan.dart';

String partyToString(Party party) {
  switch (party) {
    case Party.onlyMe:
      return 'Only Me🚶';
    case Party.couple:
      return 'A Couple 👫';
    case Party.family:
      return 'Family 👨‍👩‍👦‍👦';
    case Party.friends:
      return 'Friends 🌟';
    case Party.work:
      return 'Work 💼';
  }
}

String budgetToString(Budget budget) {
  switch (budget) {
    case Budget.cheap:
      return 'Cheap 💰';
    case Budget.balanced:
      return 'Balanced 💵';
    case Budget.luxury:
      return 'Luxury 💎';
  }
}
