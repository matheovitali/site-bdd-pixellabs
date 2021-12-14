import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> suprimerUneOpco(String opcoSuppr) async {
  CollectionReference data = FirebaseFirestore.instance.collection('OPCOS');
  await data.doc("$opcoSuppr").delete();
}

Future<void> ajouterUneOpco(
    String nomOpco,
    String webOpco,
    String creationOpco,
    String descriptionOpco,
    String nomPrenomOpco,
    String telephoneOpco,
    String emailOpco) async {
  CollectionReference opcos = FirebaseFirestore.instance.collection('OPCOS');
  await opcos
      .doc('$nomOpco')
      .set({
        'web': "$webOpco",
        'creation': "$creationOpco",
        'description': "$descriptionOpco",
        'nom & prenom': "$nomPrenomOpco",
        'telephone': "$telephoneOpco",
        'e-mail': "$emailOpco"
      })
      .then((value) => print("opco ajoutée !"))
      .catchError((error) => print("L'ajout de l'opco à échouée !"));
}

Future<List<String>> getOpcosFromFirestore() async {
  QuerySnapshot query =
      await FirebaseFirestore.instance.collection('OPCOS').get();
  List<String> names = [];
  query.docs.forEach((doc) {
    names.add(doc.id);
  });
  return names;
}
