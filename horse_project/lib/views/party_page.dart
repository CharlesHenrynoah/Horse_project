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
  PartyInfo partyInfo = PartyInfo(
    name = "Soirée",
    desc = "Ceci est une soirée.",
  );

  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();

  void savePartyInfo() {
    setState(() {
      // Récupérez les données du formulaire du cheval et créez une instance de HorseInfo
      final newParty = PartyInfo(
        name: nameController.text,
        desc: descController.text,
      );
      parties.add(newParty);
      nameController.text = "";
      descController.text = "";
    });
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
              Text("Nom de la soirée:"),
              TextFormField(
                controller: nameController,
              ),
              Text("Description:"),
              TextFormField(
                controller: descController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PartyInfo {
  String name;
  String desc;
  //image

  PartyInfo({
    required this.name,
    required this.desc,
  });
}
