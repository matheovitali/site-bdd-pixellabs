import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> getDocumentFromFirestore() async {
  DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection('Data').doc('OPCOS').get();
  QuerySnapshot query =
      await FirebaseFirestore.instance.collection('Data').get();
  List names = [];
  query.docs.forEach((doc) {
    names.add(doc.id);
  });
  for (int i = 0; i != names.length; i++) {
    print(names[i]);
  }
  var dataCollection = query.docs.asMap()[1]?.data() as Map;
  print(dataCollection.toString());
  var data = snapshot.data() as Map;
  return data.toString();
}

Map<String, dynamic> getOpcoLineForData(
    String dataString, Map<String, dynamic> resultat) {
  dataString =
      dataString.replaceRange(dataString.length - 1, dataString.length, ',');
  int info1 = 1;
  int info2 = 1;
  int nom1 = 1;
  int nom2 = 1;
  for (int x = 1; x + 1 < dataString.length;) {
    for (; dataString[x] != ':';) x++;
    nom2 = x;
    info1 = x + 2;
    for (; dataString[x] != ',';) x++;
    info2 = x;
    resultat["${dataString.substring(nom1, nom2)}"] =
        "${dataString.substring(info1, info2)}";
    nom1 = x + 2;
  }
  return resultat;
}

List<String> listDesOpco(String dataString) {
  dataString =
      dataString.replaceRange(dataString.length - 1, dataString.length, ',');
  List<String> list = [];
  int info1 = 1;
  int info2 = 1;
  int nom1 = 1;
  int nom2 = 1;
  for (int x = 1; x + 1 < dataString.length;) {
    for (; dataString[x] != ':';) x++;
    nom2 = x;
    info1 = x + 2;
    for (; dataString[x] != ',';) x++;
    info2 = x;
    list.add(
        "${dataString.substring(nom1, nom2)}|${dataString.substring(info1, info2)}");
    nom1 = x + 2;
  }
  return list;
}