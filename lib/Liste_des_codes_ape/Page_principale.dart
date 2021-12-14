import 'package:flutter/material.dart';
import 'package:site_bdd_opco/Liste_des_codes_ape/Widgets_liste_code_APE.dart';
import 'Fonctions/Fonctions.dart';

// ignore: must_be_immutable
class PageListeCodeAPE extends StatelessWidget {
  List<String> listeCodesAPE = [];
  var change = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: change,
        builder: (context, value, child) {
          return FutureBuilder(
              future: getCodesApeFromFirestore(),
              builder: (context, snapshot) {
                if (snapshot.hasError == true) {
                  return Scaffold(
                    backgroundColor: Color(0xFF1D2228),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  listeCodesAPE = snapshot.data as List<String>;
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
                      body: Center(
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  width: 1100,
                                  child: ListView.builder(
                                      itemCount: listeCodesAPE.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.white)),
                                          child: Column(
                                            children: [Text('Bonjour')],
                                          ),
                                        );
                                      }),
                                ),
                              )
                            ]),
                      ));
                } else
                  return ChargementPageListeCodeAPE();
              });
        });
  }
}
