import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Fonctions/Fonctions.dart';
import 'Liste_des_cartes_opco.dart';
import 'Widgets_page_principale.dart';

List<String> listeRecherche(List<String> liste, String recherche) {
  List<String> afterSearch = [];
  for (int i = 0; i < liste.length; i++) {
    if (liste[i].contains(recherche) == true) {
      afterSearch.add(liste[i]);
    }
  }
  return afterSearch;
}

// ignore: must_be_immutable
class PageListeOpco extends StatelessWidget {
  var change = ValueNotifier<int>(0);
  List<String> liste = [];
  String recherche = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ValueListenableBuilder(
          valueListenable: change,
          builder: (context, value, child) {
            return FutureBuilder(
              future: getOpcosFromFirestore(),
              builder: (context, snapshot) {
                if (snapshot.hasError == true) {
                  return Scaffold(
                    backgroundColor: Color(0xFF1D2228),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  liste = snapshot.data as List<String>;
                  if (recherche.length > 0) {
                    liste = listeRecherche(liste, recherche);
                  }
                  return Scaffold(
                    backgroundColor: Color(0xFF1D2228),
                    appBar: AppBar(
                      backgroundColor: Color(0xFF1D2228),
                      centerTitle: true,
                      title: Text(
                        'Liste des opcos',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    body: Align(
                      alignment: Alignment.center,
                      child: Column(mainAxisSize: MainAxisSize.max, children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 70, top: 30),
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
                                BouttonAjoutOpco(change)
                              ]),
                        ),
                        ListeCarteOpco(
                          change,
                          liste,
                        )
                      ]),
                    ),
                  );
                } else {
                  return ChargementPageListeOpco();
                }
              },
            );
          }),
    );
  }
}
