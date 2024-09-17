 
 //VARIBLE DE TYPE DATE:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 
 int annee = DateTime.now().year; // Année actuelle

 int month = DateTime.now().month;
 
 int subYear = annee - 2; // Année précedente
 int prevYear = annee - 1; // Année précedente
 int nextYear = annee + 1; // Année Suivante
 

//  String getMonthName(int month) {
//   // Utilisation de la classe DateFormat pour formater le mois
//   final format = DateFormat.MMMM();
  
//   // Utilisation de DateTime pour obtenir le mois en lettres
//   final dateTime = DateTime.now(); // Remplacez 2023 par l'année de votre choix
//   final mois = format.format(dateTime);

//   return mois;
// }

//VARIBLE DE TYPE DATE (Mois en français):::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

String getMois() {
  int month = DateTime.now().month;
  late String mois;
  if (month == 1) {
    mois = 'Janvier';
  } else if (month == 2) {
    mois = 'Février';
  } else if (month == 3) {
    mois = 'Mars';
  } else if (month == 4) {
    mois = 'Avril';
  } else if (month == 5) {
    mois = 'Mai';
  } else if (month == 6) {
    mois = 'Juin';
  } else if (month == 7) {
    mois = 'Juillet';
  } else if (month == 8) {
    mois = 'Août';
  } else if (month == 9) {
    mois = 'Septembre';
  } else if (month == 10) {
    mois = 'Octobre';
  } else if (month == 11) {
    mois = 'Novembre';
  } else {
    mois = 'Décembre';
  }
  return mois;
}



//VARIBLE DE TYPE DATE 2 MOIS EN ARRIERE (Mois en français):::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

String getSubMois() {
  int month =12 - (DateTime.now().month);
  late String subMois;
  if (month == 1) {
    subMois = 'Janvier';
  } else if (month == 2) {
    subMois = 'Février';
  } else if (month == 3) {
    subMois = 'Mars';
  } else if (month == 4) {
    subMois = 'Avril';
  } else if (month == 5) {
    subMois = 'Mai';
  } else if (month == 6) {
    subMois = 'Juin';
  } else if (month == 7) {
    subMois = 'Juillet';
  } else if (month == 8) {
    subMois = 'Août';
  } else if (month == 9) {
    subMois = 'Septembre';
  } else if (month == 10) {
    subMois = 'Octobre';
  } else if (month == 11) {
    subMois = 'Novembre';
  } else {
    subMois = 'Décembre';
  }
  return subMois;
}



//VARIBLE DE TYPE DATE MOIS PRECEDENT (Mois en français):::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

String getPrevMois() {
  int month =(DateTime.now().month) - 1;
  late String prevMois;
  if (month == 1) {
    prevMois = 'Janvier';
  } else if (month == 2) {
    prevMois = 'Février';
  } else if (month == 3) {
    prevMois = 'Mars';
  } else if (month == 4) {
    prevMois = 'Avril';
  } else if (month == 5) {
    prevMois = 'Mai';
  } else if (month == 6) {
    prevMois = 'Juin';
  } else if (month == 7) {
    prevMois = 'Juillet';
  } else if (month == 8) {
    prevMois = 'Août';
  } else if (month == 9) {
    prevMois = 'Septembre';
  } else if (month == 10) {
    prevMois = 'Octobre';
  } else if (month == 11) {
    prevMois = 'Novembre';
  } else {
    prevMois = 'Décembre';
  }
  return prevMois;
}


//VARIBLE DE TYPE DATE MOIS PROCHAIN (Mois en français):::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

String getNextMois() {
  int month =(DateTime.now().month) + 1;
  late String nextMois;
  if (month == 1) {
    nextMois = 'Janvier';
  } else if (month == 2) {
    nextMois = 'Février';
  } else if (month == 3) {
    nextMois = 'Mars';
  } else if (month == 4) {
    nextMois = 'Avril';
  } else if (month == 5) {
    nextMois = 'Mai';
  } else if (month == 6) {
    nextMois = 'Juin';
  } else if (month == 7) {
    nextMois = 'Juillet';
  } else if (month == 8) {
    nextMois = 'Août';
  } else if (month == 9) {
    nextMois = 'Septembre';
  } else if (month == 10) {
    nextMois = 'Octobre';
  } else if (month == 11) {
    nextMois = 'Novembre';
  } else {
    nextMois = 'Décembre';
  }
  return nextMois;
}