import 'package:flutter/material.dart';
import 'package:horse_project/controllers/user_controller.dart'; // Import UserController
import 'package:horse_project/views/news_feed_page.dart'; // Import NewsFeedPage

class LoginPage extends StatefulWidget {
  final ValueChanged<String> onLogin;

  LoginPage({required this.onLogin});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _pseudo;
  String? _email;
  String? _hashed_password;
  final _userController = UserController(); // Initialize UserController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  labelText:
                      'Pseudo ou Email *'), // Added required field indicator
              validator: (value) {
                // Added validator
                if (value == null || value.isEmpty) {
                  return 'Obligatoire'; // Return error message
                }
                return null;
              },
              onSaved: (value) {
                _pseudo = value;
                _email = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText:
                      'Mot de passe *'), // Added required field indicator
              obscureText: true, // Change to true
              validator: (value) {
                // Added validator
                if (value == null || value.isEmpty) {
                  return 'Obligatoire'; // Return error message
                }
                return null;
              },
              onSaved: (value) {
                _hashed_password = value;
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              child: Text('Connexion'),
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.save();
                  var loginResult = await _userController.login(
                      _pseudo, _email, _hashed_password);
                  if (loginResult) {
                    var userId =
                        "userId"; // Replace this with the logged in user's ID
                    widget.onLogin(userId);
                    Navigator.pushReplacementNamed(context,
                        '/news_feed'); // Redirect to News Feed after successful login
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
