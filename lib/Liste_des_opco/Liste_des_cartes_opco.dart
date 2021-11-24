// ignore: must_be_immutable
import 'package:flutter/material.dart';

import 'Page_suppression_opco.dart';

// ignore: must_be_immutable
class ListeCarteOpco extends StatelessWidget {
  var change;
  int error;
  String nomOpcoSuppr;
  String nomOpco;
  String siteWebOpco;
  String contactOpco;
  String data;
  List<String> liste;

  ListeCarteOpco(this.change, this.contactOpco, this.error, this.nomOpco,
      this.nomOpcoSuppr, this.siteWebOpco, this.liste, this.data);

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                                liste[index].substring(
                                    liste[index].indexOf('|') + 1,
                                    liste[index].lastIndexOf('|')),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Contact',
                                style: TextStyle(
                                    color: Color(0xFFFB8122), fontSize: 30),
                              ),
                              Text(
                                  liste[index].substring(
                                      liste[index].lastIndexOf('|') + 1,
                                      liste[index].length),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25))
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.redAccent),
                            onPressed: () {
                              nomOpcoSuppr = liste[index]
                                  .substring(0, liste[index].indexOf('|'));
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => new PageSupprOpco(
                                          nomOpcoSuppr, data, change)));
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
          },
        ),
      ),
    );
  }
}