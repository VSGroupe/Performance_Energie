import 'package:flutter/material.dart';
import 'package:perf_energie/main.dart';
import 'package:perf_energie/pages/Onglet/Historique.dart';
import 'package:perf_energie/pages/Onglet/parametre.dart';
import 'package:perf_energie/pages/Onglet/profil.dart';
import 'package:perf_energie/pages/Pilotage/PilotageAccueil.dart';
import 'package:perf_energie/pages/Rapport/Perfomances.dart';
import 'package:perf_energie/pages/Rapport/TabloBord.dart';
import 'package:perf_energie/widgets/Consolides/CardAffichage.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';
import 'package:perf_energie/widgets/Utiles/Graphes.dart';
import 'package:perf_energie/widgets/Constant/ImgConstant.dart';
import 'package:perf_energie/widgets/Body/InfoBar.dart';
import 'package:perf_energie/widgets/Body/header.dart';
import 'package:perf_energie/widgets/GlobaleVariable/date.dart';

import '../../widgets/Composant/Button.dart';

class SuiviDonnes extends StatefulWidget {
  const SuiviDonnes({super.key});

  @override
  State<SuiviDonnes> createState() => _SuiviDonnesState();
}

class _SuiviDonnesState extends State<SuiviDonnes>
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
    // double width = MediaQuery.of(context).size.width;

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
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
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
                        buttonType(
                          tap: () {
                            OpenPage(context, const PilotageAccueil());
                          },
                          width: 200,
                          height: 40,
                          textsize: 18,
                          text: "Accueil Pilotage",
                          color: Colors.blue,
                          hovercolor: Colors.blueGrey,
                          textcolor2: Colors.white,
                        ),
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
                                text: "Suivi des Données",
                                color: Colors.red,
                                hovercolor:
                                    const Color.fromARGB(255, 107, 9, 2),
                                textcolor2: Colors.white,
                              ),
                            );
                          },
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
                    const SizedBox(height: 10),
                    Text(
                      "SUIVIS DES DONNEES DE L'ANNEE $annee",
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    impression(),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TBord(
                                  pourcentage: 45,
                                  textTitle: "Gouvernance",
                                  textSousTitle: " | Actuellement",
                                  icon: Icons.home_work,
                                  sizeIcon: 60,
                                  sizetextTitle: 15,
                                  sizetext2: 40,
                                  sizetext3: 20,
                                ),
                                SizedBox(width: 20),
                                TBord(
                                  pourcentage: 70,
                                  textTitle: "Emploi et condition de travail",
                                  textSousTitle: " | Actuellement",
                                  icon: Icons.sunny,
                                  sizeIcon: 60,
                                  sizetextTitle: 15,
                                  sizetext2: 40,
                                  sizetext3: 20,
                                ),
                                SizedBox(width: 30),
                                TBord(
                                  pourcentage: 15,
                                  textTitle: "Communautés et innovations",
                                  textSousTitle: " | Actuellement",
                                  icon: Icons.nature,
                                  sizeIcon: 60,
                                  sizetextTitle: 15,
                                  sizetext2: 40,
                                  sizetext3: 20,
                                ),
                                SizedBox(width: 20),
                                TBord(
                                  pourcentage: 88,
                                  textTitle: "Environnement",
                                  textSousTitle: " | Actuellement",
                                  icon: Icons.work,
                                  sizeIcon: 60,
                                  sizetextTitle: 15,
                                  sizetext2: 40,
                                  sizetext3: 20,
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            CardMoule(
                                width: 1423,
                                height: 460,
                                child: SuiviMensuelChart())
                          ],
                        ),
                        SizedBox(width: 20),
                        CardMoule(width: 400, height: 640, child: suiviCard())
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const CopyRight(),
          ],
        ),
      ]),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
