import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> suprimerUnCodeAPE(String apeSuppr) async {
  CollectionReference dataAPE =
      FirebaseFirestore.instance.collection('Codes APE');
  CollectionReference dataConvention =
      FirebaseFirestore.instance.collection('Conventions');
  QuerySnapshot query =
      await FirebaseFirestore.instance.collection('Conventions').get();
  List<String> liste = [];
  query.docs.forEach((doc) {
    liste.add(doc.id);
  });
  for (int i = 0; i < liste.length; i++) {
    DocumentSnapshot doc = await dataConvention.doc(liste[i]).get();
    String search = doc.get("code APE");
    int y = 1;
    int done = 0;
    for (int x = 1; x < search.length && done == 0; x++) {
      if (search[x] == "," || search[x] == "}") {
        if (search.substring(y, x) == apeSuppr) {
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
      search = search.replaceRange(0, 1, "{Selectionner un code APE");
    }
    await dataConvention.doc(liste[i]).update({'code APE': "$search"});
  }
  await dataAPE.doc("$apeSuppr").delete();
}

Future<void> ajouterUnCodeAPE(
  String ape,
  String activite,
  String domaine,
  String description,
  List<String> convention,
) async {
  CollectionReference opcos =
      FirebaseFirestore.instance.collection('Codes APE');
  await opcos
      .doc('$ape')
      .set({
        "secteur d'activité": "$activite",
        'domaine': "$domaine",
        'description': "$description",
        'Conventions': "${convention.toSet()}"
      })
      .then((value) => print("Code APE ajoutée !"))
      .catchError((error) => print("L'ajout du Code APE à échouée !"));
}

List<String> listeRecherche(
    List<String> liste, List<String> listeActivite, String recherche) {
  List<String> afterSearch = [];
  for (int i = 0; i < liste.length; i++) {
    if (liste[i].contains(recherche) == true ||
        listeActivite[i].contains(recherche) == true) {
      afterSearch.add(liste[i]);
      afterSearch.add(listeActivite[i]);
    }
  }
  return afterSearch;
}

List<String> triCodeAPERecherche(List<String> liste) {
  List<String> afterSearch = [];
  for (int i = 0; i < liste.length; i += 2) {
    afterSearch.add(liste[i]);
  }
  return afterSearch;
}

List<String> triActiviteRecherche(List<String> liste) {
  List<String> afterSearch = [];
  for (int i = 1; i < liste.length; i += 2) {
    afterSearch.add(liste[i]);
  }
  return afterSearch;
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

Future<List<String>> getActiviteFromFirestore(List<String> liste) async {
  List<String> names = [];
  for (int i = 0; i < liste.length; i++) {
    DocumentSnapshot query = await FirebaseFirestore.instance
        .collection('Codes APE')
        .doc(liste[i])
        .get();
    names.add(query.get("secteur d'activité").toString());
  }
  return names;
}
