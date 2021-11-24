// ignore: must_be_immutable
import 'package:flutter/material.dart';

import 'fonctions_bdd/Ajout_et_suppression.dart';

// ignore: must_be_immutable
class PageAjoutOpco extends StatelessWidget {
  ValueNotifier<int> change;
  String nomOpco;
  String siteWebOpco;
  String contactOpco;
  String data;

  PageAjoutOpco(
      this.nomOpco, this.siteWebOpco, this.contactOpco, this.data, this.change);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
              width: double.maxFinite,
              height: 730,
              decoration: BoxDecoration(
                color: Colors.grey[350],
              ),
              child: Row(
                children: [Column(children: [Text(
                        "Nom de l'OPCO",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),],),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      "Formulaire d'ajout d'une opco",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                          width: 400,
                          child: TextField(
                            decoration: InputDecoration(
                                helperText: "Ne peut pas être null",
                                focusColor: Colors.black,
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                hintText: "Entrez le nom de l'opco"),
                            onChanged: (text) {
                              nomOpco = text;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: InkWell(
                      child: Container(
                        width: 400,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white, border: Border.all(width: 10)),
                        child: Center(
                            child: Text(
                          'Valider',
                          style: TextStyle(fontSize: 50),
                        )),
                      ),
                      onTap: () async {
                        if (nomOpco.isNotEmpty == true) {
                          await ajouterUneOpco(
                              data, nomOpco, siteWebOpco, contactOpco);
                          Navigator.pop(context);
                          change.value++;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: Colors.redAccent),
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
              )),
        ),
      ),
    );
  }
}
