import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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

  bool isEditing = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                if (isEditing) {
                  userProfile.pseudo = pseudoController.text;
                  userProfile.mail = mailController.text;
                  userProfile.num = int.parse(numController.text);
                  userProfile.age = int.parse(ageController.text);
                  userProfile.ffeLink =
                      ffeLinkController.text; // Mise à jour du lien FFE
                }
                isEditing = !isEditing;
              });
            },
          ),
        ],
      ),
      body: Padding(
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
          ],
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

  UserProfile(
      {required this.pseudo,
      required this.mail,
      required this.num,
      required this.age,
      required this.ffeLink});
}
