import 'package:horse_project/models/user.dart' as appUser;
import 'package:supabase/supabase.dart';

class UserController {
  final client = SupabaseClient('https://wfkfgyfeuhsfchzcsqzr.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Indma2ZneWZldWhzZmNoemNzcXpyIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTQ2NTQ5MTIsImV4cCI6MjAxMDIzMDkxMn0.VbBQ2MwREE9FI-bHolYMw-POpRKz54OFz8AHJKI_wz0');
  appUser.User? user;

  Future<void> signup(appUser.User user) async {
    print('Signup method called with user: ${user.toString()}');

    final response = await client.from('users').insert({
      'id': user.id,
      'pseudo': user.pseudo,
      'email': user.email,
      'hashed_password': user.hashed_password,
      'photo': user.photo,
      'phonenumber': user.phonenumber,
      'ffelink': user.ffelink,
      'isadmin': user.isadmin,
      'horses': user.horses,
    }).execute();

    print('Response received: ${response.data}');
  }

  Future<bool> login(
      String? pseudo, String? email, String? hashed_password) async {
    print(
        'Méthode de connexion appelée avec pseudo: $pseudo, email: $email et mot de passe: $hashed_password');

    // Test if the input is an email
    var response =
        await client.from('users').select().eq('email', email).match({
      'hashed_password': hashed_password,
    }).execute();

    // If the input is not an email, test if it's a pseudo
    if (response.data == null || response.data.length == 0) {
      response =
          await client.from('users').select().eq('pseudo', pseudo).match({
        'hashed_password': hashed_password,
      }).execute();
    }

    if (response.data != null && response.data.length > 0) {
      print('Connexion réussie');
      return true;
    } else {
      print('Échec de la connexion');
      return false;
    }
  }

  // New method to retrieve user profile information
  Future<appUser.User> getUserProfile(String userId) async {
    final response =
        await client.from('users').select().eq('id', userId).execute();
    if (response.data != null && response.data.length > 0) {
      final userData = response.data[0];
      return appUser.User(
        id: userData['id'],
        pseudo: userData['pseudo'],
        email: userData['email'],
        hashed_password: userData['hashed_password'],
        photo: userData['photo'],
        phonenumber: userData['phonenumber'],
        ffelink: userData['ffelink'],
        isadmin: userData['isadmin'],
        horses: userData['horses'],
      );
    } else {
      throw Exception('User not found');
    }
  }
}
