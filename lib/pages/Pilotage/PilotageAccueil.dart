import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perf_energie/main.dart';
import 'package:perf_energie/pages/Onglet/Historique.dart';
import 'package:perf_energie/pages/Onglet/parametre.dart';
import 'package:perf_energie/pages/Onglet/profil.dart';
import 'package:perf_energie/pages/Rapport/Perfomances.dart';
import 'package:perf_energie/pages/Rapport/SuiviDonnes.dart';
import 'package:perf_energie/pages/Rapport/TabloBord.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';
import 'package:perf_energie/widgets/Composant/Button.dart';
import 'package:perf_energie/widgets/Consolides/CardAffichage.dart';
import 'package:perf_energie/widgets/Consolides/DesignTBord.dart';
import 'package:perf_energie/widgets/Consolides/TableauAffichage.dart';
import 'package:perf_energie/widgets/Constant/ImgConstant.dart';
import 'package:perf_energie/widgets/Body/InfoBar.dart';
import 'package:perf_energie/widgets/Body/header.dart';
import 'package:provider/provider.dart';

class PilotageAccueil extends StatefulWidget {
  const PilotageAccueil({super.key});

  @override
  State<PilotageAccueil> createState() => _PilotageAccueilState();
}

class _PilotageAccueilState extends State<PilotageAccueil>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  bool isHovered1 = false;
  bool isHovered2 = false;

  @override
  Widget build(BuildContext context) {
    String data = Provider.of<DataProvider>(context).data;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: secondColor,
          title: const InfoAppBar(),
        ),
        // UTILISATION DU DRAWER
        drawer: const Drawer(
          width: 300,
          child: SliderView(),
        ),
        body: Stack(children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(imgbackground), fit: BoxFit.cover))),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                          onHover: (value1) {
                            setState(() {
                              isHovered1 = value1;
                            });
                          },
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Tooltip(
                            message: 'Page Precédante',
                            child: Image.asset("assets/icons/prev.png",
                                width: isHovered1 ? 50 : 45),
                          )),
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _controller.value,
                            child: buttonType(
                              tap: () {
                                OpenPage(context, const PilotageAccueil());
                              },
                              width: 200,
                              height: 40,
                              textsize: 18,
                              text: "Accueil Pilotage",
                              color: Colors.red,
                              hovercolor: const Color.fromARGB(255, 107, 9, 2),
                              textcolor2: Colors.white,
                            ),
                          );
                        },
                      ),
                      buttonType(
                        tap: () {
                          OpenPage(context, const SuiviDonnes());
                        },
                        width: 200,
                        height: 40,
                        textsize: 18,
                        text: "Suivi des Données",
                        color: Colors.blue,
                        hovercolor: Colors.blueGrey,
                        textcolor2: Colors.white,
                      ),
                      buttonType(
                        tap: () {
                          OpenPage(context, const Perfomances());
                        },
                        width: 200,
                        height: 40,
                        textsize: 18,
                        text: "Perfomances",
                        color: Colors.blue,
                        hovercolor: Colors.blueGrey,
                        textcolor2: Colors.white,
                      ),
                      buttonType(
                        tap: () {
                          OpenPage(context, const Parametres());
                        },
                        width: 200,
                        height: 40,
                        textsize: 18,
                        text: "Paramètres",
                        color: Colors.blue,
                        hovercolor: Colors.blueGrey,
                        textcolor2: Colors.white,
                      ),
                      buttonType(
                        tap: () {
                          OpenPage(context, const Historique());
                        },
                        width: 200,
                        height: 40,
                        textsize: 18,
                        text: "Historiques",
                        color: Colors.blue,
                        hovercolor: Colors.blueGrey,
                        textcolor2: Colors.white,
                      ),
                      buttonType(
                        tap: () {
                          OpenPage(
                              context,
                              const DefaultTabController(
                                  initialIndex: 0,
                                  length: 2,
                                  child: ProfilPage(ongChange1: 0)));
                        },
                        width: 200,
                        height: 40,
                        textsize: 18,
                        text: "Profils",
                        color: Colors.blue,
                        hovercolor: Colors.blueGrey,
                        textcolor2: Colors.white,
                      ),
                      buttonType(
                        tap: () {
                          OpenPage(context, const TabloBord());
                        },
                        width: 230,
                        height: 40,
                        textsize: 18,
                        text: "Tableau de bord",
                        color: Colors.blue,
                        hovercolor: Colors.blueGrey,
                        textcolor2: Colors.white,
                      ),
                      InkWell(
                          onHover: (value2) {
                            setState(() {
                              isHovered2 = value2;
                            });
                          },
                          onTap: () {
                            OpenPage(context, const PilotageAccueil());
                          },
                          child: Tooltip(
                            message: 'Acceuil Pilotage',
                            child: Image.asset("assets/icons/next.png",
                                width: isHovered2 ? 50 : 45),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        "ACCUEIL PILOTAGE  $data : ",
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(width: 30),
                      const Text(
                        "Tableau d'évaluation des axes stratégiques",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          const Row(
                            children: [
                              CardTB(
                                  imagedescrp: "assets/icons/gouvernance.png",
                                  textTitle: "GOURVERNANCE ET ETHIQUE",
                                  value: 50,
                                  valueFinal: 125,
                                  colorstart: Color.fromARGB(255, 95, 8, 110),
                                  colorend: Colors.purpleAccent,
                                  nbreIndicateur: 50,
                                  totalIndicateur: 125),
                              SizedBox(width: 20),
                              CardTB(
                                  imagedescrp: "assets/icons/economie.png",
                                  textTitle: "EMPLOI ET CONDITIONS DE TRAVAIL",
                                  value: 80,
                                  valueFinal: 120,
                                  colorstart: Color.fromARGB(255, 2, 47, 83),
                                  colorend: Colors.blueAccent,
                                  nbreIndicateur: 80,
                                  totalIndicateur: 120),
                              SizedBox(width: 20),
                              CardTB(
                                  imagedescrp: "assets/icons/social.png",
                                  textTitle:
                                      "COMMUNAUTES ET INNOVATION SOCIETALE",
                                  sizetextTitle: 14,
                                  value: 20,
                                  valueFinal: 140,
                                  colorstart: Color.fromARGB(255, 122, 93, 3),
                                  colorend: Colors.amberAccent,
                                  nbreIndicateur: 20,
                                  totalIndicateur: 140),
                              SizedBox(width: 20),
                              CardTB(
                                  imagedescrp: "assets/icons/environnement.png",
                                  textTitle: "ENVIRONNEMENT",
                                  value: 63,
                                  valueFinal: 70,
                                  colorstart: Color.fromARGB(255, 4, 71, 6),
                                  colorend: Colors.greenAccent,
                                  nbreIndicateur: 63,
                                  totalIndicateur: 70),
                              SizedBox(width: 20),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CardMoule(
                              width: 1300,
                              height: 450,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                            "Liste des différents contributeurs",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.orange)),
                                        SizedBox(
                                          width: 150,
                                          height: 40,
                                          child: buttonIcon(
                                              tap: () {},
                                              backgroundColor: primaryColor,
                                              text: "Ajouter",
                                              color: Colors.white,
                                              icon: Icons.add),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 1300,
                                      height: 40,
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: 110,
                                          ),
                                          Text(
                                            "Noms",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 230,
                                          ),
                                          Text(
                                            "Filiales",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 226,
                                          ),
                                          Text(
                                            "Entités",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 225,
                                          ),
                                          Text(
                                            "Accès",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                        width: 1300,
                                        height: 320,
                                        child: TabProfil()),
                                  ],
                                ),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [
                          CardRanger(
                            text: 'Progrès de collecte Mensuelle',
                            child: TabResulMensuel(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CardRanger(
                            topleft: 0,
                            topright: 0,
                            headfondColor: const Color.fromARGB(255, 255, 123, 0),
                            text: 'Progrès de collecte Annuelle',
                            child: TabResulAnnuel(),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              const CopyRight()
            ],
          )
        ]));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
