import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:perf_energie/pages/Onglet/ParamatrageIndicateur/AjoutCible.dart';
import 'package:perf_energie/pages/Onglet/ParamatrageIndicateur/FonctAjout.dart';
import 'package:perf_energie/pages/Onglet/ParamatrageIndicateur/FonctModif.dart';
import 'package:perf_energie/pages/Onglet/ParamatrageIndicateur/Indicalcule.dart';
import 'package:perf_energie/pages/Onglet/ParametrageService/ServiceAjout.dart';
import 'package:perf_energie/pages/Onglet/ParametrageService/ServiceModif.dart';
import 'package:perf_energie/widgets/Composant/Button.dart';
import 'package:perf_energie/widgets/Consolides/CardAffichage.dart';
import 'package:perf_energie/widgets/Consolides/TableauAffichage.dart';
import 'package:perf_energie/widgets/Composant/TextCall.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';
import 'package:perf_energie/widgets/Utiles/AjoutForm.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// PROFIL DES GESTIONNAIRES:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class NestedTabBar extends StatefulWidget {
  final int ongChange;
  const NestedTabBar(this.outerTab, {required this.ongChange, super.key});

  final String outerTab;

  @override
  State<NestedTabBar> createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 3, initialIndex: widget.ongChange, vsync: this);
        fetchAndTransferData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


 Future<void> fetchAndTransferData() async {
  try {
    // Récupérer les données depuis la table "indicateur" avec "id_type" différent de 1
    final response = await Supabase.instance.client
        .from('indicateur')
        .select('id_indic, ref_indic')
        .neq('id_type', 1);

    // Obtenez les données des indicateurs à calculer
    List<dynamic> indicCalcul = response;
    print('Les données récupérées sont : $indicCalcul');

    // Parcourir la liste des indicateurs à calculer et les insérer dans la table "indicalcule"
    for (var indic in indicCalcul) {
      // Accéder aux valeurs id_indic et ref_indic de chaque indicateur
      dynamic idIndic = indic['id_indic'];
      dynamic refIndic = indic['ref_indic'];

      // Vérifier si ref_indic existe déjà dans la table "indicalcule"
      final existingRecord = await Supabase.instance.client
          .from('indicalcule')
          .select('ref_indicalcule')
          .eq('ref_indicalcule', refIndic);

      // Si aucune entrée avec la même ref_indic n'existe, insérer dans la table "indicalcule"
      if (existingRecord.isEmpty) {
        // Écrire les identifiants des indicateurs à calculer dans la table "indicalcule"
        final writeResponse = await Supabase.instance.client
            .from('indicalcule')
            .insert({'id_indic': idIndic, 'ref_indicalcule': refIndic});

        // Vérifier s'il y a eu des erreurs lors de l'écriture dans la table "indicalcule"
        if (writeResponse!= null) {
          throw Exception('Erreur lors de l\'écriture des indicateurs calculés dans la table "indicalcule" : ${writeResponse.error}');
        }
      } else {
        print('La référence $refIndic existe déjà dans la table "indicalcule", l\'insertion est ignorée.');
      }
    }

    print('Enregistrement des indicateurs calculés effectué avec succès');
  } catch (error) {
    print('Erreur lors du transfert des données : $error');
  }
}


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar.secondary(
          labelStyle:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.black,
          indicatorColor: Colors.orange,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 5,
          controller: _tabController,
          tabs: const <Widget>[
            Tab(text: 'Configuration des indicateurs cible et Calcule'),
            Tab(text: 'Sécurité / Support client / Notifications'),
            Tab(text: 'Configuration des données de services'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              // INFORMATION PERSONNELES:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

              Card(
                shadowColor: Colors.blue,
                elevation: 15,
                margin: const EdgeInsets.all(30.0),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CardMoule(
                        width: 500,
                        height: 630,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            buttonIcon(
                                width: 300,
                                height: 50,
                                tap: () {},
                                backgroundColor: indicateurColor,
                                text: "Configuration d'entrée des cibles",
                                color: Colors.white,
                                icon: Icons.account_tree_rounded),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                                width: 480,
                                height: 480,
                                child: IndicParametrage()),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CardMoule(
                        width: 1300,
                        height: 630,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            buttonIcon(
                                width: 350,
                                height: 50,
                                tap: () {
                                  fetchAndTransferData();
                                },
                                backgroundColor: indicateurColor,
                                text:
                                    "Actulisation des indicateurs de calculs",
                                color: Colors.white,
                                icon: Icons.replay_circle_filled_rounded),
                            const SizedBox(
                              height: 20,
                            ),
                             SizedBox(
                                width: 1300,
                                height: 480,
                                child: IndiCalculPara()),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
              ),

// INFORMATION DU COMPTE:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

              const Card(
                shadowColor: Colors.yellow,
                elevation: 15,
                margin: EdgeInsets.all(30.0),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                  child: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                  ),
                ),
              ),

// AIDE :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

              Card(
                shadowColor: Colors.red,
                elevation: 15,
                margin: const EdgeInsets.all(30.0),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                  child: Center(
                      child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ////////////PARAMETRAGE DES GROUPES//////////////////////////////////////////////////////////////////////////////////////////
                          CardMoule(
                            width: 350,
                            height: 285,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                buttonIcon(
                                    width: 250,
                                    tap: () {
                                      showAlignedDialog(
                                          context: context,
                                          builder: ((context) =>
                                              const Groupajout()));
                                    },
                                    backgroundColor: Colors.teal,
                                    text: "Ajouter un groupe",
                                    color: Colors.white,
                                    icon: Icons.add),
                                const SizedBox(
                                  height: 20,
                                ),
                                const SizedBox(
                                    width: 350,
                                    height: 190,
                                    child: GroupParametrage()),
                              ],
                            ),
                          ),
                          ////////////PARAMETRAGE DES FILIERES //////////////////////////////////////////////////////////////////////////////////////////
                          CardMoule(
                            width: 350,
                            height: 285,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                buttonIcon(
                                    width: 250,
                                    tap: () {
                                      showAlignedDialog(
                                          context: context,
                                          builder: ((context) =>
                                              const Filereajout()));
                                    },
                                    backgroundColor: Colors.indigo,
                                    text: "Ajouter une filière",
                                    color: Colors.white,
                                    icon: Icons.add),
                                const SizedBox(
                                  height: 20,
                                ),
                                const SizedBox(
                                    width: 350,
                                    height: 190,
                                    child: FiliereParametrage()),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ////////////PARAMETRAGE DES PAYS //////////////////////////////////////////////////////////////////////////////////////////
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CardMoule(
                            width: 350,
                            height: 285,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                buttonIcon(
                                    width: 250,
                                    tap: () {
                                      showAlignedDialog(
                                          context: context,
                                          builder: ((context) =>
                                              const Paysajout()));
                                    },
                                    backgroundColor: Colors.orange,
                                    text: "Ajouter un pays",
                                    color: Colors.white,
                                    icon: Icons.add),
                                const SizedBox(
                                  height: 20,
                                ),
                                const SizedBox(
                                    width: 350,
                                    height: 190,
                                    child: PaysParametrage()),
                              ],
                            ),
                          ),
                          ////////////PARAMETRAGE DES VILLES//////////////////////////////////////////////////////////////////////////////////////////
                          CardMoule(
                            width: 350,
                            height: 285,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                buttonIcon(
                                    width: 250,
                                    tap: () {
                                      showAlignedDialog(
                                          context: context,
                                          builder: ((context) =>
                                              const Villeajout()));
                                    },
                                    backgroundColor: Colors.red,
                                    text: "Ajouter une ville",
                                    color: Colors.white,
                                    icon: Icons.add),
                                const SizedBox(
                                  height: 20,
                                ),
                                const SizedBox(
                                    width: 350,
                                    height: 190,
                                    child: VilleParametrage()),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
////////////PARAMETRAGE DES TERMINOLOGIES//////////////////////////////////////////////////////////////////////////////////////////
                          CardMoule(
                            width: 350,
                            height: 285,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                buttonIcon(
                                    width: 250,
                                    tap: () {
                                      showAlignedDialog(
                                          context: context,
                                          builder: ((context) =>
                                              const Terminoajout()));
                                    },
                                    backgroundColor: Colors.blueGrey,
                                    text: "Ajouter une terminologie",
                                    color: Colors.white,
                                    icon: Icons.add),
                                const SizedBox(
                                  height: 20,
                                ),
                                const SizedBox(
                                    width: 350,
                                    height: 190,
                                    child: TerminoParametrage()),
                              ],
                            ),
                          ),
////////////PARAMETRAGE DES UNITES //////////////////////////////////////////////////////////////////////////////////////////
                          CardMoule(
                            width: 350,
                            height: 285,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                buttonIcon(
                                    width: 250,
                                    tap: () {
                                      showAlignedDialog(
                                          context: context,
                                          builder: ((context) =>
                                              const Uniteajout()));
                                    },
                                    backgroundColor: Colors.black,
                                    text: "Ajouter une unité",
                                    color: Colors.white,
                                    icon: Icons.add),
                                const SizedBox(
                                  height: 20,
                                ),
                                const SizedBox(
                                    width: 350,
                                    height: 190,
                                    child: UniteParametrage()),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
////////////PARAMETRAGE DES TYPES //////////////////////////////////////////////////////////////////////////////////////////
                          CardMoule(
                            width: 350,
                            height: 285,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                buttonIcon(
                                    width: 250,
                                    tap: () {
                                      showAlignedDialog(
                                          context: context,
                                          builder: ((context) =>
                                              const Typeajout()));
                                    },
                                    backgroundColor: Colors.amber,
                                    text: "Ajouter un type de calcul",
                                    color: Colors.white,
                                    icon: Icons.add),
                                const SizedBox(
                                  height: 20,
                                ),
                                const SizedBox(
                                    width: 350,
                                    height: 190,
                                    child: TypeParametrage()),
                              ],
                            ),
                          ),
////////////PARAMETRAGE DES FORMULES//////////////////////////////////////////////////////////////////////////////////////////
                          CardMoule(
                            width: 350,
                            height: 285,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                buttonIcon(
                                    width: 250,
                                    tap: () {
                                      showAlignedDialog(
                                          context: context,
                                          builder: ((context) =>
                                              const Formuleajout()));
                                    },
                                    backgroundColor: Colors.purple,
                                    text: "Ajouter une formule",
                                    color: Colors.white,
                                    icon: Icons.add),
                                const SizedBox(
                                  height: 20,
                                ),
                                const SizedBox(
                                    width: 350,
                                    height: 190,
                                    child: FormuleParametrage()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// PANNEAU D'ADMINISTRATION::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class NestedTabBar2 extends StatefulWidget {
  final int ongchange;
  const NestedTabBar2(this.outerTab, {required this.ongchange, super.key});

  final String outerTab;

  @override
  State<NestedTabBar2> createState() => _NestedTabBar2State();
}

class _NestedTabBar2State extends State<NestedTabBar2>
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
    return Column(
      children: <Widget>[
        TabBar.secondary(
          labelStyle:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.black,
          indicatorColor: Colors.orange,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 5,
          controller: _tabController,
          tabs: const <Widget>[
            Tab(text: 'Contributeurs'),
            Tab(text: 'Entités /Filiales'),
            Tab(text: 'Indicateurs'),
            Tab(text: "Axes/Enjeux/Critères/Processus"),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
// CONTRIBUTEURS::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

              Card(
                shadowColor: Colors.yellow,
                elevation: 15,
                margin: const EdgeInsets.all(30.0),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.refresh_sharp,
                                    size: 30,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Rafraîchir",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.filter,
                                    size: 23,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Filtrer",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.sort,
                                    size: 23,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Trier",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 100,
                            ),
                            SizedBox(
                              width: 600,
                              child: TextFieldRech(
                                iconColor: Colors.yellow,
                                ontap: () {},
                                hintText: "Que recherchez-vous svp",
                                label: "Recherche",
                                preicon: Icons.search_outlined,
                              ),
                            ),
                            const SizedBox(
                              width: 450,
                            ),
                            buttonIcon(
                              width: 250,
                              height: 40,
                              backgroundColor: Colors.yellow,
                              tap: () {
                                showAlignedDialog(
                                    context: context,
                                    builder: ((context) =>
                                        const AjoutContributeur()));
                              },
                              text: "Ajouter un contributeur",
                              color: Colors.black,
                              icon: Icons.add,
                              iconcolor: Colors.black,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Expanded(
                        child: SizedBox(
                            // width: 1000,
                            //height: 300,
                            child: TabContributeur()),
                      )
                    ],
                  ),
                )),
              ),

// ENTITES ET FILIALES:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

              Card(
                shadowColor: Colors.green,
                elevation: 15,
                margin: const EdgeInsets.all(20.0),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.refresh_sharp,
                                    size: 30,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Rafraîchir",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              width: 600,
                              child: TextFieldRech(
                                iconColor: Colors.blue,
                                ontap: () {},
                                hintText: "Que recherchez-vous svp",
                                label: "Recherche sur les entités",
                                preicon: Icons.search_outlined,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            buttonIcon(
                                width: 220,
                                height: 40,
                                backgroundColor:
                                    const Color.fromARGB(255, 64, 131, 255),
                                tap: () {
                                  showAlignedDialog(
                                      context: context,
                                      builder: ((context) =>
                                          const AjoutEntite()));
                                },
                                text: "Ajouter une entité",
                                color: Colors.white,
                                icon: Icons.add),
                            const SizedBox(
                              width: 130,
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.refresh_sharp,
                                    size: 30,
                                    color: Colors.green,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Rafraîchir",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              width: 350,
                              child: TextFieldRech(
                                ontap: () {},
                                hintText: "Que recherchez-vous svp",
                                label: "Recherche sur les filiales",
                                preicon: Icons.search_outlined,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            buttonIcon(
                                width: 220,
                                height: 40,
                                backgroundColor:
                                    const Color.fromARGB(255, 5, 179, 48),
                                tap: () {
                                  showAlignedDialog(
                                      context: context,
                                      builder: ((context) =>
                                          const AjoutFiliale()));
                                },
                                text: "Ajouter une filiale",
                                color: Colors.white,
                                icon: Icons.add)
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Expanded(
                        child: SizedBox(
                            // width: 1000,
                            //height: 300,
                            child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 1100, child: TabEntite()),
                              SizedBox(
                                width: 20,
                              ),
                              SizedBox(width: 750, child: TabFiliale())
                            ],
                          ),
                        )),
                      )
                    ],
                  ),
                )),
              ),

// INDICATEURS ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

              Card(
                shadowColor: Colors.purple,
                elevation: 15,
                margin: const EdgeInsets.all(30.0),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.refresh_sharp,
                                    size: 30,
                                    color: Colors.purple,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Rafraîchir",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.filter,
                                    size: 23,
                                    color: Colors.purple,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Filtrer",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.sort,
                                    size: 23,
                                    color: Colors.purple,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Trier",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 100,
                            ),
                            SizedBox(
                              width: 600,
                              child: TextFieldRech(
                                iconColor: Colors.purple,
                                ontap: () {},
                                hintText: "Que recherchez-vous svp",
                                label: "Recherche",
                                preicon: Icons.search_outlined,
                              ),
                            ),
                            const SizedBox(
                              width: 450,
                            ),
                            buttonIcon(
                                width: 300,
                                height: 40,
                                backgroundColor: Colors.purple,
                                tap: () {
                                  showAlignedDialog(
                                      context: context,
                                      builder: ((context) =>
                                          const AjoutIndicateur()));
                                },
                                text: "Ajouter un indicateur",
                                color: Colors.white,
                                icon: Icons.add)
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Expanded(
                        child: SizedBox(
                            // width: 1000,
                            //height: 300,
                            child: TabIndicateur()),
                      )
                    ],
                  ),
                )),
              ),

// PARAMETRAGES :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

              Card(
                shadowColor: Colors.purple,
                elevation: 15,
                margin: const EdgeInsets.all(30.0),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        children: [
                          SizedBox(width: 60),
                          Text(
                            "Axes",
                            style: TextStyle(
                              fontSize: 20,
                              color: axeColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 390,
                          ),
                          Text(
                            "Enjeux",
                            style: TextStyle(
                              fontSize: 20,
                              color: enjeuColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 280,
                          ),
                          Text(
                            "Critères ",
                            style: TextStyle(
                              fontSize: 20,
                              color: critereColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 260,
                          ),
                          Text(
                            "Processus",
                            style: TextStyle(
                              fontSize: 20,
                              color: processusColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
////////////PARAMETRAGE DES AXES //////////////////////////////////////////////////////////////////////////////////////////
                          CardMoule(
                            width: 320,
                            height: 570,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                buttonIcon(
                                    tap: () {
                                      showAlignedDialog(
                                          context: context,
                                          builder: ((context) =>
                                              const Axeajout()));
                                    },
                                    backgroundColor: axeColor,
                                    text: "Ajouter un axe",
                                    color: Colors.white,
                                    icon: Icons.add),
                                const SizedBox(
                                  height: 20,
                                ),
                                const SizedBox(
                                    width: 300,
                                    height: 480,
                                    child: AxeParametrage()),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
////////////PARAMETRAGE DES ENJEUX //////////////////////////////////////////////////////////////////////////////////////////
                          CardMoule(
                            width: 400,
                            height: 570,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                buttonIcon(
                                    tap: () {
                                      showAlignedDialog(
                                          context: context,
                                          builder: ((context) =>
                                              const Enjeuajout()));
                                    },
                                    backgroundColor: enjeuColor,
                                    text: "Ajouter un enjeu",
                                    color: Colors.white,
                                    icon: Icons.add),
                                const SizedBox(
                                  height: 20,
                                ),
                                const SizedBox(
                                    width: 400,
                                    height: 480,
                                    child: EnjeuParametrage()),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
////////////PARAMETRAGE DES CRITERES//////////////////////////////////////////////////////////////////////////////////////////
                          CardMoule(
                            width: 350,
                            height: 570,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                buttonIcon(
                                    width: 250,
                                    tap: () {
                                      showAlignedDialog(
                                          context: context,
                                          builder: ((context) =>
                                              const Critereajout()));
                                    },
                                    backgroundColor: critereColor,
                                    text: "Ajouter un critère",
                                    color: Colors.white,
                                    icon: Icons.add),
                                const SizedBox(
                                  height: 20,
                                ),
                                const SizedBox(
                                    width: 350,
                                    height: 480,
                                    child: CritereParametrage()),
                              ],
                            ),
                          ),
////////////PARAMETRAGE DES PROCESSUS//////////////////////////////////////////////////////////////////////////////////////////
                          CardMoule(
                            width: 350,
                            height: 570,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                buttonIcon(
                                    width: 250,
                                    tap: () {
                                      showAlignedDialog(
                                          context: context,
                                          builder: ((context) =>
                                              const Processusajout()));
                                    },
                                    backgroundColor: processusColor,
                                    text: "Ajouter un processus",
                                    color: Colors.white,
                                    icon: Icons.add),
                                const SizedBox(
                                  height: 20,
                                ),
                                const SizedBox(
                                    width: 350,
                                    height: 480,
                                    child: ProcessusParametrage()),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
