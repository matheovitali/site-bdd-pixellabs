import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Liste_des_cartes_opco.dart';
import 'Widgets_page_principale.dart';
import 'fonctions_bdd/Fonctions.dart';

class ListeOpco extends StatefulWidget {
  @override
  _ListeOpcoState createState() => _ListeOpcoState();
}

class _ListeOpcoState extends State<ListeOpco> {
  var change = ValueNotifier<int>(0);
  int error = 0;
  String nomOpcoSuppr = "";
  int popUpAjoutOpco = 0;
  int popUpSupprOpco = 0;
  String nomOpco = "";
  String siteWebOpco = "";
  String contactOpco = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ValueListenableBuilder(
          valueListenable: change,
          builder: (context, value, child) {
            return FutureBuilder(
              future: getDocumentFromFirestore(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  List<String> liste = listDesOpco(snapshot.data.toString());
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
                      child: Column(mainAxisSize: MainAxisSize.max, children: [
                        RechargePage(change),
                        BouttonAjoutOpco(nomOpco, siteWebOpco, contactOpco,
                            snapshot.data.toString(), change),
                        ListeCarteOpco(
                            change,
                            contactOpco,
                            error,
                            nomOpco,
                            nomOpcoSuppr,
                            siteWebOpco,
                            liste,
                            snapshot.data.toString())
                      ]),
                    ),
                  );
                } else {
                  return ChargementPageListeOpco();
                }
              },
            );
          }),
    );
  }
}
