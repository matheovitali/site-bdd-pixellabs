import 'package:cloud_firestore/cloud_firestore.dart';

List<String> listeRecherche(
    List<String> liste, List<String> listeIdcc, String recherche) {
  List<String> afterSearch = [];
  for (int i = 0; i < liste.length; i++) {
    if (liste[i].contains(recherche) == true ||
        listeIdcc[i].contains(recherche) == true) {
      afterSearch.add(liste[i]);
      afterSearch.add(listeIdcc[i]);
    }
  }
  return afterSearch;
}

List<String> triNomRecherche(List<String> liste) {
  List<String> afterSearch = [];
  for (int i = 0; i < liste.length; i += 2) {
    afterSearch.add(liste[i]);
  }
  return afterSearch;
}

List<String> triIdccRecherche(List<String> liste) {
  List<String> afterSearch = [];
  for (int i = 1; i < liste.length; i += 2) {
    afterSearch.add(liste[i]);
  }
  return afterSearch;
}

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
  CollectionReference dataConvention =
      FirebaseFirestore.instance.collection('Conventions');
  CollectionReference dataAPE =
      FirebaseFirestore.instance.collection('Codes APE');
  QuerySnapshot query =
      await FirebaseFirestore.instance.collection('Codes APE').get();
  List<String> liste = [];
  query.docs.forEach((doc) {
    liste.add(doc.id);
  });
  for (int i = 0; liste.length < i; i++) {
    DocumentSnapshot doc = await dataAPE.doc(liste[i]).get();
    String search = doc.get("Conventions");
    int y = 1;
    for (int x = 1; x < search.length; x++) {
      if (search[x] == "," || search[x] == "}") {
        if (search.substring(y, x) == conventionSuppr) {
          search.replaceRange(y, x, "");
        }
      }
    }
  }
  await dataConvention.doc("$conventionSuppr").delete();
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
