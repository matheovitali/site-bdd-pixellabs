import 'package:flutter/material.dart';
import 'Page_ajout_opco.dart';

// ignore: must_be_immutable
class BouttonAjoutOpco extends StatelessWidget {
  ValueNotifier<int> change;
  String nomOpco;
  String siteWebOpco;
  String contactOpco;
  String data;

  BouttonAjoutOpco(
      this.nomOpco, this.siteWebOpco, this.contactOpco, this.data, this.change);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 5, color: Colors.grey),
          color: Color(0xFF1D2228),
        ),
        height: 70,
        width: 550,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new PageAjoutOpco(
                        nomOpco, siteWebOpco, contactOpco, data, change)));
          },
          child: Container(
            color: Colors.white,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Ajouter un opco",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
              )
            ]),
          ),
        ));
  }
}

class ChargementPageListeOpco extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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