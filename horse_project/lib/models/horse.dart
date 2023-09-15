class HorseInfo {
  String name;
  int age;
  String robe;
  String race;
  String sexe;
  String? specialite;

  HorseInfo({
    required this.name,
    required this.age,
    required this.robe,
    required this.race,
    required this.sexe,
    this.specialite,
  });
}
