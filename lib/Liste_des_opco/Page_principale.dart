import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:site_bdd_opco/Liste_des_opco/Widgets_affichage_opco.dart';
import 'Widgets_page_principale.dart';
import 'fonctions_bdd/Ajout_et_suppression.dart';
import 'fonctions_bdd/Fonctions.dart';

class ListeOpco extends StatefulWidget {
  @override
  _ListeOpcoState createState() => _ListeOpcoState();
}

class _ListeOpcoState extends State<ListeOpco> {
  final change = ValueNotifier<int>(0);
  int error = 0;
  String nomOpcoSuppr = "";
  int popUpAjoutOpco = 0;
  int popUpSupprOpco = 0;
  String nomOpco = "";
  String siteWebOpco = "";
  String contactOpco = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ValueListenableBuilder(
          valueListenable: change,
          builder: (context, value, child) {
            return FutureBuilder(
              future: getDocumentFromFirestore(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  List<String> liste = listDesOpco(snapshot.data.toString());
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
                    body: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child:
                              Column(mainAxisSize: MainAxisSize.max, children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 5, color: Colors.grey),
                                    color: Color(0xFF1D2228),
                                  ),
                                  height: 40,
                                  width: 200,
                                  child: InkWell(
                                    onTap: () {
                                      change.value++;
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Recharger la page",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w900),
                                            )
                                          ]),
                                    ),
                                  )),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 5, color: Colors.grey),
                                  color: Color(0xFF1D2228),
                                ),
                                height: 70,
                                width: 550,
                                child: InkWell(
                                  onTap: () {
                                    if (popUpAjoutOpco == 0)
                                      popUpAjoutOpco = 1;
                                    else
                                      popUpAjoutOpco = 0;
                                    change.value++;
                                  },
                                  child: Container(
                                    color: Colors.white,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Ajouter un opco",
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w900),
                                          )
                                        ]),
                                  ),
                                )),
                            Expanded(
                              child: Container(
                                width: 1000,
                                child: ListView.builder(
                                  itemCount: liste.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              border: Border.all(
                                                  width: 5,
                                                  color: Colors.white)),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  liste[index].substring(
                                                      0,
                                                      liste[index]
                                                          .indexOf('|')),
                                                  style: TextStyle(
                                                      color: Color(0xFFFB8122),
                                                      fontSize: 50,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        'Site web',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFFFB8122),
                                                          fontSize: 30,
                                                        ),
                                                      ),
                                                      Text(
                                                        liste[index].substring(
                                                            liste[index]
                                                                    .indexOf(
                                                                        '|') +
                                                                1,
                                                            liste[index]
                                                                .lastIndexOf(
                                                                    '|')),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 25),
                                                      )
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        'Contact',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFFFB8122),
                                                            fontSize: 30),
                                                      ),
                                                      Text(
                                                          liste[index].substring(
                                                              liste[index]
                                                                      .lastIndexOf(
                                                                          '|') +
                                                                  1,
                                                              liste[index]
                                                                  .length),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 25))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15, bottom: 15),
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary: Colors
                                                                .redAccent),
                                                    onPressed: () {
                                                      nomOpcoSuppr =
                                                          liste[index]
                                                              .substring(
                                                                  0,
                                                                  liste[index]
                                                                      .indexOf(
                                                                          '|'));
                                                      popUpSupprOpco = 1;
                                                      change.value++;
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5,
                                                              bottom: 5),
                                                      child: Text(
                                                        "Supprimer",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          )),
                                    );
                                  },
                                ),
                              ),
                            ),
                            if (popUpSupprOpco == 1) Text('suppr strafoula')
                          ]),
                        ),
                        if (popUpSupprOpco == 1)
                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Center(
                              child: Container(
                                width: 500,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.grey[350],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "Voulez-vous supprimez l'opco $nomOpcoSuppr?",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800)),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                suprimerUneOpco(
                                                    snapshot.data.toString(),
                                                    nombreOpcoSupprimer(
                                                        nomOpcoSuppr,
                                                        snapshot.data
                                                            .toString()));
                                                popUpSupprOpco = 0;
                                                change.value++;
                                              },
                                              child: Text('Oui',
                                                  style:
                                                      TextStyle(fontSize: 20))),
                                          TextButton(
                                              onPressed: () {
                                                popUpSupprOpco = 0;
                                                change.value++;
                                              },
                                              child: Text('Non',
                                                  style:
                                                      TextStyle(fontSize: 20)))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        if (popUpAjoutOpco == 1)
                          SingleChildScrollView(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Center(
                                child: Container(
                                    width: 500,
                                    height: 730,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[350],
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15),
                                          child: Text(
                                            "Formulaire d'ajout d'une opco",
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 50),
                                            child: Text(
                                              "Nom de l'opco",
                                              style: TextStyle(fontSize: 25),
                                            )),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Container(
                                            width: 400,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  helperText:
                                                      "Ne peut pas être null",
                                                  focusColor: Colors.black,
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(),
                                                  hintText:
                                                      "Entrez le nom de l'opco"),
                                              onChanged: (text) {
                                                nomOpco = text;
                                              },
                                            ),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 40),
                                            child: Text(
                                              "Site web de l'opco",
                                              style: TextStyle(fontSize: 25),
                                            )),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Container(
                                            width: 400,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  focusColor: Colors.black,
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(),
                                                  hintText:
                                                      "Entrez le site web de l'opco"),
                                              onChanged: (text) {
                                                siteWebOpco = text;
                                              },
                                            ),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 60),
                                            child: Text(
                                              "Contact de l'opco",
                                              style: TextStyle(fontSize: 25),
                                            )),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Container(
                                            width: 400,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  focusColor: Colors.black,
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(),
                                                  hintText:
                                                      "Entrez les contacts de l'opco"),
                                              onChanged: (text) {
                                                contactOpco = text;
                                              },
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 80),
                                          child: InkWell(
                                            child: Container(
                                              width: 400,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border:
                                                      Border.all(width: 10)),
                                              child: Center(
                                                  child: Text(
                                                'Valider',
                                                style: TextStyle(fontSize: 50),
                                              )),
                                            ),
                                            onTap: () {
                                              if (nomOpco.isNotEmpty == true) {
                                                error = 0;
                                                popUpAjoutOpco = 0;
                                                ajouterUneOpco(
                                                    snapshot.data.toString(),
                                                    nomOpco,
                                                    siteWebOpco,
                                                    contactOpco);
                                                change.value++;
                                              }
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15, bottom: 15),
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.redAccent),
                                              onPressed: () {
                                                popUpAjoutOpco = 0;
                                                change.value++;
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5, bottom: 5),
                                                child: Text(
                                                  "Annuler",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              )),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          )
                      ],
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

// ignore: must_be_immutable
class CarteInformationsOpco extends StatelessWidget {
  List<String> liste;
  ValueNotifier<int> change;
  int index;
  int popUpSupprOpco;
  String nomOpcoSuppr;

  CarteInformationsOpco(this.liste, this.index, this.nomOpcoSuppr,
      this.popUpSupprOpco, this.change);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(width: 5, color: Colors.white)),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  liste[index].substring(0, liste[index].indexOf('|')),
                  style: TextStyle(
                      color: Color(0xFFFB8122),
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'Site web',
                        style: TextStyle(
                          color: Color(0xFFFB8122),
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        liste[index].substring(liste[index].indexOf('|') + 1,
                            liste[index].lastIndexOf('|')),
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Contact',
                        style:
                            TextStyle(color: Color(0xFFFB8122), fontSize: 30),
                      ),
                      Text(
                          liste[index].substring(
                              liste[index].lastIndexOf('|') + 1,
                              liste[index].length),
                          style: TextStyle(color: Colors.white, fontSize: 25))
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                    onPressed: () {
                      print(popUpSupprOpco);
                      nomOpcoSuppr =
                          liste[index].substring(0, liste[index].indexOf('|'));
                      popUpSupprOpco = 1;
                      print(popUpSupprOpco);
                      change.value++;
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        "Supprimer",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    )),
              ),
            ],
          )),
    );
  }
}

// ignore: must_be_immutable
class RechargePage extends StatelessWidget {
  ValueNotifier<int> change;

  RechargePage(this.change);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 5, color: Colors.grey),
            color: Color(0xFF1D2228),
          ),
          height: 40,
          width: 200,
          child: InkWell(
            onTap: () {
              change.value++;
            },
            child: Container(
              color: Colors.white,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Recharger la page",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                )
              ]),
            ),
          )),
    );
  }
}
