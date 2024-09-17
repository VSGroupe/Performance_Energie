


import 'package:flutter/material.dart';


class TabJourHisto extends StatefulWidget {
  const TabJourHisto ({Key? key}) : super(key: key);

  @override
  State<TabJourHisto> createState() => _TabJourHistoState();
}

class _TabJourHistoState extends State<TabJourHisto> {
  late List<Souslist> sous;

  @override
  void initState() {
    sous = Souslist .getSouslist ();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  
    return ListView(
      children: <Widget>[ DataTable(
        headingRowColor: WidgetStateColor.resolveWith(
        (states) => Colors.blue, ),
        columns: const [
          DataColumn(
            label: Text("Nom"),
          ),
          DataColumn(
            label: Text("Prénoms"),
          ),
          DataColumn(
            label: Text("Email"),
          ),
          DataColumn(
            label: Text("Entité"),
          ),
          DataColumn(
            label: Text("Accès"),
          ),
          DataColumn(
            label: Text("Filiale"),
          ),
          DataColumn(
            label: Text("Localisation"),
          ),
          DataColumn(
            label: Text("Processus"),
          ),
          DataColumn(
            label: Text("Fonction"),
          ),
        ],
        
        rows: sous
            .map(
              
              (sous) => DataRow(
                onSelectChanged: (value) {
                  print(sous.nom);
                },
                onLongPress: () {
                  print( "Voulez vous le supprimer");
                },
                cells: [
                DataCell(Text(sous.nom,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic))
                ),
                DataCell(Text(sous.prenom,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic)),
                ),
                DataCell(Text(sous.email,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic))),
                DataCell(Text(sous.entite,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic))),
                DataCell(Text(sous.acces,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic))),
                DataCell(Text(sous.filiale,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic))),
                DataCell(Text(sous.localisation,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic))),
                DataCell(Text(sous.processus,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic))),
                DataCell(Text(sous.fonction,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic))),
              ]),
            )
            .toList(),
      ),
     ]);
  }
}

class Souslist {
  String nom;
  String prenom;
  String email;
  String entite;
  String acces;
  String filiale; 
  String localisation; 
  String processus; 
  String fonction; 

  Souslist ({
    required this.nom,
    required this.prenom,
    required this.email,
    required this.entite,
    required this.acces,
    required this.filiale,
    required this.localisation,
    required this.processus,
    required this.fonction,
  });

  static List<Souslist > getSouslist() {
    return <Souslist >[
      Souslist (
          nom: "LATH",
          prenom: " Mel Dorgeles",
          email: " lathdorgeles99@gmail.com",
          entite: " CIPREL",
          acces: " Administrateur",
          filiale: " CIE ",
          localisation: " Base Yopougon",
          processus: " 75 % ",
          fonction: " Informaticien ",
          ),
      Souslist (
          nom: "MOUSSAN",
          prenom: " Achepo Elvis",
          email: " elvis34@gmail.com",
          entite: " CIPREL",
          acces: " Spectateur",
          filiale: " SODECI ",
          localisation: " Base Cocody",
          processus: " 45 % ",
          fonction: " Responsable RSE ",
          ),
    ];
  }
}