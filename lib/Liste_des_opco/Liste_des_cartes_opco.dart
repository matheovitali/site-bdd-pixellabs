import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Fonctions/Ajout_et_suppression.dart';
import 'Page_modif_opco.dart';

// ignore: must_be_immutable
class ListeCarteOpco extends StatelessWidget {
  var change;
  List<String> liste;

  ListeCarteOpco(this.change, this.liste);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 1100,
        child: ListView.builder(
          itemCount: liste.length,
          itemBuilder: (context, index) {
            return Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(width: 2, color: Colors.white)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Container(
                        width: 990,
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            new PageOpco(liste[index])));
                              },
                              child: Text(
                                liste[index],
                                style: TextStyle(
                                    color: Color(0xFFFB8122),
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: PopupMenuButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              padding: EdgeInsets.only(left: 26),
                              child: InkWell(
                                  onTap: () async {
                                    DocumentSnapshot opco =
                                        await FirebaseFirestore.instance
                                            .collection('OPCOS')
                                            .doc(liste[index])
                                            .get();
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                new PageModifOpco(
                                                    change,
                                                    opco,
                                                    liste[index],
                                                    opco.get('web').toString(),
                                                    opco
                                                        .get('creation')
                                                        .toString(),
                                                    opco
                                                        .get('description')
                                                        .toString(),
                                                    opco
                                                        .get('nom & prenom')
                                                        .toString(),
                                                    opco
                                                        .get('telephone')
                                                        .toString(),
                                                    opco
                                                        .get('e-mail')
                                                        .toString())));
                                  },
                                  child: Text(
                                    'Modifier',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ))),
                          PopupMenuItem(
                            padding: EdgeInsets.only(left: 20),
                            child: PopupMenuButton(
                                child: Text('Supprimer',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                itemBuilder: (context) => [
                                      PopupMenuItem(
                                          padding: EdgeInsets.only(left: 16),
                                          child: Text("Supprimer l'OPCO ?",
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      PopupMenuItem(
                                          padding: EdgeInsets.only(left: 38),
                                          child: ElevatedButton(
                                            child: Text('Confirmer',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () async {
                                              await suprimerUneOpco(
                                                  liste[index]);
                                              change.value++;
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.redAccent),
                                          ))
                                    ]),
                          )
                        ],
                      ),
                    ),
                  ],
                ));
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class PageOpco extends StatelessWidget {
  String opcoName;

  PageOpco(this.opcoName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              child: Text(opcoName),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Retour'))
          ],
        ),
      ),
    );
  }
}
