import 'package:flutter/material.dart';

import 'Page_ajout_code_APE.dart';

// ignore: must_be_immutable
class BoutonAjoutCodeAPE extends StatelessWidget {
  ValueNotifier<int> change;

  BoutonAjoutCodeAPE(this.change);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 5, color: Colors.grey),
            color: Color(0xFF1D2228),
          ),
          height: 60,
          width: 300,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new PageAjoutCodeAPE(change)));
            },
            child: Container(
              color: Colors.white,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Ajouter un code APE",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                )
              ]),
            ),
          )),
    );
  }
}

class ChargementPageListeCodeAPE extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF1D2228),
        appBar: AppBar(
          backgroundColor: Color(0xFF1D2228),
          centerTitle: true,
          title: Text(
            'Liste des codes APE',
            style: TextStyle(fontSize: 30),
          ),
        ),
        body: Align(
          alignment: Alignment.center,
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Chargement',
                  style: TextStyle(fontSize: 50, color: Colors.white),
                ),
              ]),
        ));
  }
}