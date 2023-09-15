import 'dart:io';
import 'package:flutter/material.dart';
import 'package:horse_project/models/user.dart';
import 'package:horse_project/models/horse.dart';
import 'package:image_picker/image_picker.dart'; // Import ImagePicker

void main() {
  runApp(MaterialApp(
    home: ProfilePage(),
  ));
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User user = User(
    pseudo: "Utilisateur",
    email: "utilisateur@example.com",
    phonenumber: "1234567890",
    ffelink: "https://example.com", // Default FFE link
    horses: [],
  );

  TextEditingController pseudoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController ffelinkController = TextEditingController();
  TextEditingController passwordController = TextEditingController(); // Controller for password

  bool isEditing = false;
  bool showHorseForm = false;

  // Controllers for the horse form fields
  TextEditingController nameController = TextEditingController();
  TextEditingController ageHorseController = TextEditingController();
  TextEditingController robeController = TextEditingController();
  TextEditingController raceController = TextEditingController();
  TextEditingController sexeController = TextEditingController();
  String? selectedSpecialite; // Horse's specialty
  List<String> specialites = [
    "Dressage",
    "Saut d’obstacle",
    "Endurance",
    "Complet"
  ];

  List<HorseInfo> horses = []; // List to store each horse's information

  String selectedRole =
      "Propriétaire"; // By default, the user is an owner
  List<String> horseNames = [
    "Cheval 1",
    "Cheval 2",
    "Cheval 3"
  ]; // Dummy list of horse names

  @override
  void initState() {
    super.initState();
    pseudoController.text = user.pseudo ?? '';
    emailController.text = user.email ?? '';
    phonenumberController.text = user.phonenumber ?? '';
    ffelinkController.text = user.ffelink ?? ''; // Use the default FFE link
    passwordController.text = user.hashed_password ?? ''; // Initialize password controller
  }

  void toggleHorseForm() {
    setState(() {
      if (!showHorseForm) {
        // The form is closed, reset the controllers
        nameController.text = "";
        ageHorseController.text = "";
        robeController.text = "";
        raceController.text = "";
        sexeController.text = "";
        selectedSpecialite = null;
      }
      showHorseForm = !showHorseForm;
    });
  }

  void saveHorseInfo() {
    setState(() {
      // Retrieve the horse form data and create a HorseInfo instance
      final newHorse = HorseInfo(
        name: nameController.text,
        age: int.tryParse(ageHorseController.text) ?? 0,
        robe: robeController.text,
        race: raceController.text,
        sexe: sexeController.text,
        specialite: selectedSpecialite,
      );
      horses.add(newHorse); // Add the horse to the list
      // Reset the horse form controllers
      nameController.text = "";
      ageHorseController.text = "";
      robeController.text = "";
      raceController.text = "";
      sexeController.text = "";
      selectedSpecialite = null;
      showHorseForm = false; // Hide the horse form
    });
  }

  void cancelHorseForm() {
    setState(() {
      // Reset the horse form controllers
      nameController.text = "";
      ageHorseController.text = "";
      robeController.text = "";
      raceController.text = "";
      sexeController.text = "";
      selectedSpecialite = null;
      showHorseForm = false; // Hide the horse form
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        user.photo = pickedFile.path;
      });
    }
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
                  user.pseudo = pseudoController.text;
                  user.email = emailController.text;
                  user.phonenumber = phonenumberController.text;
                  user.ffelink = ffelinkController.text; // Update the FFE link
                  user.hashed_password = passwordController.text; // Update password
                }
                isEditing = !isEditing;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align the column to the start
            children: [
              Center( // Center the photo and edit icon
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: FileImage(File(user.photo ?? '')),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.edit, size: 20),
                        color: Colors.white,
                        onPressed: _pickImage,
                      ),
                    ),
                  ],
                ),
              ),
              Text("Pseudo:"),
              TextFormField(
                controller: pseudoController,
                readOnly: !isEditing,
              ),
              SizedBox(height: 16),
              Text("Mail:"),
              TextFormField(
                controller: emailController,
                readOnly: !isEditing,
              ),
              SizedBox(height: 16),
              Text("Numéro:"),
              TextFormField(
                controller: phonenumberController,
                readOnly: !isEditing,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              Text("Lien FFE:"),
              TextFormField(
                controller: ffelinkController,
                readOnly: !isEditing,
                keyboardType: TextInputType.url,
              ),
              SizedBox(height: 16),
              Text("Mot de passe:"),
              TextFormField(
                controller: passwordController,
                readOnly: !isEditing,
                obscureText: true,
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
                  value: null, // You need to set the selected value here
                  onChanged: (value) {
                    // You can add an action to handle the DP horse selection here
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
                          nameController, // Controller for the horse's name
                    ),
                    SizedBox(height: 16),
                    Text("Âge du cheval:"),
                    TextFormField(
                      controller:
                          ageHorseController, // Controller for the horse's age
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16),
                    Text("Robe du cheval:"),
                    TextFormField(
                      controller:
                          robeController, // Controller for the horse's robe
                    ),
                    SizedBox(height: 16),
                    Text("Race du cheval:"),
                    TextFormField(
                      controller:
                          raceController, // Controller for the horse's race
                    ),
                    SizedBox(height: 16),
                    Text("Sexe du cheval:"),
                    TextFormField(
                      controller:
                          sexeController, // Controller for the horse's sex
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

