import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryResponseBody {
  final String? id;
  final String? arName;
  final String? enName;
  CategoryResponseBody({
    required this.id,
    required this.arName,
    required this.enName,
  });

  factory CategoryResponseBody.fromDocumentSnapshot(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    return CategoryResponseBody(
      id: doc.id,
      arName: doc['ar_name'],
      enName: doc['en_name'],
    );
  }
}
