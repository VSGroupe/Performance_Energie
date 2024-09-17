import 'package:flutter/material.dart';
import 'package:perf_energie/main.dart';
import 'package:perf_energie/pages/Enjeux/TabAffichageEnjeux.dart';
import 'package:perf_energie/pages/Onglet/Historique.dart';
import 'package:perf_energie/pages/Onglet/parametre.dart';
import 'package:perf_energie/pages/Onglet/profil.dart';
import 'package:perf_energie/pages/Pilotage/PilotageAccueil.dart';
import 'package:perf_energie/pages/Rapport/Perfomances.dart';
import 'package:perf_energie/pages/Rapport/SuiviDonnes.dart';
import 'package:perf_energie/pages/Rapport/TabloBord.dart';
import 'package:perf_energie/widgets/Body/InfoBar.dart';
import 'package:perf_energie/widgets/Body/header.dart';
import 'package:perf_energie/widgets/Composant/Button.dart';
import 'package:perf_energie/widgets/Consolides/CardAffichage.dart';
import 'package:perf_energie/widgets/Consolides/DesignTBord.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';
import 'package:perf_energie/widgets/Constant/ImgConstant.dart';

class TabEnjeux extends StatefulWidget {
    
  const TabEnjeux({super.key});

  @override
  State<TabEnjeux> createState() => _TabEnjeuxState();
}

class _TabEnjeuxState extends State<TabEnjeux> {
   bool isHovered1 = false;
  bool isHovered2 = false;

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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


                      const SizedBox(height: 10),
                    CardMoule(
                        width: double.infinity,
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Column(
                            children: [
                              const Text("TABLEAU DE BORD PAR ENJEUX",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.italic,
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  RichText(
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(
                                            text:
                                                "Le progrès de collecte est égale ",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontStyle: FontStyle.italic,
                                            )),
                                        TextSpan(
                                            text: "35,71 % ",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                            )),
                                        TextSpan(
                                            text:
                                                "(100 indicateurs renseignés / 280)",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.italic,
                                            ))
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  const LinearGauge(
                                    width: 300,
                                      height: 20,
                                      value: 100,
                                      valueFinal: 280,
                                      colorstart:
                                          Color.fromARGB(255, 223, 219, 219),
                                      colorend: Colors.red,)
                                ],
                              ),
                            ],
                          ),
                        )),
                        const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CardMoule(
                            width: 800,
                            height: 650,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                              child: ListersEnjeux()),
                         ),
                         CardMoule(
                            width: 1020,
                            height: 650,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                              child: Image.asset(vsglogo)),
                         ),
                      ],
                    ),
                  ],
                ),
              ),
              const CopyRight()
            ],
          )
        ]));
  }
}
