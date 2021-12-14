import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<String>> getConventionsFromFirestore() async {
  QuerySnapshot query =
      await FirebaseFirestore.instance.collection('Conventions').get();
  List<String> liste = [];
  query.docs.forEach((doc) {
    liste.add(doc.id);
  });
  return liste;
}

Future<void> suprimerUneConvention(String conventionSuppr) async {
  CollectionReference data =
      FirebaseFirestore.instance.collection('Conventions');
  await data.doc("$conventionSuppr").delete();
}

Future<void> ajouterUneConvention(
  String idcc,
  String nom,
  String creation,
  String description,
  String opco,
  List<String> codeApe,
) async {
  CollectionReference opcos =
      FirebaseFirestore.instance.collection('Conventions');
  await opcos
      .doc('$nom')
      .set({
        'idcc': "$idcc",
        'creation': "$creation",
        'description': "$description",
        'opco': "$opco",
        'code APE': "${codeApe.toSet()}"
      })
      .then((value) => print("Convention ajoutée !"))
      .catchError((error) => print("L'ajout de la convention à échouée !"));
}

Future<List<String>> getIdccFromFirestore(List<String> liste) async {
  List<String> names = [];
  for (int i = 0; i < liste.length; i++) {
    DocumentSnapshot query = await FirebaseFirestore.instance
        .collection('Conventions')
        .doc(liste[i])
        .get();
    names.add(query.get('idcc').toString());
  }
  return names;
}

Future<List<String>> getCodesApeFromFirestore() async {
  QuerySnapshot query =
      await FirebaseFirestore.instance.collection('Codes APE').get();
  List<String> names = [];
  query.docs.forEach((doc) {
    names.add(doc.id);
  });
  return names;
}