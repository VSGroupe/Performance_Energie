import 'package:flutter/material.dart';
import 'package:perf_energie/main.dart';
import 'package:perf_energie/pages/Rapport/TabloBord.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';
import 'package:perf_energie/widgets/Constant/ImgConstant.dart';
import 'package:provider/provider.dart';

// LA LISTE DES DONNES DES CONSOLIDES:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

// ignore: camel_case_types
class Consolides extends StatefulWidget {
  const Consolides({super.key});

  @override
  State<Consolides> createState() => _ConsolidesState();
}

// ignore: camel_case_types
class _ConsolidesState extends State<Consolides> {
  final objet = [
    {
      "name": "Consolidés Général (SME)",
    },
    {
      "name": "Conso Autres Périmètres",
    },
    {
      "name": "Consolidés Usines",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: objet.length,
        itemBuilder: (context, index) {
          final event = objet[index];
          final name = event['name'];

          return Card(
              elevation: 0,
              color: Colors.transparent,
              child: ListTile(
                  leading: Image.asset(
                    imgactivitedoc,
                    height: 30,
                  ),
                  title: Container(
                    alignment:
                      Alignment.centerLeft, // Alignement du contenu à gauche
                    child: TextButton(
                      onPressed: () {
                        print(name);
                      },
                      child: Text(
                        "$name",
                        textAlign: TextAlign.left, // Alignement à gauche du texte
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor),
                      ),
                    ),
                  ),
                  trailing: const Icon(Icons.more_vert)));
        });
  }
}

// LA LISTE DES DONNES DES AUTRES PERIMETRES:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

// ignore: camel_case_types
class AutrePerim extends StatefulWidget {
  const AutrePerim({super.key});

  @override
  State<AutrePerim> createState() => _AutrePerimState();
}

// ignore: camel_case_types
class _AutrePerimState extends State<AutrePerim> {
  final objet = [
    {
      "name": "PERIMETRE 1",
    },
    {
      "name": "PERIMETRE 2",
    },
    {
      "name": "PERIMETRE 3",
    },
    {
      "name": "PERIMETRE 4",
    },
    {
      "name": "PERIMETRE 5",
    },
    {
      "name": "PERIMETRE 6",
    },
    {
      "name": "PERIMETRE 7",
    },
    {
      "name": "PERIMETRE 8",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: objet.length,
        itemBuilder: (context, index) {
          final event = objet[index];
          final name = event['name'];

          return Card(
              elevation: 0,
              color: Colors.transparent,
              child: ListTile(
                  leading: Image.asset(
                    imgactivitedoc,
                    height: 30,
                  ),
                  title: Container(
                    alignment:
                      Alignment.centerLeft, // Alignement du contenu à gauche
                    child: TextButton(
                      onPressed: () {
                        print(name);
                      },
                      child: Text(
                        "$name",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 145, 109, 2)),
                      ),
                    ),
                  ),
                  trailing: const Icon(Icons.more_vert)));
        });
  }
}

// LA LISTE DES DONNES DES USINES:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

// ignore: camel_case_types
class Usines extends StatefulWidget {
  const Usines({super.key});

  @override
  State<Usines> createState() => _UsinesState();
}

// ignore: camel_case_types
class _UsinesState extends State<Usines> {
  final objet = [
    {
      "name": "USINE 1",
    },
    {
      "name": "USINE 2",
    },
    {
      "name": "USINE 3",
    },
    {
      "name": "USINE 4",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: objet.length,
        itemBuilder: (context, index) {
          final event = objet[index];
          final name = event['name'];

          return Card(
              elevation: 0,
              color: Colors.transparent,
              child: ListTile(
                leading: Image.asset(
                  imgactivitedoc,
                  height: 30,
                ),
                title: Container(
                  alignment:
                      Alignment.centerLeft, // Alignement du contenu à gauche
                  child: TextButton(
                    onPressed: () {
                      Provider.of<DataProvider>(context, listen: false)
                          .updateData("$name");
                      OpenPage(context, const TabloBord());
                      print(name);
                    },
                    child: Text(
                      "$name",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: secondColor,
                      ),
                    ),
                  ),
                ),
                trailing: const Icon(Icons.more_vert),
              ));
        });
  }
}

// LA LISTE DES DONNES DES RESSOURCES:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

// ignore: camel_case_types
class Ressources extends StatefulWidget {
  const Ressources({super.key});

  @override
  State<Ressources> createState() => _RessourcesState();
}

// ignore: camel_case_types
class _RessourcesState extends State<Ressources> {
  final objet = [
    {
      "name": "CONTRIBUTEUR",
    },
    {
      "name": "ORGANIGRAMME",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: objet.length,
        itemBuilder: (context, index) {
          final event = objet[index];
          final name = event['name'];

          return Card(
              elevation: 0,
              color: Colors.transparent,
              child: ListTile(
                contentPadding: EdgeInsets.zero, // Supprime le padding par défaut
                  leading: Image.asset(
                    imgactivitedoc,
                    height: 30,
                  ),
                  title: Container(
                    alignment:
                      Alignment.centerLeft, // Alignement du contenu à gauche
                    child: TextButton(
                      onPressed: () {
                        print(name);
                      },
                      child: Text(
                        "$name",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor),
                      ),
                    ),
                  ),
                  trailing: const Icon(Icons.more_vert)));
        });
  }
}
