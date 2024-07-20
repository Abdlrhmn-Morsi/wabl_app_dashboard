import 'package:cloud_firestore/cloud_firestore.dart';

class ManufactureYearModel {
  String? id;
  String? year;
  ManufactureYearModel({
    this.id,
    this.year,
  });

  ManufactureYearModel.fromDocumentSnapshot(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    id = doc.id;
    year = doc['year'];
  }
}
