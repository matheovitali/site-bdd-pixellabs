import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Fonctions/Ajout_et_suppression.dart';

// ignore: must_be_immutable
class PageModifOpco extends StatelessWidget {
  DocumentSnapshot opco;
  ValueNotifier<int> change;
  String nomOpco;
  String webOpco;
  String creationOpco;
  String descriptionOpco;
  String nomPrenomOpco;
  String telephoneOpco;
  String emailOpco;
  var popUp = ValueNotifier<bool>(false);

  PageModifOpco(
      this.change,
      this.opco,
      this.nomOpco,
      this.webOpco,
      this.creationOpco,
      this.descriptionOpco,
      this.nomPrenomOpco,
      this.telephoneOpco,
      this.emailOpco);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: popUp,
          builder: (context, value, child) {
            return Center(
              child: SingleChildScrollView(
                child: Container(
                    width: double.maxFinite,
                    height: 950,
                    decoration: BoxDecoration(
                      color: Colors.grey[350],
                    ),
                    child: Center(
                      child: Container(
                        width: 1060,
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Text(
                                    "Formulaire de modification d'un OPCO",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 30),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 300,
                                              child: Text(
                                                "Nom de l'OPCO *",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            Container(
                                              width: 300,
                                              child: TextFormField(
                                                initialValue: nomOpco,
                                                decoration: InputDecoration(
                                                  focusColor: Colors.black,
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            9),
                                                  ),
                                                ),
                                                onChanged: (text) {
                                                  nomOpco = text;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 300,
                                              child: Text(
                                                "Site web *",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            Container(
                                              width: 700,
                                              child: TextFormField(
                                                initialValue:
                                                    opco.get('web').toString(),
                                                decoration: InputDecoration(
                                                  focusColor: Colors.black,
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            9),
                                                  ),
                                                ),
                                                onChanged: (text) {
                                                  webOpco = text;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 300,
                                              child: Text(
                                                "Date de création",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            Container(
                                              width: 700,
                                              child: TextFormField(
                                                initialValue: opco
                                                    .get('creation')
                                                    .toString(),
                                                decoration: InputDecoration(
                                                  focusColor: Colors.black,
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            9),
                                                  ),
                                                ),
                                                onChanged: (text) {
                                                  creationOpco = text;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 90),
                                              child: Container(
                                                width: 300,
                                                child: Text(
                                                  "Description",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 700,
                                              child: TextFormField(
                                                initialValue: opco
                                                    .get('description')
                                                    .toString(),
                                                maxLines: 6,
                                                decoration: InputDecoration(
                                                  focusColor: Colors.black,
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            9),
                                                  ),
                                                ),
                                                onChanged: (text) {
                                                  descriptionOpco = text;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 30),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Contact :',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 300,
                                              child: Text(
                                                "Nom & prénom",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            Container(
                                              width: 300,
                                              child: TextFormField(
                                                initialValue: opco
                                                    .get('nom & prenom')
                                                    .toString(),
                                                decoration: InputDecoration(
                                                  focusColor: Colors.black,
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            9),
                                                  ),
                                                ),
                                                onChanged: (text) {
                                                  nomPrenomOpco = text;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 300,
                                              child: Text(
                                                "Numéro de téléphone",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            Container(
                                              width: 300,
                                              child: TextFormField(
                                                initialValue: opco
                                                    .get('telephone')
                                                    .toString(),
                                                decoration: InputDecoration(
                                                  focusColor: Colors.black,
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            9),
                                                  ),
                                                ),
                                                onChanged: (text) {
                                                  telephoneOpco = text;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 300,
                                              child: Text(
                                                "E-mail",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            Container(
                                              width: 400,
                                              child: TextFormField(
                                                initialValue: opco
                                                    .get('e-mail')
                                                    .toString(),
                                                decoration: InputDecoration(
                                                  focusColor: Colors.black,
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            9),
                                                  ),
                                                ),
                                                onChanged: (text) {
                                                  emailOpco = text;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 80),
                                  child: InkWell(
                                    child: Container(
                                      width: 400,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(width: 10)),
                                      child: Center(
                                          child: Text(
                                        'Valider',
                                        style: TextStyle(fontSize: 50),
                                      )),
                                    ),
                                    onTap: () async {
                                      if (nomOpco.isNotEmpty == true &&
                                          webOpco.isNotEmpty == true) {
                                        await ajouterUneOpco(
                                            nomOpco,
                                            webOpco,
                                            creationOpco,
                                            descriptionOpco,
                                            nomPrenomOpco,
                                            telephoneOpco,
                                            emailOpco);
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
                                        if (nomOpco.length +
                                                webOpco.length +
                                                emailOpco.length +
                                                creationOpco.length +
                                                nomPrenomOpco.length +
                                                telephoneOpco.length +
                                                descriptionOpco.length !=
                                            0) {
                                          popUp.value = true;
                                        } else {
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        child: Text(
                                          "Annuler",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                            if (popUp.value == true)
                              Padding(
                                padding: const EdgeInsets.only(top: 100),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 3, color: Colors.black),
                                        color: Colors.grey[350],
                                      ),
                                      height: 140,
                                      width: 600,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: Text(
                                              "Êtes-vous sûr de vouloir annuler ?",
                                              style: TextStyle(fontSize: 30),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'Oui',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    )),
                                                TextButton(
                                                    onPressed: () {
                                                      popUp.value = false;
                                                    },
                                                    child: Text(
                                                      'Non',
                                                      style: TextStyle(
                                                          fontSize: 20),
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
          }),
    );
  }
}
