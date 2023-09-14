import 'package:horse_project/models/user.dart' as appUser;
import 'package:supabase/supabase.dart';

class UserController {
  final client = SupabaseClient('https://wfkfgyfeuhsfchzcsqzr.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Indma2ZneWZldWhzZmNoemNzcXpyIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTQ2NTQ5MTIsImV4cCI6MjAxMDIzMDkxMn0.VbBQ2MwREE9FI-bHolYMw-POpRKz54OFz8AHJKI_wz0'); 

  Future<void> signup(appUser.User user) async {
    print('Signup method called with user: ${user.toString()}');

    final response = await client.from('users').insert({
      'id': user.id,
      'username': user.username,
      'email': user.email,
      'hashed_password': user.hashed_password,
      'pseudo': user.pseudo,
      'photo': user.photo,
      'phonenumber': user.phonenumber,
      'ffelink': user.ffelink,
      'isadmin': user.isadmin,
      'horses': user.horses,
    }).execute();

    print('Response received: ${response.data}');
  }
}
