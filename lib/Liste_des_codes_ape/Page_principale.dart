import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:site_bdd_opco/Liste_des_codes_ape/Widgets_liste_code_APE.dart';
import 'Fonctions/Fonctions.dart';
import 'Page_modif_code_ape.dart';

// ignore: must_be_immutable
class PageListeCodeAPE extends StatelessWidget {
  var change = ValueNotifier<int>(0);
  List<String> preListe = [];
  List<String> listeCodesAPE = [];
  List<String> listeActivite = [];
  String recherche = "";
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: change,
        builder: (context, value, child) {
          return FutureBuilder(
              future: getCodesApeFromFirestore(),
              builder: (context, snapshot) {
                if (snapshot.hasError == true) {
                  return Scaffold(
                    backgroundColor: Color(0xFF1D2228),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  listeCodesAPE = snapshot.data as List<String>;
                  return FutureBuilder(
                      future: getActiviteFromFirestore(listeCodesAPE),
                      builder: (context, snapshotActivite) {
                        if (snapshotActivite.connectionState ==
                            ConnectionState.done) {
                          listeActivite = snapshotActivite.data as List<String>;
                          if (recherche.length > 0) {
                            preListe = listeRecherche(
                                listeCodesAPE, listeActivite, recherche);
                            listeCodesAPE = triCodeAPERecherche(preListe);
                            listeActivite = triActiviteRecherche(preListe);
                          }
                          return Scaffold(
                              backgroundColor: Color(0xFF1D2228),
                              appBar: AppBar(
                                backgroundColor: Color(0xFF1D2228),
                                centerTitle: true,
                                title: Text(
                                  'Liste des codes APE',
                                  style: TextStyle(fontSize: 30),
                                ),
                              ),
                              body: Center(
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 70, top: 30),
                                              child: Container(
                                                  color: Colors.grey.shade100,
                                                  width: 550,
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                        hintText: "Recherche",
                                                        icon:
                                                            Icon(Icons.search)),
                                                    onSubmitted: (text) {
                                                      recherche = text;
                                                      change.value++;
                                                    },
                                                  )),
                                            ),
                                            BoutonAjoutCodeAPE(change)
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: 1100,
                                          child: ListView.builder(
                                              itemCount: listeCodesAPE.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      border: Border.all(
                                                          width: 2,
                                                          color: Colors.white)),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 1050,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 15,
                                                                  bottom: 15,
                                                                  left: 50),
                                                          child: Text(
                                                              "${listeCodesAPE[index]} : ${listeActivite[index]}",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFFFB8122),
                                                                  fontSize: 35,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: PopupMenuButton(
                                                          icon: Icon(
                                                            Icons.more_vert,
                                                            color: Colors.white,
                                                          ),
                                                          itemBuilder:
                                                              (context) => [
                                                            PopupMenuItem(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            26),
                                                                child: InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      DocumentSnapshot convention = await FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'Codes APE')
                                                                          .doc(listeCodesAPE[
                                                                              index])
                                                                          .get();
                                                                      Navigator.pop(
                                                                          context);
                                                                      Navigator.push(
                                                                          context,
                                                                          new MaterialPageRoute(
                                                                              builder: (context) => new PageModifCodeAPE(change, listeCodesAPE[index], convention.get("secteur d'activité"), convention.get("description"), convention.get("domaine"), convention.get("Conventions"))));
                                                                    },
                                                                    child: Text(
                                                                      'Modifier',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ))),
                                                            PopupMenuItem(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 20),
                                                              child:
                                                                  PopupMenuButton(
                                                                      child: Text(
                                                                          'Supprimer',
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight
                                                                                  .bold)),
                                                                      itemBuilder:
                                                                          (context) =>
                                                                              [
                                                                                PopupMenuItem(padding: EdgeInsets.only(left: 22), child: Text("Supprimer le code APE ?", style: TextStyle(fontWeight: FontWeight.bold))),
                                                                                PopupMenuItem(
                                                                                    padding: EdgeInsets.only(left: 65),
                                                                                    child: ElevatedButton(
                                                                                      child: Text('Confirmer', style: TextStyle(fontWeight: FontWeight.bold)),
                                                                                      onPressed: () async {
                                                                                        await suprimerUnCodeAPE(listeCodesAPE[index]);
                                                                                        change.value++;
                                                                                        Navigator.pop(context);
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                                                                                    ))
                                                                              ]),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),
                                      )
                                    ]),
                              ));
                        } else
                          return ChargementPageListeCodeAPE();
                      });
                } else
                  return ChargementPageListeCodeAPE();
              });
        });
  }
}
