import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// https://entreprise.data.gouv.fr/api/sirene/v3/etablissements/
// https://cloud.mongodb.com/api/atlas/v1.0/groups/6179422dfb302f696320988f/dataLakes?pretty=true
void main() {
  print('debut');
  http
      .get(Uri.parse(
          'https://cloud.mongodb.com/api/atlas/v1.0/groups/6179422dfb302f696320988f/dataLakes?pretty=true'))
      .then((response) {
    print(json.decode(response.body));
    print('fin');
  });
  void addToList(List data, List add) {
    data.add(add);
  }

  List data = [];
  // ignore: non_constant_identifier_names
  List AFDAS = [
    "86:Convention collective nationale des entreprises de publicité et assimilées,214:Convention collective régionale des ouvriers des entreprises de presses de la région parisienne"
  ];

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
  addToList(data, AFDAS);
  runApp(MyApp(listOPCO, data));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  String getName(String opco) {
    String name = "";
    int i = 0;
    // print(opco);
    // print("oof");
    for (; opco[i] != ","; i += 1) {
      name = opco.substring(0, i + 1);
    }
    print(name);
    return name;
  }

  List listOPCO;
  List data;
  MyApp(this.listOPCO, this.data);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFF1D2228)),
      title: 'BDD mongodb OPCO',
      home: Scaffold(
        body: SingleChildScrollView(
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
              Container(
                height: 10,
                color: Color(0xFF1D2228),
              ),
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
            ],
          ),
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
