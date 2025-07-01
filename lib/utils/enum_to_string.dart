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

String partyToStringNumber(Party party) {
  switch (party) {
    case Party.onlyMe:
      return '1';
    case Party.couple:
      return '2';
    case Party.family:
      return '3-10';
    case Party.friends:
      return '2-12';
    case Party.work:
      return '5-25';
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

int budgetToDollarSign(Budget budget) {
  switch (budget) {
    case Budget.cheap:
      return 1;
    case Budget.balanced:
      return 2;
    case Budget.luxury:
      return 3;
  }
}
