import 'package:flutter/material.dart';
import 'fonctions_bdd/Ajout_et_suppression.dart';

// ignore: must_be_immutable
class PageAjoutOpco extends StatelessWidget {
  ValueNotifier<int> change;
  String nomOpco = "";
  String webOpco = "";
  String creationOpco = "";
  String descriptionOpco = "";
  String nomPrenomOpco = "";
  String telephoneOpco = "";
  String emailOpco = "";

  PageAjoutOpco(this.change);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          "Formulaire d'ajout d'une opco",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w900),
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
                                  Text(
                                    "Nom de l'OPCO *",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 131),
                                    child: Container(
                                      width: 300,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          focusColor: Colors.black,
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(9),
                                          ),
                                        ),
                                        onChanged: (text) {
                                          nomOpco = text;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Row(
                                children: [
                                  Text(
                                    "Site web *",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 192),
                                    child: Container(
                                      width: 700,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          focusColor: Colors.black,
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(9),
                                          ),
                                        ),
                                        onChanged: (text) {
                                          webOpco = text;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Row(
                                children: [
                                  Text(
                                    "Date de création",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 136),
                                    child: Container(
                                      width: 700,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          focusColor: Colors.black,
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(9),
                                          ),
                                        ),
                                        onChanged: (text) {
                                          creationOpco = text;
                                        },
                                      ),
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
                                    padding: const EdgeInsets.only(bottom: 90),
                                    child: Text(
                                      "Description",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 180),
                                    child: Container(
                                      width: 700,
                                      child: TextField(
                                        maxLines: 6,
                                        decoration: InputDecoration(
                                          focusColor: Colors.black,
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(9),
                                          ),
                                        ),
                                        onChanged: (text) {
                                          descriptionOpco = text;
                                        },
                                      ),
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
                                  Text(
                                    "Nom & prénom",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 148),
                                    child: Container(
                                      width: 300,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          focusColor: Colors.black,
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(9),
                                          ),
                                        ),
                                        onChanged: (text) {
                                          nomPrenomOpco = text;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Row(
                                children: [
                                  Text(
                                    "Numéro de téléphone",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 90),
                                    child: Container(
                                      width: 300,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          focusColor: Colors.black,
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(9),
                                          ),
                                        ),
                                        onChanged: (text) {
                                          telephoneOpco = text;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Row(
                                children: [
                                  Text(
                                    "E-mail",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 227),
                                    child: Container(
                                      width: 400,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          focusColor: Colors.black,
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(9),
                                          ),
                                        ),
                                        onChanged: (text) {
                                          emailOpco = text;
                                        },
                                      ),
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
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.redAccent),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                "Annuler",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
