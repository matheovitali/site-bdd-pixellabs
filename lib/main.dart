import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  print('fini');
}

Future<String> getDocumentFromFirestore() async {
  DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection('Data').doc('OPCOS').get();
  var data = snapshot.data() as Map;
  return data.toString();
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

Map<String, dynamic> getOpcoLineForData(
    String dataString, Map<String, dynamic> resultat) {
  dataString =
      dataString.replaceRange(dataString.length - 1, dataString.length, ',');
  int info1 = 1;
  int info2 = 1;
  int nom1 = 1;
  int nom2 = 1;
  for (int x = 1; x + 1 < dataString.length;) {
    for (; dataString[x] != ':';) x++;
    nom2 = x;
    info1 = x + 2;
    for (; dataString[x] != ',';) x++;
    info2 = x;
    resultat["${dataString.substring(nom1, nom2)}"] =
        "${dataString.substring(info1, info2)}";
    nom1 = x + 2;
  }
  return resultat;
}

List<String> listDesOpco(String dataString) {
  print(dataString);
  dataString =
      dataString.replaceRange(dataString.length - 1, dataString.length, ',');
  List<String> list = [];
  int info1 = 1;
  int info2 = 1;
  int nom1 = 1;
  int nom2 = 1;
  for (int x = 1; x + 1 < dataString.length;) {
    for (; dataString[x] != ':';) x++;
    nom2 = x;
    info1 = x + 2;
    for (; dataString[x] != ',';) x++;
    info2 = x;
    list.add(
        "${dataString.substring(nom1, nom2)}|${dataString.substring(info1, info2)}");
    nom1 = x + 2;
  }
  return list;
}

void suprimerUneOpco(String dataString, int opcoToSuppr) {
  print("suppression");
  Map<String, dynamic> resultat = {};
  CollectionReference data = FirebaseFirestore.instance.collection('Data');
  dataString =
      dataString.replaceRange(dataString.length - 1, dataString.length, ',');
  int x = 1;
  print(dataString);
  for (int nbrVirgule = 0; nbrVirgule <= opcoToSuppr; x++) {
    if (dataString[x] == ',') nbrVirgule++;
    if (nbrVirgule == opcoToSuppr) {
      if (opcoToSuppr == 0) {
        if (','.allMatches(dataString).length - 1 != 0) {
          dataString = dataString.replaceRange(
              x, dataString.indexOf(',', x + 1) + 2, "");
        } else {
          dataString =
              dataString.replaceRange(x, dataString.indexOf(',', x + 1), "");
        }
      } else {
        dataString =
            dataString.replaceRange(x, dataString.indexOf(',', x + 1), "");
      }
      nbrVirgule++;
    }
  }
  dataString =
      dataString.replaceRange(dataString.length - 1, dataString.length, '}');
  print(dataString);
  resultat = getOpcoLineForData(dataString, resultat);
  data
      .doc('OPCOS')
      .set(resultat)
      .then((value) => print("opco suprimée !"))
      .catchError((error) => print("L'ajout de l'opco à échouée !"));
}

void ajouterUneOpco(String dataString, String opcoToAdd, String siteWebOpco,
    String contactOpco) async {
  Map<String, dynamic> resultat = {};
  CollectionReference data = FirebaseFirestore.instance.collection('Data');
  if (dataString.length > 2) {
    resultat = getOpcoLineForData(dataString, resultat);
  }
  resultat[opcoToAdd] = "$siteWebOpco|$contactOpco";
  data
      .doc('OPCOS')
      .set(resultat)
      .then((value) => print("opco ajoutée !"))
      .catchError((error) => print("L'ajout de l'opco à échouée !"));
  sleep(const Duration(seconds: 2));
}

class ListeOpco extends StatefulWidget {
  @override
  _ListeOpcoState createState() => _ListeOpcoState();
}

class _ListeOpcoState extends State<ListeOpco> {
  int error = 0;
  int popUpAjoutOpco = 0;
  String nomOpco = "";
  String siteWebOpco = "";
  String contactOpco = "";
  @override
  Widget build(BuildContext context) {
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
            body: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(mainAxisSize: MainAxisSize.max, children: [
                    Padding(
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
                              setState(() {});
                            },
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Recharger la page",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900),
                                    )
                                  ]),
                            ),
                          )),
                    ),
                    Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 5, color: Colors.grey),
                          color: Color(0xFF1D2228),
                        ),
                        height: 70,
                        width: 550,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (popUpAjoutOpco == 0)
                                popUpAjoutOpco = 1;
                              else
                                popUpAjoutOpco = 0;
                            });
                          },
                          child: Container(
                            color: Colors.white,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Ajouter un opco",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w900),
                                  )
                                ]),
                          ),
                        )),
                    Expanded(
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
                                      border: Border.all(
                                          width: 5, color: Colors.white)),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          liste[index].substring(
                                              0, liste[index].indexOf('|')),
                                          style: TextStyle(
                                              color: Color(0xFFFB8122),
                                              fontSize: 50,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
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
                                                    liste[index].indexOf('|') +
                                                        1,
                                                    liste[index]
                                                        .lastIndexOf('|')),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'Contact',
                                                style: TextStyle(
                                                    color: Color(0xFFFB8122),
                                                    fontSize: 30),
                                              ),
                                              Text(
                                                  liste[index].substring(
                                                      liste[index].lastIndexOf(
                                                              '|') +
                                                          1,
                                                      liste[index].length),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25))
                                            ],
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15, bottom: 15),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.redAccent),
                                            onPressed: () {
                                              setState(() {
                                                suprimerUneOpco(
                                                    snapshot.data.toString(),
                                                    index);
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: Text(
                                                "Supprimer",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            )),
                                      ),
                                    ],
                                  )),
                            );
                          },
                        ),
                      ),
                    ),
                  ]),
                ),
                if (popUpAjoutOpco == 1)
                  SingleChildScrollView(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Center(
                        child: Container(
                            width: 500,
                            height: 700,
                            decoration: BoxDecoration(
                              color: Colors.grey[350],
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Text(
                                    "Formulaire d'ajout d'une opco",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 50),
                                    child: Text(
                                      "Nom de l'opco",
                                      style: TextStyle(fontSize: 25),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Container(
                                    width: 400,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          helperText: "Ne peut pas être null",
                                          focusColor: Colors.black,
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(),
                                          hintText: "Entrez le nom de l'opco"),
                                      onChanged: (text) {
                                        nomOpco = text;
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 40),
                                    child: Text(
                                      "Site web de l'opco",
                                      style: TextStyle(fontSize: 25),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Container(
                                    width: 400,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          focusColor: Colors.black,
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(),
                                          hintText:
                                              "Entrez le site web de l'opco"),
                                      onChanged: (text) {
                                        siteWebOpco = text;
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 60),
                                    child: Text(
                                      "Contact de l'opco",
                                      style: TextStyle(fontSize: 25),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Container(
                                    width: 400,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          focusColor: Colors.black,
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(),
                                          hintText:
                                              "Entrez les contacts de l'opco"),
                                      onChanged: (text) {
                                        contactOpco = text;
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 80),
                                  child: InkWell(
                                    child: Container(
                                      width: 400,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(width: 10)),
                                      child: Center(
                                          child: Text(
                                        'Valider',
                                        style: TextStyle(fontSize: 50),
                                      )),
                                    ),
                                    onTap: () {
                                      if (nomOpco.isNotEmpty == true) {
                                        error = 0;
                                        setState(() {
                                          popUpAjoutOpco = 0;
                                          ajouterUneOpco(
                                              snapshot.data.toString(),
                                              nomOpco,
                                              siteWebOpco,
                                              contactOpco);
                                        });
                                      }
                                    },
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                  )
              ],
            ),
          );
        } else {
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
      },
    );
  }
}
