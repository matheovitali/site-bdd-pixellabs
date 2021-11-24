import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Liste_des_opco/Page_principale.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AppStart());
}

void sendData(List<String> dataList) async {
  CollectionReference data = FirebaseFirestore.instance.collection('Data');
  if (dataList[0].length > 1) {
    await data
        .doc('Conventions')
        .set({'${dataList[1]}': '${dataList[0]})'})
        .then((value) => print("Convention ajoutée !"))
        .catchError((error) => print("L'ajout de la convention à échoué !"));
  }
  if (dataList[4].length > 1) {
    await data
        .doc('Secteurs')
        .set({'${dataList[5]}': '${dataList[4]})'})
        .then((value) => print("Secteur d'activitée ajouté !"))
        .catchError(
            (error) => print("L'ajout du secteur d'activitée à échoué !"));
  }
}

void extraireData(String dataString, String fileName) async {
  CollectionReference data = FirebaseFirestore.instance.collection('Data');
  int i = 0;
  int word = 0;
  int avaitGuillemets = 0;
  int guillemets = 0;
  List<String> dataList = [];
  data
      .doc('OPCOS')
      .set({'$fileName': ''})
      .then((value) => print("opco ajoutée !"))
      .catchError((error) => print("L'ajout de l'opco à échouée !"));
  for (; dataString[i] != '\n';) i++;
  i++;
  word = i;
  for (; i != dataString.length; i++) {
    if (dataString[i] == '"') {
      avaitGuillemets = 1;
      guillemets == 1 ? guillemets = 0 : guillemets = 1;
    }
    if (dataString[i] == ',' && guillemets == 0 || dataString[i] == '\n') {
      if (avaitGuillemets == 1) {
        dataList.add(dataString.substring(word + 1, i - 2));
        avaitGuillemets = 0;
      } else {
        dataList.add(dataString.substring(word, i));
      }
      word = i + 1;
      if (dataString[i] == '\n') {
        sendData(dataList);
        dataList = [];
      }
    }
  }
}


class AppStart extends StatefulWidget {
  @override
  _AppStartState createState() => _AppStartState();
}

class _AppStartState extends State<AppStart> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MyApp();
          }
          return Scaffold(
            backgroundColor: Color(0xFF1D2228),
            body: Text('Chargement'),
          );
        });
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFF1D2228)),
      title: 'Pixellabs',
      home: MyHome(),
    );
  }
}

// ignore: must_be_immutable
class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          shadowColor: Colors.white,
          backgroundColor: Color(0xFF1D2228),
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'PIXELLABS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 200,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFB8122),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 15),
                child: TextButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles();
                      if (result == null) return;
                      PlatformFile file = result.files.first;
                      OpenFile.open(file.bytes.toString());
                      String fileData =
                          Utf8Decoder().convert(file.bytes!.toList());
                      extraireData(
                          fileData,
                          file.name
                              .substring(0, file.name.lastIndexOf('-') - 1));
                    },
                    child: Text(
                      'Choisir un fichier csv',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w400),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
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
                                builder: (context) => new PageBDD()));
                      },
                      child: Container(
                        color: Colors.white,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Acceder à la base de données",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w900),
                              )
                            ]),
                      ),
                    )),
              ),
            ],
          ),
        ),
        drawer: Container(
            width: 300,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new ListeOpco()));
                  },
                  child: Container(
                    width: 300,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 35, left: 55),
                      child: Text(
                        'Liste des opcos',
                        style: TextStyle(
                            color: Color(0xFFFB8122),
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xFF1D2228),
                        border: Border.all(color: Colors.white, width: 1)),
                  ),
                ),
                Container(
                  width: 300,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 35, left: 25),
                    child: Text(
                      'Liste des conventions',
                      style: TextStyle(
                          color: Color(0xFFFB8122),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Color(0xFF1D2228),
                      border: Border.all(color: Colors.white, width: 1)),
                ),
                Container(
                  width: 300,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 35, left: 30),
                    child: Text(
                      'Liste des codes ape',
                      style: TextStyle(
                          color: Color(0xFFFB8122),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Color(0xFF1D2228),
                      border: Border.all(color: Colors.white, width: 1)),
                ),
              ],
            )));
  }
}

// ignore: must_be_immutableListTile(title: Text('Liste des opcos'),),
class PageBDD extends StatefulWidget {
  @override
  _PageBDDState createState() => _PageBDDState();
}

class _PageBDDState extends State<PageBDD> {
  List listOPCO = [
    "AFDAS",
    "AKTO",
    "ATLAS",
    "Cohésion social / Uniformation",
    "CONSTRUCTYS",
    "EP",
    "Mobilité",
    "OCAPIAT",
    "OPCO 21",
    "OPCommerce",
    "Santé"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 500,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: listOPCO.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 5, color: Colors.grey),
                          color: Color(0xFF1D2228),
                        ),
                        height: 70,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        new PageOPCO("${listOPCO[index]}")));
                          },
                          child: Container(
                            color: Colors.white,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${listOPCO[index]}",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w900),
                                  )
                                ]),
                          ),
                        )),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 6, color: Colors.white)),
                width: 170,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 9),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 35,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Retour',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class PageOPCO extends StatefulWidget {
  String name;
  PageOPCO(this.name);

  @override
  _PageOPCOState createState() => _PageOPCOState(name);
}

class _PageOPCOState extends State<PageOPCO> {
  String name;
  _PageOPCOState(this.name);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(children: [
            Text(
              '$name',
              style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFB8122)),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Retour'))
          ]),
        ),
      ),
    );
  }
}