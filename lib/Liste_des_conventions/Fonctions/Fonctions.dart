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
  for (int i = 0; i < liste.length; i++) {
    DocumentSnapshot doc = await dataAPE.doc(liste[i]).get();
    String search = doc.get("Conventions");
    int y = 1;
    int done = 0;
    for (int x = 1; x < search.length && done == 0; x++) {
      if (search[x] == "," || search[x] == "}") {
        if (search.substring(y, x) == conventionSuppr) {
          if (search[x] == ",") {
            search = search.replaceRange(y, x + 2, "");
          } else if (y - 2 >= 0) {
            search = search.replaceRange(y - 2, x, "");
          } else {
            search = search.replaceRange(y, x, "");
          }
          done = 1;
        } else {
          y = x + 2;
        }
      }
    }
    if (search.length == 2) {
      search = search.replaceRange(0, 1, "{Selectionner une Convention");
    }
    await dataAPE.doc(liste[i]).update({'Conventions': "$search"});
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
      .then((value) => print("Convention ajout??e !"))
      .catchError((error) => print("L'ajout de la convention ?? ??chou??e !"));
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
