import 'package:flutter/material.dart';
import 'package:perf_energie/main.dart';
import 'package:perf_energie/pages/Onglet/Historique.dart';
import 'package:perf_energie/pages/Onglet/ParamatrageIndicateur/FonctModif.dart';
import 'package:perf_energie/pages/Onglet/profil.dart';
import 'package:perf_energie/pages/Pilotage/PilotageAccueil.dart';
import 'package:perf_energie/pages/Profil/ProfilUser.dart';
import 'package:perf_energie/pages/Rapport/Perfomances.dart';
import 'package:perf_energie/pages/Rapport/SuiviDonnes.dart';
import 'package:perf_energie/pages/Rapport/TabloBord.dart';
import 'package:perf_energie/widgets/Body/InfoBar.dart';
import 'package:perf_energie/widgets/Body/header.dart';
import 'package:perf_energie/widgets/Composant/Button.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';
import 'package:perf_energie/widgets/Constant/ImgConstant.dart';

class Parametres extends StatefulWidget {
  const Parametres({super.key});

  @override
  State<Parametres> createState() => _ParametresState();
}

class _ParametresState extends State<Parametres>
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: secondColor,
          title: const InfoAppBar(),
          automaticallyImplyLeading: false,
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
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _controller.value,
                            child: buttonType(
                              tap: () {
                                OpenPage(context, const DefaultTabController(
                                  initialIndex: 0,
                                  length: 2,
                                  child: ProfilUser(ongChange1: 0,)));
                              },
                              width: 200,
                              height: 40,
                              textsize: 18,
                              text: "Paramètres",
                              color: Colors.red,
                              hovercolor: const Color.fromARGB(255, 107, 9, 2),
                              textcolor2: Colors.white,
                            ),
                          );
                        },
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
                  const Text(
                    "PARAMETRES ADMINISTRATIFS",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                 const AxeParametrage(),

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
