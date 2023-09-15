import 'package:horse_project/models/contest.dart';
import 'package:horse_project/services/database_service.dart';

class ContestController {
  final DatabaseService _databaseService = DatabaseService();

  Future<void> createContest(
      String contestName, String contestAddress, DateTime dateAndTime) async {
    try {
      final newContest = Contest(
        contestName: contestName,
        contestAddress: contestAddress,
        dateAndTime: dateAndTime,
      );

      await _databaseService.createContest(newContest);
    } catch (e) {
      // Gérer les erreurs de création du concours
      print('Erreur lors de la création du concours : $e');
    }
  }
}