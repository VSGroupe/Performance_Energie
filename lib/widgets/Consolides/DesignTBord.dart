import 'package:flutter/material.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';

// TABLEAAU DE BORD DES CARDS MENUS :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class CardTB extends StatelessWidget {
  final double? sizepourcentage;
  final Color? colorpourcentage;
  final String imagedescrp;
  final String textTitle;
  final double? sizetextTitle;
  final Color? colortextTitle;
  final int value; // Valeur de la jauge (0 à 100)
  final int valueFinal; // Valeur final de la jauge (0 à 100)
  final Color colorstart; // couleur de debut de la jauge (0 à 100)
  final Color colorend; // couleur de fin de la jauge (0 à 100)
  final double nbreIndicateur;
  final double? sizetextIndcateur;
  final Color? colortexIndicateur;
  final double totalIndicateur;

  const CardTB(
      {Key? key,
      this.sizepourcentage,
      this.colorpourcentage,
      required this.imagedescrp,
      required this.textTitle,
      this.sizetextTitle,
      this.colortextTitle,
      required this.value, // Valeur de la jauge (0 à 100)
      required this.valueFinal, // Valeur final de la jauge (0 à 100)
      required this.colorstart, // couleur de debut de la jauge (0 à 100)
      required this.colorend, // couleur de fin de la jauge (0 à 100)
      required this.nbreIndicateur,
      this.sizetextIndcateur,
      this.colortexIndicateur,
      required this.totalIndicateur})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double pourcent = (value * 100) / valueFinal;
    int pourcentage = pourcent.toInt();
    Color couleurPourcentage = ColorUtil.getColorFromValue(pourcentage.toInt());

    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    imagedescrp,
                    width: 40,
                  ),
                  const SizedBox(
                    width: 170,
                  ),
                  Text("$pourcentage %",
                      style: TextStyle(
                        fontSize: sizepourcentage ?? 20,
                        fontWeight: FontWeight.bold,
                        color: colorpourcentage ?? couleurPourcentage,
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(textTitle,
                  style: TextStyle(
                    fontSize: sizetextTitle ?? 16,
                    fontWeight: FontWeight.bold,
                    color: colortextTitle ?? Colors.black,
                  )),
              const SizedBox(
                height: 30,
              ),
              LinearGauge(
                width: 250,
                  value: value,
                  valueFinal: valueFinal,
                  colorstart: colorstart,
                  colorend: colorend),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text("$nbreIndicateur  Indicateurs sur ",
                      style: TextStyle(
                        fontSize: sizetextIndcateur ?? 13,
                        color: colortexIndicateur ?? Colors.black,
                      )),
                  const SizedBox(
                    width: 100,
                  ),
                  Text("$totalIndicateur",
                      style: TextStyle(
                        fontSize: sizetextIndcateur ?? 13,
                        color: colortexIndicateur ?? Colors.black,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// JAUGE DE CHARGEMENT DES DONNES ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class LinearGauge extends StatelessWidget {
  final int value; // Valeur de la jauge (0 à 100)
  final int valueFinal; // Valeur final de la jauge (0 à 100)
  final Color colorstart; // couleur de debut de la jauge (0 à 100)
  final Color colorend; // couleur de fin de la jauge (0 à 100)
  final double? width;
  final double? height;
  final String? text;

  const LinearGauge(
      {super.key,
      required this.value,
      required this.valueFinal,
      required this.colorstart,
      required this.colorend,
      required this.width,
      this.text,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 250,
      height: height ?? 20,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          // Dégradé représentant la jauge
          Container(
            width: width! * (value / valueFinal),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [colorstart, colorend],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          Center(
            child: Text((value * 100 / valueFinal).toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                )),
          )
        ],
      ),
    );
  }
}
