import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:site_bdd_opco/Liste_des_codes_ape/Fonctions/Fonctions.dart';
import 'package:site_bdd_opco/Liste_des_conventions/Fonctions/Fonctions.dart';

// ignore: must_be_immutable
class PageAjoutCodeAPE extends StatelessWidget {
  int nbrConvention = 1;
  static List<String> listeNbrConvention = ["1"];
  String valueNbr = listeNbrConvention.first;
  List<String> listeConvention = [];
  List<String> listeValueConvention = ["Selectionner une Convention"];
  String valueConvention = "";
  ValueNotifier<int> change;
  String codeApe = "";
  String activite = "";
  String description = "";
  String domaine = "";
  bool popUp = false;

  PageAjoutCodeAPE(this.change);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getConventionsFromFirestore(),
        builder: (context, snapshotConvention) {
          if (snapshotConvention.connectionState == ConnectionState.done) {
            listeConvention = snapshotConvention.data as List<String>;
            listeConvention.add("Selectionner une Convention");
            valueConvention = "Selectionner une Convention";
            return Scaffold(
                body: ValueListenableBuilder(
                    valueListenable: change,
                    builder: (context, value, child) {
                      return Center(
                        child: SingleChildScrollView(
                          child: Container(
                              width: double.maxFinite,
                              height: 860,
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
                                                const EdgeInsets.only(top: 15),
                                            child: Text(
                                              "Formulaire d'ajout d'un Code APE",
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 0),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 30),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 300,
                                                        child: Text(
                                                          "Code APE *",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 300,
                                                        child: TextFormField(
                                                          initialValue: codeApe,
                                                          decoration:
                                                              InputDecoration(
                                                            focusColor:
                                                                Colors.black,
                                                            filled: true,
                                                            fillColor:
                                                                Colors.white,
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          9),
                                                            ),
                                                          ),
                                                          onChanged: (text) {
                                                            codeApe = text;
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 25),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 300,
                                                        child: Text(
                                                          "Secteur d'activité *",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 700,
                                                        child: TextFormField(
                                                          initialValue:
                                                              activite,
                                                          decoration:
                                                              InputDecoration(
                                                            focusColor:
                                                                Colors.black,
                                                            filled: true,
                                                            fillColor:
                                                                Colors.white,
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          9),
                                                            ),
                                                          ),
                                                          onChanged: (text) {
                                                            activite = text;
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 25),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 300,
                                                        child: Text(
                                                          "Domaine",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 700,
                                                        child: TextFormField(
                                                          initialValue: domaine,
                                                          decoration:
                                                              InputDecoration(
                                                            focusColor:
                                                                Colors.black,
                                                            filled: true,
                                                            fillColor:
                                                                Colors.white,
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          9),
                                                            ),
                                                          ),
                                                          onChanged: (text) {
                                                            domaine = text;
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 25),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 90),
                                                        child: Container(
                                                          width: 300,
                                                          child: Text(
                                                            "Description",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 700,
                                                        child: TextFormField(
                                                          initialValue:
                                                              description,
                                                          maxLines: 6,
                                                          decoration:
                                                              InputDecoration(
                                                            focusColor:
                                                                Colors.black,
                                                            filled: true,
                                                            fillColor:
                                                                Colors.white,
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          9),
                                                            ),
                                                          ),
                                                          onChanged: (text) {
                                                            description = text;
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 25),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 300,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "Convention",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 20),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .black54)),
                                                                width: 50,
                                                                child: DropdownButton<
                                                                        String>(
                                                                    value:
                                                                        valueNbr,
                                                                    isExpanded:
                                                                        true,
                                                                    underline:
                                                                        SizedBox(),
                                                                    items: listeNbrConvention
                                                                        .map((item) => DropdownMenuItem<String>(
                                                                              child: Center(child: Text(item)),
                                                                              value: item,
                                                                            ))
                                                                        .toList(),
                                                                    onChanged: (text) {
                                                                      valueNbr =
                                                                          text
                                                                              as String;
                                                                      valueConvention =
                                                                          listeValueConvention[int.parse(valueNbr) -
                                                                              1];
                                                                      change
                                                                          .value++;
                                                                    }),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .black54)),
                                                          width: 700,
                                                          child: DropdownButton<
                                                              String>(
                                                            isExpanded: true,
                                                            underline:
                                                                SizedBox(),
                                                            value:
                                                                valueConvention,
                                                            items:
                                                                listeConvention
                                                                    .map((item) =>
                                                                        DropdownMenuItem<
                                                                            String>(
                                                                          child:
                                                                              Center(child: Text(item)),
                                                                          value:
                                                                              item,
                                                                        ))
                                                                    .toList(),
                                                            onChanged: (text) {
                                                              valueConvention =
                                                                  text
                                                                      as String;
                                                              listeValueConvention[
                                                                  int.parse(
                                                                          valueNbr) -
                                                                      1] = text;
                                                              change.value++;
                                                            },
                                                          )),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 15),
                                                        child: Column(
                                                          children: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  nbrConvention +=
                                                                      1;
                                                                  listeNbrConvention
                                                                      .add(
                                                                          "$nbrConvention");
                                                                  listeValueConvention
                                                                      .add(
                                                                          "Selectionner une Convention");
                                                                  change
                                                                      .value++;
                                                                },
                                                                child: Text(
                                                                    "Ajouter une Convention")),
                                                            TextButton(
                                                                onPressed: () {
                                                                  if (int.parse(
                                                                          valueNbr) !=
                                                                      1) {
                                                                    if (valueNbr ==
                                                                        listeNbrConvention
                                                                            .last) {
                                                                      valueNbr =
                                                                          listeNbrConvention[listeNbrConvention.length -
                                                                              2];
                                                                      valueConvention =
                                                                          listeValueConvention[int.parse(valueNbr) -
                                                                              1];
                                                                    }
                                                                    listeNbrConvention
                                                                        .removeLast();
                                                                    listeValueConvention
                                                                        .removeLast();
                                                                    nbrConvention -=
                                                                        1;
                                                                    change
                                                                        .value++;
                                                                  }
                                                                },
                                                                child: Text(
                                                                    "Supprimer une Convention")),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
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
                                                  style:
                                                      TextStyle(fontSize: 50),
                                                )),
                                              ),
                                              onTap: () async {
                                                if (codeApe.isNotEmpty ==
                                                        true &&
                                                    activite.isNotEmpty ==
                                                        true) {
                                                  ajouterUnCodeAPE(
                                                      codeApe,
                                                      activite,
                                                      domaine,
                                                      description,
                                                      listeValueConvention);

                                                  Navigator.pop(context);
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
                                                  if (codeApe.length +
                                                          activite.length +
                                                          domaine.length +
                                                          description.length !=
                                                      0) {
                                                    popUp = true;
                                                    change.value++;
                                                  } else {
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
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
                                      ),
                                      if (popUp == true)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 100),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 10, sigmaY: 10),
                                            child: Center(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 3,
                                                      color: Colors.black),
                                                  color: Colors.grey[350],
                                                ),
                                                height: 140,
                                                width: 600,
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15),
                                                      child: Text(
                                                        "Êtes-vous sûr de vouloir annuler ?",
                                                        style: TextStyle(
                                                            fontSize: 30),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          TextButton(
                                                              onPressed: () {
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
                                                              onPressed: () {
                                                                popUp = false;
                                                                change.value++;
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
            return Scaffold(
                backgroundColor: Color(0xFF1D2228),
                body: Container(
                  width: double.maxFinite,
                  height: 860,
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                  ),
                ));
          }
        });
  }
}
