class Contest {
  final String name;
  final String address;
  final String photoUrl;
  final DateTime date;
  final List<ContestParticipant> participants;

  Contest(this.name, this.address, this.photoUrl, this.date, this.participants);
}

class ContestParticipant {
  final String name;
  final String level; // Amateur/Club1/Club2/Club3/Club4

  ContestParticipant(this.name, this.level);
}
