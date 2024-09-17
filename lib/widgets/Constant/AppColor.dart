

import 'dart:math';

import 'package:flutter/material.dart';

// CLASS DE CHANGEMENT DES COULEURS EN FONCTIONS DE LA VALEURS DES COMPOSANTS::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class ColorUtil {
  static Color getColorFromValue(int value) {
    if (value >= 0 && value <= 25) {
      return Colors.red;
    } else if (value >= 26 && value <= 50) {
      return Colors.orange;
      } else if (value >= 51 && value <= 75) {
      return Colors.green;
      } else if (value >= 76 && value <= 89) {
      return const Color.fromARGB(255, 1, 70, 16);
      } else {
      // Valeur en dehors des plages spécifiées
      return Colors.blue; // Ou toute autre couleur par défaut
    }
  }
}


// CLASS DE CHANGEMENT DES LETTRES EN FONCTIONS DE LA VALEURS DES COMPOSANTS::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class TextUtil {
  static String getColorFromValue(int value) {
    if (value >= 0 && value <= 12) {
      return "G";
    } else if (value >= 13 && value <= 24) {
      return "F";
    } else if (value >= 25 && value <= 36) {
      return "E";
    } else if (value >= 37 && value <= 48) {
      return "D";
    } else if (value >= 49 && value <= 60) {
      return "C";
    } else if (value >= 61 && value <= 72) {
      return "B";
    } else if (value >= 73 && value <= 84) {
      return "A";
    } else if (value >= 85 && value <= 94) {
      return "A+";
    } else {
      // Valeur en dehors des plages spécifiées
      return "A++"; // Ou toute autre chaîne par défaut
    }
  }
}



const primaryColor = Color.fromARGB(255, 255, 123, 0);
const secondColor = Color.fromARGB(255, 1, 102, 5);
const tertiaireColor =Color.fromARGB(255, 197, 178, 3);
const quattroColor =Color.fromARGB(255, 207, 206, 198);

const valideColor = Color.fromARGB(255, 3, 139, 7);
const errorColor = Color.fromARGB(255, 180, 15, 4);
const validelightColor = Color.fromARGB(255, 4, 230, 12);
const errorlightColor = Color.fromARGB(255, 250, 46, 31);

const fondColor = Color.fromARGB(255, 21, 145, 247);
const fonddarkColor = Color.fromARGB(255, 2, 50, 88);

const textColor = Colors.black;
const texinvColor = Colors.white;

const buttonColor = Color.fromARGB(255, 4, 116, 207);
const fondinvColor = Color.fromARGB(255, 53, 38, 61);
const buttonhoverColor = Color.fromARGB(255, 109, 158, 243);


//////////////////////////////////////////////////////////////////////////////////////////////
const axeColor = Color.fromARGB(255, 255, 123, 0);
const enjeuColor = Color.fromARGB(255, 42, 8, 194);
const critereColor = Color.fromARGB(255, 252, 216, 13);
const processusColor = Color.fromARGB(255, 9, 131, 19);
const indicateurColor = Color.fromARGB(255, 156, 39, 176);


// CLASS DE VARIATION DES COULEURS PAR HASARD ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

Color _generateRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }






