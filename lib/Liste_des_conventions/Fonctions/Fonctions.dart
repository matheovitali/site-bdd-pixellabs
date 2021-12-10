import 'package:cloud_firestore/cloud_firestore.dart';

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
  String codeApe,
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
        'code APE': "$codeApe"
      })
      .then((value) => print("Convention ajoutée !"))
      .catchError((error) => print("L'ajout de la convention à échouée !"));
}
