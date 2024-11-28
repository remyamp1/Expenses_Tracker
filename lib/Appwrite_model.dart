import 'package:appwrite/models.dart';

class Expenses {
  final String id;
  final String Items;
  final String Amount;
  final String Date;

  Expenses({
    required this.id,
    required this.Items,
    required this.Amount,
    required this.Date,
  });

  factory Expenses.fromDocument(Document doc) {
    return Expenses(
        id: doc.$id,
        Items: doc.data["Items"],
        Amount: doc.data['Amount'],
        Date: doc.data['Date']);
  }
}
