import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

void main() async {
  final db = await Db.create(
      'mongodb://matheo:qbj5ApsM9F4NAD3a@node1-53b642b201559571.database.cloud.ovh.net,node2-53b642b201559571.database.cloud.ovh.net,node3-53b642b201559571.database.cloud.ovh.net/admin?replicaSet=replicaset&tls=true');
  await db.open(secure: false, tlsAllowInvalidCertificates: true);
  final coll = db.collection('AFDAS');
  print(coll.find().toList());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BDD mongodb OPCO',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Liste des OPCO',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
          ),
          centerTitle: true,
        ),
      ),
    );
  }
}
