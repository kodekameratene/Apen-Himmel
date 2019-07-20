import 'package:cloud_firestore/cloud_firestore.dart';

bool Exists(DocumentSnapshot document, String s) {
  return ((document[s] ?? '') != '');
}