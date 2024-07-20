import 'package:cloud_firestore/cloud_firestore.dart';

class CarTypeModel {
  String? id;
  String? type;
  CarTypeModel({
    this.id,
    this.type,
  });

  CarTypeModel.fromDocumentSnapshot(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    id = doc.id;
    type = doc['type'];
  }
}
