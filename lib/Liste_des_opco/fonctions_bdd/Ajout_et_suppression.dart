import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:site_bdd_opco/Liste_des_opco/fonctions_bdd/Fonctions.dart';

Future<void> suprimerUneOpco(String dataString, int opcoToSuppr) async {
  Map<String, dynamic> resultat = {};
  CollectionReference data = FirebaseFirestore.instance.collection('Data');
  dataString =
      dataString.replaceRange(dataString.length - 1, dataString.length, ',');
  int x = 1;
  for (int nbrVirgule = 0; nbrVirgule <= opcoToSuppr; x++) {
    if (dataString[x] == ',') nbrVirgule++;
    if (nbrVirgule == opcoToSuppr) {
      if (opcoToSuppr == 0) {
        if (','.allMatches(dataString).length - 1 != 0) {
          dataString = dataString.replaceRange(
              x, dataString.indexOf(',', x + 1) + 2, "");
        } else {
          dataString =
              dataString.replaceRange(x, dataString.indexOf(',', x + 1), "");
        }
      } else {
        dataString =
            dataString.replaceRange(x, dataString.indexOf(',', x + 1), "");
      }
      nbrVirgule++;
    }
  }
  dataString =
      dataString.replaceRange(dataString.length - 1, dataString.length, '}');
  resultat = getOpcoLineForData(dataString, resultat);
  return await data
      .doc('OPCOS')
      .set(resultat)
      .then((value) => print("opco suprimée !"))
      .catchError((error) => print("L'ajout de l'opco à échouée !"));
}

Future<String> ajouterUneOpco(String dataString, String opcoToAdd,
    String siteWebOpco, String contactOpco) async {
  Map<String, dynamic> resultat = {};
  CollectionReference data = FirebaseFirestore.instance.collection('Data');
  if (dataString.length > 2) {
    resultat = getOpcoLineForData(dataString, resultat);
  }
  resultat[opcoToAdd] = "$siteWebOpco|$contactOpco";
  await data
      .doc('OPCOS')
      .set(resultat)
      .then((value) => print("opco ajoutée !"))
      .catchError((error) => print("L'ajout de l'opco à échouée !"));
  return "";
}

int nombreOpcoSupprimer(String nomOpco, String dataString) {
  int resultat = 0;
  int nom1 = 1;
  int nom2 = 1;
  for (int x = 1; x + 1 < dataString.length;) {
    for (; dataString[x] != ':';) x++;
    nom2 = x;
    if (dataString.substring(nom1, nom2) == nomOpco) {
      return resultat;
    }
    resultat++;
    for (; dataString[x] != ',';) x++;
    nom1 = x + 2;
  }
  return -1;
}
