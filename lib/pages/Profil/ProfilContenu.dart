import 'package:flutter/material.dart';
import 'package:perf_energie/widgets/Composant/Button.dart';
import 'package:perf_energie/widgets/Consolides/CardAffichage.dart';
import 'package:perf_energie/widgets/Composant/TextCall.dart';
import 'package:perf_energie/widgets/Utiles/ListeView.dart';

// PROFIL DES GESTIONNAIRES:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class ProfilContenu1 extends StatefulWidget {
  final int ongChange;
  const ProfilContenu1(this.outerTab, {required this.ongChange, super.key});

  final String outerTab;

  @override
  State<ProfilContenu1> createState() => _ProfilContenu1State();
}

class _ProfilContenu1State extends State<ProfilContenu1>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 3, initialIndex: widget.ongChange, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.blue,
      elevation: 15,
      margin: const EdgeInsets.all(30.0),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: CardMoule(
                color: Color.fromRGBO(233, 231, 231, 1),
                width: double.infinity,
                height: 80,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage("assets/images/person3.png"),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dorgeles Lath",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "lathdorgeles99@gmail.com",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              SizedBox(width: 60),
              Text(
                "Contributeurs",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 390,
              ),
              Text(
                "Contacts",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 3, 74, 133),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 280,
              ),
              Text(
                "Fonction",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 27, 141, 4),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 260,
              ),
              Text(
                "Droit d'accès",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 182, 22, 10),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              children: [
                CardMoule(
                    width: 500,
                    height: 400,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 350,
                          child: Form(
                              child: Padding(
                            padding: EdgeInsets.fromLTRB(40, 30, 40, 30),
                            child: Column(
                              children: [
                                ComboPara(listValeur: [
                                  'Monsieur',
                                  'Madame.',
                                  'Mademoiselle.'
                                ], textsize: 16, labeltext: "Civilité"),
                                SizedBox(
                                  height: 30,
                                ),
                                textfield(
                                  autofocus: true,
                                  hintText: "Veuillez saisir votre nom",
                                  label: "Votre nom",
                                  suficon: Icons.close,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                textfield(
                                  hintText: "Veuillez saisir vos prénoms",
                                  label: "Vos prénoms",
                                  suficon: Icons.close,
                                ),
                              ],
                            ),
                          )),
                        )
                      ],
                    )),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: CardMoule(
                      width: 1000,
                      height: 400,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 350,
                                child: Form(
                                    child: Padding(
                                  padding: EdgeInsets.fromLTRB(40, 30, 40, 30),
                                  child: Column(
                                    children: [
                                      textfield(
                                        hintText: "Votre contact ici",
                                        label: "Votre Numéro de téléphone",
                                        suficon: Icons.close,
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      textfield(
                                        hintText: "Saisissez votre Email",
                                        label: "Votre Adresse Email",
                                        suficon: Icons.close,
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      textfield(
                                        hintText: "Où vivez vous?",
                                        label: "Votre lieu de domiciliation",
                                        suficon: Icons.close,
                                      ),
                                    ],
                                  ),
                                )),
                              ),

                              // SizedBox(width: 100,),

                              SizedBox(
                                width: 350,
                                child: Form(
                                    child: Padding(
                                  padding: EdgeInsets.fromLTRB(40, 30, 40, 30),
                                  child: Column(
                                    children: [
                                      textfield(
                                        readOnly: true,
                                        hintText: "",
                                        label: "Votre pays d'activité ",
                                        suficon: Icons.flag_sharp,
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      textfield(
                                        readOnly: true,
                                        hintText: "",
                                        label: "Votre ville d'activité",
                                        suficon: Icons.flag_circle,
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      textfield(
                                        readOnly: true,
                                        hintText: "",
                                        label: "Votre poste",
                                        suficon: Icons.work,
                                      ),
                                    ],
                                  ),
                                )),
                              ),

                              // SizedBox(width: 100,),

                              SizedBox(
                                width: 400,
                                child: Form(
                                    child: Padding(
                                  padding: EdgeInsets.fromLTRB(40, 30, 40, 30),
                                  child: Column(
                                    children: [
                                      textfield(
                                        readOnly: true,
                                        hintText: "",
                                        label: "Votre niveau d'accès",
                                        suficon: Icons.lock_clock,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      MultilineText(
                                          labeltext:
                                              " Message pour une demande d'accès",
                                          textButton: "J'envoie ma requête ")
                                    ],
                                  ),
                                )),
                              ),
                            ],
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          buttonType(
            tap: () {},
            text: "Enregistrer mes informations",
            textsize: 16,
          )
        ],
      )),
    );
  }
}

// PANNEAU D'ADMINISTRATION::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class ProfilContenu2 extends StatefulWidget {
  final int ongchange;
  const ProfilContenu2(this.outerTab, {required this.ongchange, super.key});

  final String outerTab;

  @override
  State<ProfilContenu2> createState() => _ProfilContenu2State();
}

class _ProfilContenu2State extends State<ProfilContenu2>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 4, initialIndex: widget.ongchange, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        shadowColor: Colors.yellow,
        elevation: 15,
        margin: const EdgeInsets.all(30.0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Securité du compte",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 182, 22, 10),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CardMoule(
                          width: 350,
                          height: 400,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 350,
                                child: Form(
                                    child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 30, 40, 30),
                                  child: Column(
                                    children: [
                                      const textfield(
                                        autofocus: true,
                                        hintText: "Votre Mot de passe Actuel",
                                        label: "Actuel mot de passe",
                                        preicon: Icons.key_sharp,
                                        suficon: Icons.close,
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      const textfield(
                                        hintText: "Votre nouveau Pass",
                                        label: "Nouveau mot de passe",
                                        preicon: Icons.lock_clock,
                                        suficon: Icons.close,
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      const textfield(
                                        hintText: "Veuillez confirmer le Pass",
                                        label: "Confirmation de mot de passe",
                                        preicon: Icons.lock_clock,
                                        suficon: Icons.close,
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      buttonType(
                                        tap: () {},
                                        text: "Valider la modification",
                                        textsize: 16,
                                      )
                                    ],
                                  ),
                                )),
                              )
                            ],
                          )),
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Support Client",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 108, 30, 197),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CardMoule(
                          width: 700,
                          height: 560,
                          child: Padding(
                            padding: EdgeInsets.all(40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ComboPara(
                                  listValeur: [
                                    "Aide",
                                    "Erreur",
                                    "Urgence",
                                    "Autres",
                                    "Infos"
                                  ],
                                  labeltext: "Sujet",
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                MultilineText(
                                    maxLines: 10,
                                    labeltext: "Votre requête",
                                    textButton: "Envoie de la demande")
                              ],
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Notifications",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 4, 140, 150),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CardMoule(
                          width: 600,
                          height: 560,
                          child: Padding(
                            padding: EdgeInsets.all(40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: 600, height: 450, child: listNotif())
                              ],
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// PANNEAU D'ADMINISTRATION::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class ProfilContenu3 extends StatefulWidget {
  final int ongchange;
  const ProfilContenu3(this.outerTab, {required this.ongchange, super.key});

  final String outerTab;

  @override
  State<ProfilContenu3> createState() => _ProfilContenu3State();
}

class _ProfilContenu3State extends State<ProfilContenu3>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, initialIndex: widget.ongchange, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Card(
        shadowColor: Colors.red,
        elevation: 15,
        margin: EdgeInsets.all(30.0),
        child: Center(
            child: Column(
          children: [],
        )),
      ),
    );
  }
}

// PANNEAU D'ADMINISTRATION::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class ProfilContenu4 extends StatefulWidget {
  final int ongchange;
  const ProfilContenu4(this.outerTab, {required this.ongchange, super.key});

  final String outerTab;

  @override
  State<ProfilContenu4> createState() => _ProfilContenu4State();
}

class _ProfilContenu4State extends State<ProfilContenu4>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 1, initialIndex: widget.ongchange, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Card(
        shadowColor: Colors.red,
        elevation: 15,
        margin: EdgeInsets.all(30.0),
        child: Center(
            child: Column(
          children: [],
        )),
      ),
    );
  }
}
