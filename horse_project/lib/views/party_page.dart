import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: PartyPage(),
  ));
}

class PartyPage extends StatefulWidget {
  @override
  _PartyPageState createState() => _PartyPageState();
}

class _PartyPageState extends State<PartyPage> {
  UserProfile userProfile = UserProfile(
    pseudo: "Utilisateur",
    mail: "utilisateur@example.com",
    num: 1234567890,
    age: 30,
    ffeLink: "https://example.com", // Lien FFE par défaut
  );

  TextEditingController pseudoController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController numController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController ffeLinkController = TextEditingController();

  // Contrôleurs pour les champs du formulaire du cheval
  TextEditingController nameController = TextEditingController();
  TextEditingController ageHorseController = TextEditingController();
  TextEditingController robeController = TextEditingController();
  TextEditingController raceController = TextEditingController();
  TextEditingController sexeController = TextEditingController();
  String? selectedSpecialite; // Spécialité du cheval
  List<String> specialites = [
    "Dressage",
    "Saut d’obstacle",
    "Endurance",
    "Complet"
  ];

  @override
  void initState() {
    super.initState();
    pseudoController.text = userProfile.pseudo;
    mailController.text = userProfile.mail;
    numController.text = userProfile.num.toString();
    ageController.text = userProfile.age.toString();
    ffeLinkController.text =
        userProfile.ffeLink; // Utilisation du lien FFE par défaut
  }


  void savePartyInfo() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Soirée"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Pseudo:"),
              TextFormField(
                controller: pseudoController,
                readOnly: !isEditing,
              ),
              SizedBox(height: 16),
              Text("Mail:"),
              TextFormField(
                controller: mailController,
                readOnly: !isEditing,
              ),
              SizedBox(height: 16),
              Text("Numéro:"),
              TextFormField(
                controller: numController,
                readOnly: !isEditing,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              Text("Âge:"),
              TextFormField(
                controller: ageController,
                readOnly: !isEditing,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              Text("Lien FFE:"),
              TextFormField(
                controller: ffeLinkController,
                readOnly: !isEditing,
                keyboardType: TextInputType.url,
              ),
              SizedBox(height: 16),
              Text("Rôle:"),
              DropdownButton<String>(
                value: selectedRole,
                onChanged: (value) {
                  setState(() {
                    selectedRole = value!;
                  });
                },
                items: ["Propriétaire", "DP"].map((role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
              ),
              if (selectedRole == "Propriétaire")
                ElevatedButton(
                  onPressed: toggleHorseForm,
                  child: Text(
                    showHorseForm
                        ? "Masquer le formulaire du cheval"
                        : "Ajouter un cheval",
                  ),
                ),
              if (selectedRole == "DP")
                DropdownButton<String>(
                  hint: Text("Sélectionnez un cheval existant"),
                  value: null, // Vous devez définir la valeur sélectionnée ici
                  onChanged: (value) {
                    // Vous pouvez ajouter une action pour gérer la sélection du cheval DP ici
                  },
                  items: horseNames.map((horseName) {
                    return DropdownMenuItem<String>(
                      value: horseName,
                      child: Text(horseName),
                    );
                  }).toList(),
                ),
              if (showHorseForm)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nom du cheval:"),
                    TextFormField(
                      controller:
                          nameController, // Contrôleur pour le nom du cheval
                    ),
                    SizedBox(height: 16),
                    Text("Âge du cheval:"),
                    TextFormField(
                      controller:
                          ageHorseController, // Contrôleur pour l'âge du cheval
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16),
                    Text("Robe du cheval:"),
                    TextFormField(
                      controller:
                          robeController, // Contrôleur pour la robe du cheval
                    ),
                    SizedBox(height: 16),
                    Text("Race du cheval:"),
                    TextFormField(
                      controller:
                          raceController, // Contrôleur pour la race du cheval
                    ),
                    SizedBox(height: 16),
                    Text("Sexe du cheval:"),
                    TextFormField(
                      controller:
                          sexeController, // Contrôleur pour le sexe du cheval
                    ),
                    SizedBox(height: 16),
                    Text("Spécialité du cheval:"),
                    DropdownButton<String>(
                      value: selectedSpecialite,
                      onChanged: (value) {
                        setState(() {
                          selectedSpecialite = value;
                        });
                      },
                      items: specialites.map((specialite) {
                        return DropdownMenuItem<String>(
                          value: specialite,
                          child: Text(specialite),
                        );
                      }).toList(),
                    ),
                    ElevatedButton(
                      onPressed: saveHorseInfo,
                      child: Text("Enregistrer le cheval"),
                    ),
                    ElevatedButton(
                      onPressed: cancelHorseForm,
                      child: Text("Annuler"),
                    ),
                  ],
                ),
              if (horses.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Chevaux enregistrés:"),
                    SizedBox(height: 8),
                    for (var i = 0; i < horses.length; i++)
                      ListTile(
                        title: Text("Nom du cheval: ${horses[i].name}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Âge du cheval: ${horses[i].age}"),
                            Text("Robe du cheval: ${horses[i].robe}"),
                            Text("Race du cheval: ${horses[i].race}"),
                            Text("Sexe du cheval: ${horses[i].sexe}"),
                            Text(
                                "Spécialité du cheval: ${horses[i].specialite ?? 'Non spécifiée'}"),
                          ],
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserProfile {
  String pseudo;
  String mail;
  int num;
  int age;
  String ffeLink;

  UserProfile({
    required this.pseudo,
    required this.mail,
    required this.num,
    required this.age,
    required this.ffeLink,
  });
}

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
