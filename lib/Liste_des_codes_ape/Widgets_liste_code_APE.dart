import 'package:flutter/material.dart';

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