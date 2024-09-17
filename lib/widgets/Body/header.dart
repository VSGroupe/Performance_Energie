import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:perf_energie/main.dart';
import 'package:perf_energie/pages/LoginPage.dart';
import 'package:perf_energie/pages/Onglet/Historique.dart';
import 'package:perf_energie/pages/Onglet/parametre.dart';
import 'package:perf_energie/pages/Onglet/profil.dart';
import 'package:perf_energie/pages/Pilotage/PilotageAccueil.dart';
import 'package:perf_energie/pages/Rapport/Perfomances.dart';
import 'package:perf_energie/pages/Rapport/SuiviDonnes.dart';
import 'package:perf_energie/pages/Rapport/Tablobord.dart';
import 'package:perf_energie/widgets/Composant/Button.dart';
import 'package:perf_energie/widgets/Consolides/CardAffichage.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';
import 'package:perf_energie/widgets/Constant/ImgConstant.dart';
import 'package:perf_energie/widgets/GlobaleVariable/date.dart';
import 'package:provider/provider.dart';

// INFORMATION DE L'APPBAR:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class InfoAppBar extends StatelessWidget {
  const InfoAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.fromLTRB(100,0,30,0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(
            children: [
              Text("Infos Utiles : ",
                  style: TextStyle(
                      fontSize: 18,
                      color: primaryColor,
                      fontWeight: FontWeight.w600)),
              InfoUtile(),
            ],
          ),
          Row(
            children: [
              badgeNotif(
                  tap: () {
                    OpenPage(
                        context,
                        const DefaultTabController(
                            initialIndex: 0,
                            length: 2,
                            child: ProfilPage(ongChange1: 1)));
                  },
                  icon: Icons.notifications,
                  afficheNbre: "50"),
              const SizedBox(
            width: 20,
          ),
          const CircleAvatar(
            radius: 23,
            backgroundImage: AssetImage("assets/images/person3.png"),
          ),
            ],
          ),
          
        ],
      ),
    );
  }
}

// APPEL DE L'INFO UTILE ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class InfoUtile extends StatelessWidget {
  const InfoUtile({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1200,
      height: 20,
      child: Center(
        child: Marquee(
          text:
              " Vision Strategie Groupe vous remercie pour la confiance dont vous lui faite preuve. Sur ceux passer une excellente journée.",
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
          scrollAxis: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          blankSpace: 20.0,
          velocity: 100.0,
          pauseAfterRound: const Duration(seconds: 5),
          startPadding: 10.0,
          accelerationDuration: const Duration(seconds: 2),
          accelerationCurve: Curves.linear,
          decelerationDuration: const Duration(milliseconds: 500),
          decelerationCurve: Curves.easeOut,
        ),
      ),
    );
  }
}

// CONTENU DU DRAWER::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class SliderView extends StatefulWidget {
  const SliderView({super.key});

  @override
  State<SliderView> createState() => _SliderViewState();
}

class _SliderViewState extends State<SliderView> {

  int selectedIndex = 0;
  Color selectedColor = Colors.red;

  final List<String> itemList = [
    'Tableau de bord',
    'Accueil',
    'Suivi des données',
    'Performances',
    'Profil',
    'Paramètres',
    'Historiques',
    'Aide',
    'Commentaires',
    'Support client',
    'Déconnexion',
  ];

  final List<IconData> iconList = [
    Icons.dashboard,
    Icons.home,
    Icons.query_stats,
    Icons.notifications_active,
    Icons.person,
    Icons.settings,
    Icons.history,
    Icons.help,
    Icons.message,
    Icons.headset_mic_rounded,
    Icons.exit_to_app,
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.only(top: 20),
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Image.asset(imglogo,height: 150,),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Logiciel de gestion de votre perfomance energétique",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              height: 550,
              child: ListView.builder(
                itemCount: itemList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(itemList[index],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),),
                    leading: Icon(
                      iconList[index],
                      color: Colors.black,
                    ),
                    onTap: () {
                      // Action à effectuer lorsqu'un élément est cliqué
                      onItemClick(index);
                      if (index == 0) {
                        OpenPage(context, const TabloBord()); // Tableau de bord
                      } else if (index == 1) {
                        OpenPage(context,
                            const PilotageAccueil()); // Accueil pilotage
                      } else if (index == 2) {
                        OpenPage(
                            context, const SuiviDonnes()); // Suivi des données
                      } else if (index == 3) {
                        OpenPage(context, const Perfomances()); // Performances
                      } else if (index == 4) {
                        OpenPage(
                            context,
                            const DefaultTabController(
                                initialIndex: 0,
                                length: 2,
                                child: ProfilPage(ongChange1: 0))); // Profil
                      } else if (index == 5) {
                        OpenPage(context, const Parametres()); // Parametres
                      } else if (index == 6) {
                        OpenPage(context, const Historique()); // Historiques
                      } else if (index == 7) {
                        OpenPage(
                            context,
                            const DefaultTabController(
                                initialIndex: 0,
                                length: 2,
                                child: ProfilPage(ongChange1: 2))); // Aide
                      } else if (index == 8) {
                        OpenPage(
                            context,
                            const DefaultTabController(
                                initialIndex: 1,
                                length: 2,
                                child:
                                    ProfilPage(ongChange1: 3))); // Commentaire
                      } else if (index == 9) {
                        OpenPage(
                            context,
                            const DefaultTabController(
                                initialIndex: 0,
                                length: 2,
                                child: ProfilPage(
                                    ongChange1: 1))); // Support Client
                      } else {
                        return OpenPage(context, const LoginPage()); // Déconnexion
                      }
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              //width: 300,
              child: Column(
                children: [
                  Text(
                    "VISION STRATEGIE GROUPE",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 16, 19, 238),
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Hisser vos ambitions plus haut",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onItemClick(int index) {
    debugPrint('Élément $index cliqué : ${iconList[index]}');
  }
}

// L'IMAGE DE LA BANIEREDE MENU::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class Baniere extends StatefulWidget {
  final double? long;
  final double? larg;
  final double? textsize1;
  final double? testsize2;

  const Baniere({
    Key? key,
    this.long,
    this.larg,
    this.textsize1,
    this.testsize2,
  }) : super(key: key);

  @override
  State<Baniere> createState() => _BaniereState();
}

class _BaniereState extends State<Baniere> {
  
  @override
  Widget build(BuildContext context) {

    final donnee = Provider.of<LoginName>(context).name;
    final civilite = donnee?['user']['civilite']; // Récupération du nom
    final nom = donnee?['user']['nom_contribut']; // Récupération du nom
    final prenom = donnee?['user']['prenom_contribut']; // Récupération du prénom
        
    return Center(
      child: Column(children: [
        Image.asset(
          imgaccueil,
          width: widget.long ?? 1300,
          height: widget.larg ?? 450,
          fit: BoxFit.fill,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "PERFORMANCE ENERGIE",
                style: TextStyle(
                    fontSize: widget.textsize1 ?? 30,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                "Bienvenue : $civilite $prenom $nom",
                style: TextStyle(
                    fontSize: widget.testsize2 ?? 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w700,
                    color: secondColor),
              )
            ])
      ]),
    );
  }
}

// BADGE DE NOTIFICATION AVEC ICONBUTTON::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class badgeNotif extends StatelessWidget {
  final VoidCallback tap;
  final IconData icon;
  final String afficheNbre;
  final double? iconsize;
  final Color? iconcolor;
  final double? positionright;
  final double? positiontop;
  final double? widthbadge;
  final double? heightbadge;
  final double? textbadgesize;
  final Color? textbadgecolor;
  final Color? badgecolor;

  const badgeNotif({
    Key? key,
    required this.tap,
    required this.icon,
    required this.afficheNbre,
    this.iconsize,
    this.iconcolor,
    this.positiontop,
    this.positionright,
    this.widthbadge,
    this.heightbadge,
    this.badgecolor,
    this.textbadgecolor,
    this.textbadgesize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
            icon: Icon(
              icon,
              size: iconsize ?? 30,
            ),
            onPressed: tap),
        Positioned(
          right: positionright ?? -1,
          top: positiontop ?? 0,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: badgecolor ?? Colors.red,
              shape: BoxShape.circle,
            ),
            constraints: BoxConstraints(
              minWidth: widthbadge ?? 20,
              minHeight: heightbadge ?? 20,
            ),
            child: Text(
              afficheNbre,
              style: TextStyle(
                color: textbadgecolor ?? Colors.white,
                fontSize: textbadgesize ?? 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

class impression extends StatelessWidget {
  const impression({super.key});

  @override
  Widget build(BuildContext context) {
    return CardMoule(
        width: double.infinity,
        height: 60,
        child: Row(
          children: [
            const SizedBox(width: 50),
            const Text("Année des previsions",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(width: 50),
            InkWell(
              onTap: () {},
              child: Text("$prevYear",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const SizedBox(width: 30),
            InkWell(
              onTap: () {},
              child: Text("$annee",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const SizedBox(width: 1200),
            IconButton(
                onPressed: () {},
                iconSize: 30,
                color: Colors.blue,
                icon: const Icon(Icons.refresh_sharp)),
            const SizedBox(width: 20),
            buttonIcon(
                width: 150,
                tap: () {},
                text: "Imprimer",
                backgroundColor: Colors.blue,
                color: Colors.white,
                icon: Icons.print_sharp)
          ],
        ));
  }
}
