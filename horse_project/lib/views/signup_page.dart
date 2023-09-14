import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:horse_project/controllers/user_controller.dart'; // Import UserController
import 'package:horse_project/models/user.dart' as appUser; // Import User model
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String? _username;
  String? _email;
  String? _hashed_password;
  String? _confirm_password; // Add a variable to store the confirm password
  String? _pseudo;
  String? _photo;
  String? _phonenumber;
  String? _ffelink;
  bool? _isadmin; // Add a variable to store the admin status
  File? _imageFile;
  final _userController = UserController(); // Initialize UserController
  String? _phoneCode; // Add a variable to store the phone code

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

=======

class SignupPage extends StatelessWidget {
>>>>>>> origin/profil
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: Text('Inscription'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Pseudo *'), // Added required field indicator
              maxLength: 10, // Add a maximum length
              validator: (value) { // Added validator
                if (value == null || value.isEmpty) {
                  return 'Obligatoire'; // Return error message
                }
                return null;
              },
              onSaved: (value) {
                _pseudo = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email *'), // Added required field indicator
              validator: (value) { // Added validator
                if (value == null || value.isEmpty) {
                  return 'Obligatoire'; // Return error message
                }
                // Check if the email is in the correct format
                if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                  return 'Entrez une adresse email valide'; // Return error message
                }
                return null;
              },
              onSaved: (value) {
                _email = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Mot de passe *'), // Added required field indicator
              obscureText: true, // Change to true
              validator: (value) { // Added validator
                if (value == null || value.isEmpty) {
                  return 'Obligatoire'; // Return error message
                }
                // Check if the password meets the requirements
                if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$').hasMatch(value)) {
                  return 'Le mot de passe doit contenir au moins une majuscule, un chiffre et un caractère spécial'; // Return error message
                }
                return null;
              },
              onSaved: (value) {
                _hashed_password = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Confirmation du mot de passe *'), // Added required field indicator
              obscureText: true, // Change to true
              validator: (value) { // Added validator
                if (value == null || value.isEmpty) {
                  return 'Obligatoire'; // Return error message
                }
                return null;
              },
              onSaved: (value) {
                _confirm_password = value;
              },
            ),
            ListTile(
              title: _imageFile == null
                  ? Text('Aucune image sélectionnée.')
                  : Image.file(_imageFile!),
              trailing: ElevatedButton(
                child: Text('Choisir une photo de profil'),
                onPressed: _pickImage,
              ),
            ),
            DropdownButtonFormField(
              hint: Text("Indicatif téléphonique *"), // Added required field indicator
              items: ["France +33", "USA +1", "UK +44", "Germany +49", "Spain +34"].map((code) { // Added more country codes
                return DropdownMenuItem(
                  value: code,
                  child: Text(code),
                );
              }).toList(),
              validator: (value) { // Added validator
                if (value == null || value.isEmpty) {
                  return 'Obligatoire'; // Return error message
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _phoneCode = value as String?;
                });
              },
              onSaved: (value) {
                _phoneCode = value as String?;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Numéro de téléphone *'), // Added required field indicator
              validator: (value) { // Added validator
                if (value == null || value.isEmpty) {
                  return 'Obligatoire'; // Return error message
                }
                return null;
              },
              onSaved: (value) {
                _phonenumber = _phoneCode! + value!;
              },
            ),
            DropdownButtonFormField(
              hint: Text("Sélectionnez le rôle *"), // Added required field indicator
              items: ["Administrateur", "Cavalier"].map((role) {
                return DropdownMenuItem(
                  value: role == "Administrateur",
                  child: Text(role),
                );
              }).toList(),
              validator: (value) { // Added validator
                if (value == null) {
                  return 'Obligatoire'; // Return error message
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _isadmin = value as bool?;
                });
              },
              onSaved: (value) {
                _isadmin = value as bool?;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Lien FFE *'), // Added required field indicator
              validator: (value) { // Added validator
                if (value == null || value.isEmpty) {
                  return 'Obligatoire'; // Return error message
                }
                return null;
              },
              onSaved: (value) {
                _ffelink = value;
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              child: Text('Inscription'),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.save();
                  // Create a new User object with the saved form data
                  final user = appUser.User(
                    id: uuid.v4(), // Generate a unique id
                    username: _username ?? '', // Use null safety
                    email: _email ?? '', // Use null safety
                    hashed_password: _hashed_password ?? '', // Use null safety
                    pseudo: _pseudo ?? '', // Use null safety
                    photo: _photo ?? '', // Use null safety
                    phonenumber: _phonenumber ?? '', // Use null safety
                    ffelink: _ffelink ?? '', // Use null safety
                    isadmin: _isadmin ?? false, // Use the value from the form
                    horses: [], // Add a default value
                  );
                  // Call the signup method in UserController
                  _userController.signup(user);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Inscription réussie'),
                        content: Text('Vous avez bien été inscrit'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
=======
        title: Text('Sign Up'),
      ),
      body: Center(
        child: Text('Sign Up Page'),
>>>>>>> origin/profil
      ),
    );
  }
}
<<<<<<< HEAD




=======
>>>>>>> origin/profil
