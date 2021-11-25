import 'package:flutter/material.dart';
import 'Page_suppression_opco.dart';

// ignore: must_be_immutable
class ListeCarteOpco extends StatelessWidget {
  var change;
  List<String> liste;

  ListeCarteOpco(this.change, this.liste);
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
                          liste[index],
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
                                "",
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
                              Text("",
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
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => new PageSupprOpco(
                                          liste[index], change)));
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
