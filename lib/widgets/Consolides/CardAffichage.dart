import 'package:flutter/material.dart';
import 'package:perf_energie/widgets/Composant/Form.dart';
import 'package:perf_energie/widgets/Utiles/Graphes.dart';
import 'package:perf_energie/widgets/GlobaleVariable/date.dart';

//CARD DES PROGRES DE COLLECTE :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class CardRanger extends StatelessWidget {
final Widget child;
final String text;
final double? long;
final double? topleft;
final double? topright;
final Color? headfondColor;
  const CardRanger({
    required this.child,
    required this.text,
             this.long,
             this.topleft,
             this.topright,
             this.headfondColor,
    super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: 370,
      height: long?? 330,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topleft?? 30),
            topRight: Radius.circular(topright?? 30),
          ),
        ),
        elevation: 5,
        shadowColor: Colors.green,
        child: Column(
          children: [
            MenuForm(
              color: headfondColor,
              topleft: topleft?? 30,
              topright: topright?? 30,
              formtext: text,
              long: 370,
              larg: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  child,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

//CARD FORM D'APPEL MOULAGE :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class CardMoule extends StatelessWidget {
  final Widget child;
  final Color? shadow;
  final Color? color;
  final double? elevation;
  final double? topLeft;
  final double? bottomLeft;
  final double? topRight;
  final double? bottomRight;
  final double? width;
  final double? height;

  const CardMoule(
      {required this.child,
      this.shadow,
      this.color,
      this.elevation,
      this.topLeft,
      this.bottomLeft,
      this.topRight,
      this.bottomRight,
      this.width,
      this.height,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 300,
      height: height ?? 300,
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(topLeft ?? 15.0),
              topRight: Radius.circular(topLeft ?? 15.0),
              bottomRight: Radius.circular(bottomRight ?? 15.0),
              bottomLeft: Radius.circular(bottomLeft ?? 15.0),
            ),
          ),
          elevation: elevation ?? 5,
          color: color ?? Colors.white,
          shadowColor: shadow ?? Colors.green,
          child: child),
    );
  }
}

//CARD DE SUIVI DES DONNEES :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class suiviCard extends StatefulWidget {
  const suiviCard({super.key});

  @override
  State<suiviCard> createState() => _suiviCardState();
}

class _suiviCardState extends State<suiviCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Text(
            "Suivi des données $annee",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const ChartOverview(),
          const SizedBox(height: 20),
          ContenuSousMenu(
              width: 300,
              height: 70,
              righttop: 20,
              lefttop: 20,
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      "assets/icons/Rond_rouge.png",
                      width: 30,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Données Vides",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "1328 indicateurs",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    const Text(
                      "450",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(
            height: 15,
          ),
          ContenuSousMenu(
              width: 300,
              height: 70,
              righttop: 20,
              lefttop: 20,
              color: Colors.orange,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      "assets/icons/Rond_orange.png",
                      width: 30,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Données Saisies",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "1328 indicateurs",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    const Text(
                      "330",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(
            height: 15,
          ),
          ContenuSousMenu(
              width: 300,
              height: 70,
              righttop: 20,
              lefttop: 20,
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      "assets/icons/Rond_vert.png",
                      width: 30,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Données Validées",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "1328 indicateurs",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    const Text(
                      "600",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
