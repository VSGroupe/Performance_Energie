

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:perf_energie/widgets/Composant/Routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';



// APPEL DES FONCTIONS GLOBALES::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
List<dynamic> globalAxes = [];
List<dynamic> globalEnjeux = [];
List<dynamic> globalCritere = [];
List<dynamic> globalProcessus = [];
List<dynamic> globalTermino = [];
List<dynamic> globalUnite = [];
List<dynamic> globalType = [];
List<dynamic> globalgroup = [];
List<dynamic> globalpays = [];
List<dynamic> globalentite = [];
List<dynamic> globalRole = [];
List<dynamic> globalFiliere = [];
List<dynamic> globalFiliale= [];
List<dynamic> globalVille = [];
List<dynamic> globalIndic = [];
List<dynamic> globalFormule = [];
Map<String, List<String>> globalElement = {};
int numeDerValeur = 0;
dynamic nomFormule = "";

// ignore: non_constant_identifier_names
void OpenPage (BuildContext context, Widget page){
  Navigator.push(context,PageRouteBuilder(pageBuilder: (_, __, ___) => page));
}



///////////////////////////////////////////////////////////////////////////////////////////////////////

Future<void> main() async {
  await Supabase.initialize(url: 'https://ztamjhtrobjzqktyrjei.supabase.co',
 anonKey: 
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp0YW1qaHRyb2JqenFrdHlyamVpIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTQ4NTY3ODMsImV4cCI6MjAxMDQzMjc4M30.jWbIYuXwGtqgsg_dLsDfOfmY5qpj8Pl1wAL67x1SlCs");

runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataProvider()), // modèle existant
        ChangeNotifierProvider(create: (context) => GroupState()), // modèle GroupState
        ChangeNotifierProvider(create: (context) => LoginName()), // modèle GroupState
      ],
      child: const MyApp(),
    ),
  );
  
}


class GroupState extends ChangeNotifier {
  Map<String, bool> openGroups = {
    'GENERAL': false,
    'GOURVENANCE ETHIQUE': false,
    'EMPLOI ET CONDITIONS DE TRAVAIL': false,
    'COMMUNAUTE ET INNOVATION SOCIALE': false,
    'ENVIRONNEMENT': false,
  };
  void toggleGroup(String groupName) {
    openGroups[groupName] = !openGroups[groupName]!;
    notifyListeners();
  }
}

class LoginName extends ChangeNotifier {
  Map<dynamic, dynamic>? name;
  void updateData(Map<dynamic, dynamic> newName) {
    name = newName;
    notifyListeners();
  }
}


class DataProvider extends ChangeNotifier {
  String data = "...";
  void updateData(String newData) {
    data = newData;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: RouteClass.router,
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      title: "Performance Energie");
  }
}  


