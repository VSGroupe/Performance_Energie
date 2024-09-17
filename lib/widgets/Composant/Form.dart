import 'package:flutter/material.dart';
import 'package:perf_energie/pages/Pilotage/Pilotage1.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';
import 'package:perf_energie/widgets/Constant/ImgConstant.dart';

// CADRE DU MENU (AUDIT, PILOTE, PERFORMANCE)::::::::::::::::::::::::::::::::::::::::::::

class BlockMenuAcc extends StatelessWidget {
  final String imgAcess;
  final String text1;
  final String text2;
  final double? size1;
  final double? size2;
  final Color? color1;
  final Color? color2;
  final Color? shadow;
  final FontWeight? weight1;
  final FontWeight? weight2;
  final double? elevation;

  const BlockMenuAcc(
      {Key? key,
      required this.text1,
      required this.text2,
      required this.imgAcess,
      this.color1,
      this.color2,
      this.shadow,
      this.size1,
      this.size2,
      this.weight1,
      this.weight2,
      this.elevation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? 30,
      shadowColor: shadow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              text1,
              style: TextStyle(
                fontSize: size1 ?? 30,
                fontWeight: weight1 ?? FontWeight.bold,
                color: color1 ?? errorlightColor,
              ),
            ),
            Text(
              text2,
              style: TextStyle(
                fontSize: size2 ?? 15,
                fontWeight: weight2 ?? FontWeight.bold,
                color: color2 ?? textColor,
              ),
            ),
            // const SizedBox(height: 20),
            Center(
                child: Image.asset(
              imgAcess,
              height: 180,
            ))
          ],
        ),
      ),
    );
  }
}

// BARRE SECONDAIRE DES SOUS MENU :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class MenuForm extends StatelessWidget {
  final String formtext;
  final double? long;
  final double? larg;
  final Color? color;
  final double? topright;
  final double? topleft;
  final Color? textcolor;

  const MenuForm({
    Key? key,
    required this.formtext,
    this.long,
    this.larg,
    this.color,
    this.topright,
    this.topleft,
    this.textcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:  BorderRadius.only(
          topLeft: Radius.circular(topleft?? 20), topRight: Radius.circular(topleft?? 20)),
      child: Container(
        width: long ?? 420,
        height: larg ?? 40,
        decoration: BoxDecoration(
          color: color ?? secondColor,
        ),
        child: Center(
          child: Text(
            formtext,
            style: TextStyle(
                fontSize: 18,
                color: textcolor ?? texinvColor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

// CONTAINER DES SOUS MENUS::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class ContenuSousMenu extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double? leftbottom;
  final double? lefttop;
  final double? righttop;
  final double? rightbottom;
  final double? borderwidh;
  final Color? color;

  const ContenuSousMenu(
      {required this.child,
      this.width,
      this.height,
      this.lefttop,
      this.righttop,
      this.leftbottom,
      this.rightbottom,
      this.borderwidh,
      this.color,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width ?? 420,
        height: height ?? 300,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(lefttop ?? 0),
                topRight: Radius.circular(righttop ?? 0),
                bottomLeft: Radius.circular(leftbottom ?? 20),
                bottomRight: Radius.circular(rightbottom ?? 20)),
            border: Border.all(
                color: color ?? secondColor, width: borderwidh ?? 2)),
        child: child);
  }
}

// BARRE PRICIPALE DES  MENUS :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class MenuTitle extends StatelessWidget {
  final String formtext;
  final double? long;
  final double? larg;
  final Color? color;
  final Color? textcolor;

  const MenuTitle(
      {Key? key,
      required this.formtext,
      this.long,
      this.larg,
      this.color,
      this.textcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
        width: long ?? 1300,
        height: larg ?? 50,
        decoration: BoxDecoration(
          color: color ?? primaryColor,
        ),
        child: Center(
          child: Text(
            formtext,
            style: TextStyle(
                fontSize: 25,
                color: textcolor ?? texinvColor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

// LA LISTE DES ACTIVITES DES INDICATEURS DE PERFORMANCE:::::::::::::::::::::::::::::::::::::::::::

// ignore: camel_case_types
class activitelist extends StatefulWidget {
  const activitelist({super.key});

  @override
  State<activitelist> createState() => _activitelistState();
}

// ignore: camel_case_types
class _activitelistState extends State<activitelist> {
  final objet = [
    {
      "name": "Suivi des indicateurs de performances",
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
                    imgactivitelist,
                    height: 30,
                  ),
                  title: Container(
                    alignment:
                      Alignment.centerLeft, // Alignement du contenu à gauche
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (_, __, ___) => const Pilotage1()));
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

// LA LISTE DES DONNES DES INDICATEURS:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

// ignore: camel_case_types
class activitedoc1 extends StatefulWidget {
  const activitedoc1({super.key});

  @override
  State<activitedoc1> createState() => _activitedocState();
}

// ignore: camel_case_types
class _activitedocState extends State<activitedoc1> {
  final objet = [
    {
      "name": "Politique SME",
    },
    {
      "name": "Attentes des parties intéressés",
    },
    {
      "name": "Responsabilités et autorités",
    },
    {
      "name": "Fonctions / Périmètres",
    },
    {
      "name": "Non conformités et actions correctives",
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
                            color: textColor),
                      ),
                    ),
                  ),
                  trailing: const Icon(Icons.more_vert)));
        });
  }
}

// LA LISTE 2 DES DONNES DES INDICATEURS:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

// ignore: camel_case_types
class activitedoc2 extends StatefulWidget {
  const activitedoc2({super.key});

  @override
  State<activitedoc2> createState() => _activitedoc2State();
}

// ignore: camel_case_types
class _activitedoc2State extends State<activitedoc2> {
  final objet = [
    {
      "name": "Revues de management énergétique",
    },
    {
      "name": "Audit interne",
    },
    {
      "name": "Risques et opportunités",
    },
    {
      "name": "Revues énergétiques",
    },
    {
      "name": "Suivi des objectis énergétiques",
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
                    imgactivitedoc2,
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

// LA LISTE DES AUDITS :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

// ignore: camel_case_types
class audit extends StatefulWidget {
  const audit({super.key});

  @override
  State<audit> createState() => _auditState();
}

// ignore: camel_case_types
class _auditState extends State<audit> {
  final objet = [
    {
      "name": "Demarrer l'audit 1",
    },
    {
      "name": "Demarrer l'audit 2",
    },
    {
      "name": "Demarrer l'audit 3",
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
                    imgaudit,
                    height: 30,
                  ),
                  title: Container(
                    alignment:
                      Alignment.centerLeft, // Alignement du contenu à gauche
                    child: TextButton(
                      onPressed: () {},
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

// LA LISTE DES TACHES DES AUDITS:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

// ignore: camel_case_types
class auditask extends StatefulWidget {
  const auditask({super.key});

  @override
  State<auditask> createState() => _auditaskState();
}

// ignore: camel_case_types
class _auditaskState extends State<auditask> {
  final objet = [
    {
      "name": "Liste des auditeurs",
    },
    {
      "name": "Politique energetique",
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
                    imgauditask,
                    height: 30,
                  ),
                  title: Container(
                    alignment:
                      Alignment.centerLeft, // Alignement du contenu à gauche
                    child: TextButton(
                      onPressed: () {},
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

// LA LISTE DES DONNES D'AUDITS:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

// ignore: camel_case_types
class listAdit extends StatefulWidget {
  const listAdit({super.key});

  @override
  State<listAdit> createState() => _listAditState();
}

// ignore: camel_case_types
class _listAditState extends State<listAdit> {
  final objet = [
    {
      "adit": "AUDIT 1",
      "date": "04 au 13/04/2022",
      "obj1": "GENERAL",
      "obj2": "",
      "obj3": "",
    },
    {
      "adit": "AUDIT 2",
      "date": "29/03 au 07/04/2023",
      "obj1": "Source Manquante",
      "obj2": "",
      "obj3": "",
    },
    {
      "adit": "AUDIT 3",
      "date": "",
      "obj1": "GENERAL",
      "obj2": "ADMINISTRATION",
      "obj3": "PRODUCTION D'ELECTRICITE",
    },
    {
      "adit": "AUDIT 4",
      "date": "",
      "obj1": "GENERAL",
      "obj2": "ADMINISTRATION",
      "obj3": "PRODUCTION D'ELECTRICITE",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: objet.length,
        itemBuilder: (context, index) {
          final event = objet[index];
          final adit = event['adit'];
          final date = event['date'];
          final obj1 = event['obj1'];
          final obj2 = event['obj2'];
          final obj3 = event['obj3'];
          return Card(
              elevation: 0,
              color: Colors.transparent,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        imglistaudit,
                        height: 30,
                      ),
                      Text(
                        "$adit " "[ $date ]",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor),
                      )
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "$obj1",
                      style: const TextStyle(fontSize: 16, color: textColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "$obj2",
                      style: const TextStyle(fontSize: 16, color: textColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "$obj3",
                      style: const TextStyle(fontSize: 16, color: textColor),
                    ),
                  ),
                ],
              ));
        });
  }
}

// TABLE SANS LIGNE HORIZONTALE :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// stateless to stateful
class TabResult extends StatefulWidget {

  const TabResult({super.key});

  @override
  State<TabResult> createState() => _TabResultState();
}

class _TabResultState extends State<TabResult> {
  // Exemple de liste de données
  final List<List<String>> data = [
    ["RESULTATS", "INTERPRETATIONS"],
    ["0 à 25%", "Entreprise en hésitation, faible ou pas du tout"],
    [
      "26 à 50%",
      "Entreprise engagée, avec des pratiques en construction ou en essai"
    ],
    [
      "51 à 75%",
      "Pratiques énergétiqueq confirmées avec une forte implication interne"
    ],
    [
      "76 à 100%",
      "Pratique énegétiques exemplaires avec des données d'énergie subtantielle"
    ],
    // Ajoutez autant de lignes que nécessaire
  ];

  @override
  Widget build(BuildContext context) {
    return Table(
      // border: TableBorder.all(),
      children: data.map((List<String> row) {
        return TableRow(
          children: row.map((String cell) {
            return TableCell(
              child: Center(child: Text(cell)),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}

// INTREPRETATIONS ET RESULTATS DES AUDITS (TABLEAU STATITIQUE) ::::::::::::::::::::::::::::::::::::::::::::::::::::::

// ignore: camel_case_types
class dataResultat extends StatefulWidget {
  const dataResultat({super.key});

  @override
  State<dataResultat> createState() => _dataResultatState();
}

// ignore: camel_case_types
class _dataResultatState extends State<dataResultat> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(
            label: Text(
          "RESULTATS",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        )),
        DataColumn(
            label: Text(
          "INTERPRETATIONS",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ))
      ],
      rows: const [
        DataRow(cells: [
          DataCell(Text("0 à 25%",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic))),
          DataCell(Text("Entreprise en hésitation, faible ou pas du tout",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic))),
        ]),
        DataRow(cells: [
          DataCell(Text("26 à 50%")),
          DataCell(Text(
              "Entreprise engagée, avec des pratiques en construction ou en essai",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic))),
        ]),
        DataRow(cells: [
          DataCell(Text("51 à 75%")),
          DataCell(Text(
              "Pratiques énergétiqueq confirmées avec une forte implication interne",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic))),
        ]),
        DataRow(cells: [
          DataCell(Text("76 à 100%")),
          DataCell(Text(
              "Pratique énegétiques exemplaires avec des données d'énergie subtantielle",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic))),
        ]),
      ],
    );
  }
}

//TABLEAU DYNAMIQUE DES DONNEES 2 COLONNES:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class TabResulMoul extends StatefulWidget {
  const TabResulMoul({Key? key}) : super(key: key);

  @override
  State<TabResulMoul> createState() => _TabResulMoulState();
}

class _TabResulMoulState extends State<TabResulMoul> {
  late List<SousOpt> sous;

  @override
  void initState() {
    sous = SousOpt.getSousOpt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(
          label: Text(
            "RESULTATS",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            "INTERPRETATIONS",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        )
      ],
      rows: sous
          .map(
            (sous) => DataRow(cells: [
              DataCell(
                Text(sous.resultats,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic)),
              ),
              DataCell(Text(sous.interpretations,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.italic))),
            ]),
          )
          .toList(),
    );
  }
}

class SousOpt {
  String resultats;
  String interpretations;

  SousOpt({
    required this.resultats,
    required this.interpretations,
  });

  static List<SousOpt> getSousOpt() {
    return <SousOpt>[
      SousOpt(
          resultats: "0 à 25%",
          interpretations: "Entreprise en hésitation, faible ou pas du tout"),
      SousOpt(
          resultats: "26 à 50%",
          interpretations:
              "Entreprise engagée, avec des pratiques en construction ou en essai"),
      SousOpt(
          resultats: "51 à 75%",
          interpretations:
              "Pratiques énergétiques confirmées avec une forte implication interne"),
      SousOpt(
          resultats: "76 à 100%",
          interpretations:
              "Pratiques énergétiques exemplaires avec des données d'énergie substantielle"),
    ];
  }
}



