import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:horse_project/controllers/user_controller.dart'; 
import 'package:horse_project/models/user.dart' as appUser; 
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
  String? _confirm_password; 
  String? _pseudo;
  String? _photo;
  String? _phonenumber;
  String? _ffelink;
  bool? _isadmin; 
  File? _imageFile;
  final _userController = UserController();
  String? _phoneCode; 

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Pseudo *'), 
              maxLength: 10, 
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Obligatoire'; 
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
              decoration: InputDecoration(labelText: 'Mot de passe *'), 
              obscureText: true, 
              validator: (value) { 
                if (value == null || value.isEmpty) {
                  return 'Obligatoire'; 
                }
                if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$').hasMatch(value)) {
                  return 'Le mot de passe doit contenir au moins une majuscule, un chiffre et un caractère spécial'; 
                return null;
              },
              onSaved: (value) {
                _hashed_password = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Confirmation du mot de passe *'),
              obscureText: true, 
              validator: (value) { 
                if (value == null || value.isEmpty) {
                  return 'Obligatoire'; 
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
              hint: Text("Indicatif téléphonique *"), 
              items: ["France +33", "USA +1", "UK +44", "Germany +49", "Spain +34"].map((code) { // Added more country codes
                return DropdownMenuItem(
                  value: code,
                  child: Text(code),
                );
              }).toList(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Obligatoire'; 
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
              decoration: InputDecoration(labelText: 'Numéro de téléphone *'), 
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Obligatoire'; 
                }
                return null;
              },
              onSaved: (value) {
                _phonenumber = _phoneCode! + value!;
              },
            ),
            DropdownButtonFormField(
              hint: Text("Sélectionnez le rôle *"),
              items: ["Administrateur", "Cavalier"].map((role) {
                return DropdownMenuItem(
                  value: role == "Administrateur",
                  child: Text(role),
                );
              }).toList(),
              validator: (value) { 
                if (value == null) {
                  return 'Obligatoire';
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
              decoration: InputDecoration(labelText: 'Lien FFE *'), 
              validator: (value) { 
                if (value == null || value.isEmpty) {
                  return 'Obligatoire'; 
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
                  
                  final user = appUser.User(
                    id: uuid.v4(), 
                    username: _username ?? '',
                    email: _email ?? '',
                    hashed_password: _hashed_password ?? '', 
                    pseudo: _pseudo ?? '',
                    photo: _photo ?? '', 
                    phonenumber: _phonenumber ?? '', 
                    ffelink: _ffelink ?? '',
                    isadmin: _isadmin ?? false, 
                    horses: [],
                  );
               
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
      ),
    );
  }
}




