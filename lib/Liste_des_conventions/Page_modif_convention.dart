import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:site_bdd_opco/Liste_des_opco/Fonctions/Fonctions.dart';
import 'Fonctions/Fonctions.dart';

// ignore: must_be_immutable
class PageModifConvention extends StatelessWidget {
  int nbrCodeApe = 1;
  List<String> listeOpcos = [];
  List<String> listeApes = [];
  String valueOpco;
  String valueApes;
  ValueNotifier<int> change;
  String idcc;
  String nom;
  String creation;
  String description;
  bool popUp = false;

  PageModifConvention(this.change, this.nom, this.idcc, this.creation,
      this.description, this.valueOpco, this.valueApes);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getOpcosFromFirestore(),
      builder: (context, snapshotOpco) {
        if (snapshotOpco.connectionState == ConnectionState.done) {
          listeOpcos = snapshotOpco.data as List<String>;
          return FutureBuilder(
              future: getCodesApeFromFirestore(),
              builder: (context, snapshotApe) {
                if (snapshotApe.connectionState == ConnectionState.done) {
                  listeApes = snapshotApe.data as List<String>;
                  listeApes.add("Selectionner un code APE");
                  if (valueApes == "") {
                    valueApes = "Selectionner un code APE";
                  }
                  return Scaffold(
                      body: ValueListenableBuilder(
                          valueListenable: change,
                          builder: (context, value, child) {
                            return Center(
                              child: SingleChildScrollView(
                                child: Container(
                                    width: double.maxFinite,
                                    height: 850,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[350],
                                    ),
                                    child: Center(
                                      child: Container(
                                        width: 1200,
                                        child: Stack(
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15),
                                                  child: Text(
                                                    "Formulaire de modification d'une Convention",
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 0),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 30),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 300,
                                                              child: Text(
                                                                "IDCC *",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 300,
                                                              child:
                                                                  TextFormField(
                                                                initialValue:
                                                                    idcc,
                                                                decoration:
                                                                    InputDecoration(
                                                                  focusColor:
                                                                      Colors
                                                                          .black,
                                                                  filled: true,
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(9),
                                                                  ),
                                                                ),
                                                                onChanged:
                                                                    (text) {
                                                                  idcc = text;
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 25),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 300,
                                                              child: Text(
                                                                "Nom de la convention *",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 700,
                                                              child:
                                                                  TextFormField(
                                                                initialValue:
                                                                    nom,
                                                                decoration:
                                                                    InputDecoration(
                                                                  focusColor:
                                                                      Colors
                                                                          .black,
                                                                  filled: true,
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(9),
                                                                  ),
                                                                ),
                                                                onChanged:
                                                                    (text) {
                                                                  nom = text;
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 25),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 300,
                                                              child: Text(
                                                                "OPCO *",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                            ),
                                                            Container(
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .black54)),
                                                                width: 700,
                                                                child:
                                                                    DropdownButton<
                                                                        String>(
                                                                  isExpanded:
                                                                      true,
                                                                  underline:
                                                                      SizedBox(),
                                                                  value:
                                                                      valueOpco,
                                                                  items: listeOpcos
                                                                      .map((item) => DropdownMenuItem<String>(
                                                                            child:
                                                                                Center(child: Text(item)),
                                                                            value:
                                                                                item,
                                                                          ))
                                                                      .toList(),
                                                                  onChanged:
                                                                      (text) {
                                                                    valueOpco = text
                                                                        as String;
                                                                    change
                                                                        .value++;
                                                                  },
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 25),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 300,
                                                              child: Text(
                                                                "Date de création",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 300,
                                                              child:
                                                                  TextFormField(
                                                                initialValue:
                                                                    creation,
                                                                decoration:
                                                                    InputDecoration(
                                                                  focusColor:
                                                                      Colors
                                                                          .black,
                                                                  filled: true,
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(9),
                                                                  ),
                                                                ),
                                                                onChanged:
                                                                    (text) {
                                                                  creation =
                                                                      text;
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 25),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          90),
                                                              child: Container(
                                                                width: 300,
                                                                child: Text(
                                                                  "Description",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 700,
                                                              child:
                                                                  TextFormField(
                                                                initialValue:
                                                                    description,
                                                                maxLines: 6,
                                                                decoration:
                                                                    InputDecoration(
                                                                  focusColor:
                                                                      Colors
                                                                          .black,
                                                                  filled: true,
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(9),
                                                                  ),
                                                                ),
                                                                onChanged:
                                                                    (text) {
                                                                  description =
                                                                      text;
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 25),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 300,
                                                              child: Text(
                                                                "Code APE",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                            ),
                                                            Container(
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .black54)),
                                                                width: 700,
                                                                child:
                                                                    DropdownButton<
                                                                        String>(
                                                                  isExpanded:
                                                                      true,
                                                                  underline:
                                                                      SizedBox(),
                                                                  value:
                                                                      valueApes,
                                                                  items: listeApes
                                                                      .map((item) => DropdownMenuItem<String>(
                                                                            child:
                                                                                Center(child: Text(item)),
                                                                            value:
                                                                                item,
                                                                          ))
                                                                      .toList(),
                                                                  onChanged:
                                                                      (text) {
                                                                    valueApes = text
                                                                        as String;
                                                                    change
                                                                        .value++;
                                                                  },
                                                                )),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 15),
                                                              child: TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    nbrCodeApe +=
                                                                        1;
                                                                    change
                                                                        .value++;
                                                                  },
                                                                  child: Text(
                                                                      "Ajouter un code APE")),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 80),
                                                  child: InkWell(
                                                    child: Container(
                                                      width: 400,
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              width: 10)),
                                                      child: Center(
                                                          child: Text(
                                                        'Valider',
                                                        style: TextStyle(
                                                            fontSize: 50),
                                                      )),
                                                    ),
                                                    onTap: () async {
                                                      if (nom.isNotEmpty ==
                                                              true &&
                                                          idcc.isNotEmpty ==
                                                              true) {
                                                        if (valueApes !=
                                                            "Selectionner un code APE") {
                                                          ajouterUneConvention(
                                                              idcc,
                                                              nom,
                                                              creation,
                                                              description,
                                                              valueOpco,
                                                              valueApes);
                                                        } else {
                                                          ajouterUneConvention(
                                                              idcc,
                                                              nom,
                                                              creation,
                                                              description,
                                                              valueOpco,
                                                              "");
                                                        }
                                                        Navigator.pop(context);
                                                        change.value++;
                                                      }
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15, bottom: 15),
                                                  child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary: Colors
                                                                  .redAccent),
                                                      onPressed: () {
                                                        if (nom.length +
                                                                idcc.length +
                                                                creation
                                                                    .length +
                                                                description
                                                                    .length !=
                                                            0) {
                                                          popUp = true;
                                                          change.value++;
                                                        } else {
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 5,
                                                                bottom: 5),
                                                        child: Text(
                                                          "Annuler",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                            if (popUp == true)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 100),
                                                child: BackdropFilter(
                                                  filter: ImageFilter.blur(
                                                      sigmaX: 10, sigmaY: 10),
                                                  child: Center(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 3,
                                                            color:
                                                                Colors.black),
                                                        color: Colors.grey[350],
                                                      ),
                                                      height: 140,
                                                      width: 600,
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 15),
                                                            child: Text(
                                                              "Êtes-vous sûr de vouloir annuler ?",
                                                              style: TextStyle(
                                                                  fontSize: 30),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 20),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                      'Oui',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20),
                                                                    )),
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      popUp =
                                                                          false;
                                                                      change
                                                                          .value++;
                                                                    },
                                                                    child: Text(
                                                                      'Non',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20),
                                                                    ))
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                          ],
                                        ),
                                      ),
                                    )),
                              ),
                            );
                          }));
                } else {
                  return Container();
                }
              });
        } else {
          return Container();
        }
      },
    );
  }
}
