import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<String>> getDocumentFromFirestore() async {
  QuerySnapshot query =
      await FirebaseFirestore.instance.collection('OPCOS').get();
  List<String> names = [];
  query.docs.forEach((doc) {
    names.add(doc.id);
  });
  return names;
}