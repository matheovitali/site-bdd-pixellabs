import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:site_bdd_opco/Liste_des_conventions/Page_modif_convention.dart';
import 'Fonctions/Fonctions.dart';
import 'Widgets_liste_conventions.dart';

// ignore: must_be_immutable
class PageListeConvention extends StatelessWidget {
  var change = ValueNotifier<int>(0);
  List<String> preListe = [];
  List<String> liste = [];
  List<String> listeIdcc = [];
  String recherche = "";
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: change,
      builder: (context, value, child) {
        return FutureBuilder(
            future: getConventionsFromFirestore(),
            builder: (context, snapshot) {
              if (snapshot.hasError == true) {
                return Scaffold(
                  backgroundColor: Color(0xFF1D2228),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                liste = snapshot.data as List<String>;
                return FutureBuilder(
                    future: getIdccFromFirestore(liste),
                    builder: (context, snapshotIdcc) {
                      if (snapshotIdcc.connectionState ==
                          ConnectionState.done) {
                        listeIdcc = snapshotIdcc.data as List<String>;
                        if (recherche.length > 0) {
                          preListe =
                              listeRecherche(liste, listeIdcc, recherche);
                          liste = triNomRecherche(preListe);
                          listeIdcc = triIdccRecherche(preListe);
                        }
                        return Scaffold(
                            backgroundColor: Color(0xFF1D2228),
                            appBar: AppBar(
                              backgroundColor: Color(0xFF1D2228),
                              centerTitle: true,
                              title: Text(
                                'Liste des conventions',
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                            body: Center(
                              child: Container(
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
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
                                                      icon: Icon(Icons.search)),
                                                  onSubmitted: (text) {
                                                    recherche = text;
                                                    change.value++;
                                                  },
                                                )),
                                          ),
                                          BoutonAjoutConvention(change)
                                        ]),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: 1100,
                                      child: ListView.builder(
                                          itemCount: liste.length,
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
                                                          const EdgeInsets.only(
                                                              top: 15,
                                                              bottom: 15,
                                                              left: 50),
                                                      child: Text(
                                                        "IDCC ${listeIdcc[index]} : ${liste[index]}",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFFFB8122),
                                                            fontSize: 35,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: PopupMenuButton(
                                                      icon: Icon(
                                                        Icons.more_vert,
                                                        color: Colors.white,
                                                      ),
                                                      itemBuilder: (context) =>
                                                          [
                                                        PopupMenuItem(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 26),
                                                            child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  DocumentSnapshot
                                                                      convention =
                                                                      await FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'Conventions')
                                                                          .doc(liste[
                                                                              index])
                                                                          .get();
                                                                  Navigator.pop(
                                                                      context);
                                                                  Navigator.push(
                                                                      context,
                                                                      new MaterialPageRoute(
                                                                          builder: (context) => new PageModifConvention(
                                                                                change,
                                                                                liste[index],
                                                                                convention.get('idcc').toString(),
                                                                                convention.get('creation').toString(),
                                                                                convention.get('description').toString(),
                                                                                convention.get('opco').toString(),
                                                                                convention.get('code APE').toString(),
                                                                              )));
                                                                },
                                                                child: Text(
                                                                  'Modifier',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ))),
                                                        PopupMenuItem(
                                                          padding:
                                                              EdgeInsets.only(
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
                                                                            PopupMenuItem(
                                                                                padding: EdgeInsets.only(left: 18),
                                                                                child: Text("Supprimer la convention ?", style: TextStyle(fontWeight: FontWeight.bold))),
                                                                            PopupMenuItem(
                                                                                padding: EdgeInsets.only(left: 65),
                                                                                child: ElevatedButton(
                                                                                  child: Text('Confirmer', style: TextStyle(fontWeight: FontWeight.bold)),
                                                                                  onPressed: () async {
                                                                                    await suprimerUneConvention(liste[index]);
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
                              ),
                            ));
                      } else {
                        return ChargementPageListeConventions();
                      }
                    });
              } else {
                return ChargementPageListeConventions();
              }
            });
      },
    );
  }
}
