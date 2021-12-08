import 'package:flutter/material.dart';

import 'Fonctions/Ajout_et_suppression.dart';

// ignore: must_be_immutable
class PageSupprOpco extends StatelessWidget {
  ValueNotifier<int> change;
  String nomOpcoSuppr;

  PageSupprOpco(this.nomOpcoSuppr,this.change);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 500,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.grey[350],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Voulez-vous supprimez l'opco $nomOpcoSuppr?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () async {
                          await suprimerUneOpco(nomOpcoSuppr);
                          Navigator.pop(context);
                          change.value++;
                        },
                        child: Text('Oui', style: TextStyle(fontSize: 20))),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Non', style: TextStyle(fontSize: 20)))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
