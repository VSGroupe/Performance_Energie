import 'package:flutter/material.dart';
import 'package:perf_energie/main.dart';
import 'package:perf_energie/pages/Axes/TableAxe.dart';
import 'package:perf_energie/pages/Criteres/TableCritere.dart';
import 'package:perf_energie/pages/Enjeux/TableEnjeu.dart';
import 'package:perf_energie/pages/Onglet/ParamatrageIndicateur/TabIndicateur.dart';
import 'package:perf_energie/pages/Processus/TableProcessus.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';
import 'package:perf_energie/widgets/Utiles/Graphes.dart';

// CONPOMENT DU DIGRAMME DE PERF ENERGIE ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class ViewDiagrammePerf extends StatefulWidget {
  const ViewDiagrammePerf({super.key});

  @override
  State<ViewDiagrammePerf> createState() => _ViewDiagrammePerfState();
}

class _ViewDiagrammePerfState extends State<ViewDiagrammePerf> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Material(
        child: Container(
            width: 1000,
            height: 800,
            color: Colors.transparent,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "DIAGRAMME DES ETAPES DE LA PERFOMANCE ENERGIE",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(height: 30),
                Image.asset(
                  "assets/images/strategienergie.png",
                  fit: BoxFit.fill,
                ),
              ],
            )),
      ),
    );
  }
}

// CONPOMENT DU DIGRAMME DE PERF ENERGIE ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class TabPerf extends StatefulWidget {
    const TabPerf({super.key});

  @override
  State<TabPerf> createState() => _TabPerfState();
}

class _TabPerfState extends State<TabPerf> {
  
  bool ishovered1 = false;
  bool ishovered2 = false;
  bool ishovered3 = false;
  bool ishovered4 = false;
  bool ishovered5 = false;

  @override
  Widget build(BuildContext context) {
    final double hsize1 = ishovered1 ? 300 : 280;
    final double hsize2 = ishovered2 ? 300 : 280;
    final double hsize3 = ishovered3 ? 300 : 280;
    final double hsize4 = ishovered4 ? 300 : 280;
    final Color hcolor =
        ishovered5 ? const Color.fromARGB(255, 231, 19, 4) : Colors.brown;

    return SizedBox(
      width: 800,
      height: 650,
      child: (Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
///////////////////////////////////IMAGE ENJEUX//////////////////////////////////////////////////////////////
                InkWell(
                    onTap: () {
                      OpenPage(context, const TabEnjeux());
                    },
                    onHover: (value) {
                      setState(() {
                        ishovered4 = value;
                      });
                    },
                    overlayColor: WidgetStateColor.resolveWith(
                        (states) => Colors.transparent),
                    child: AnimatedContainer(
                        width: hsize4,
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeInSine,
                        child: Image.asset("assets/images/enjeu.png"))),
                const SizedBox(width: 30),
///////////////////////////////////IMAGE PROCESSUS//////////////////////////////////////////////////////////////
                InkWell(
                    onTap: () {
                      OpenPage(context, const TabProcessus());
                    },
                    onHover: (value) {
                      setState(() {
                        ishovered1 = value;
                      });
                    },
                    overlayColor: WidgetStateColor.resolveWith(
                        (states) => Colors.transparent),
                    child: AnimatedContainer(
                        width: hsize1,
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeInSine,
                        child: Image.asset("assets/images/processus.png"))),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
///////////////////////////////////IMAGE AXES//////////////////////////////////////////////////////////////
                InkWell(
                    onTap: () {
                      OpenPage(context, const TabAxes());
                    },
                    onHover: (value) {
                      setState(() {
                        ishovered3 = value;
                      });
                    },
                    overlayColor: WidgetStateColor.resolveWith(
                        (states) => Colors.transparent),
                    child: AnimatedContainer(
                        width: hsize3,
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeInSine,
                        child: Image.asset("assets/images/axe.png"))),
                const SizedBox(width: 30),
///////////////////////////////////IMAGE CRITERES//////////////////////////////////////////////////////////////
                InkWell(
                    onTap: () {
                      OpenPage(context, const TabCritere());
                    },
                    onHover: (value) {
                      setState(() {
                        ishovered2 = value;
                      });
                    },
                    overlayColor: WidgetStateColor.resolveWith(
                        (states) => Colors.transparent),
                    child: AnimatedContainer(
                        width: hsize2,
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeInSine,
                        child: Image.asset("assets/images/critere.png"))),
              ],
            )
          ],
        ),
        Center(
            child: InkWell(
          onTap: () {
            OpenPage(context, const TabIndicharger());
          },
          onHover: (value) {
            setState(() {
              ishovered5 = value;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            width: 190,
            height: 190,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              border: Border.all(width: 5, color: Colors.white),
              color: hcolor,
            ),
            child: const Padding(
              padding: EdgeInsets.fromLTRB(30, 60, 13, 20),
              child: Text(
                "Tous les indicateurs",
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: texinvColor),
              ),
            ),
          ),
        ))
      ])),
    );
  }
}

// CONPOMENT DU DIAGRAMME DE PERFORMANCE DES AXES :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class PerfParAxe extends StatefulWidget {
  const PerfParAxe({super.key});

  @override
  State<PerfParAxe> createState() => _PerfParAxeState();
}

class _PerfParAxeState extends State<PerfParAxe> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Material(
        child: Container(
            width: 1200,
            height: 500,
            color: Colors.transparent,
            child: const Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "DIAGRAMME DE PERFORMANCE DES AXES STRATEGIQUES",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  SizedBox(height: 30),
                  PerformancePiliers()
                ],
              ),
            )),
      ),
    );
  }
}
