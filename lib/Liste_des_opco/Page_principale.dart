import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Liste_des_cartes_opco.dart';
import 'Widgets_page_principale.dart';
import 'fonctions_bdd/Fonctions.dart';

// ignore: must_be_immutable
class ListeOpco extends StatelessWidget {
  var change = ValueNotifier<int>(0);
  List<String> liste = [];
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
                  liste = snapshot.data as List<String>;
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
                          BouttonAjoutOpco(change),
                          ListeCarteOpco(
                      change,
                      liste,
                          )
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
