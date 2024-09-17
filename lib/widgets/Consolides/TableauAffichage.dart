import 'dart:async';
import 'dart:math';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:perf_energie/main.dart';
import 'package:perf_energie/widgets/Composant/Help.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';
import 'package:perf_energie/widgets/GlobaleVariable/date.dart';
import 'package:perf_energie/widgets/Utiles/AjoutForm.dart';
import 'package:perf_energie/widgets/Utiles/Dialogue.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



// Future<List> fetchFiliere() async {
//   final response = await Supabase.instance.client.from('filiere').select();
//   List<dynamic> refs =
//       response.map((filiere) => filiere['nom_filiere']).toList();
//   return refs;
// }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//TABLEAU PROGRES DE COLLECTE MENSUELLE :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 // stateless to stateful
class TabResulMensuel extends StatefulWidget {

  const TabResulMensuel({super.key});

  @override
  State<TabResulMensuel> createState() => _TabResulMensuelState();
}

class _TabResulMensuelState extends State<TabResulMensuel> {
  final List<SousOptM> sousOpts = SousOptM.getSousOptM();

  @override
  Widget build(BuildContext context) {
    String submois = getSubMois();
    String prevmois = getPrevMois();
    String mois = getMois();

    return SizedBox(
      width: 370,
      height: 250,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView.builder(
          itemCount: sousOpts.length + 1, // +1 pour la ligne d'en-tête
          itemBuilder: (context, index) {
            if (index == 0) {
              // Ligne d'en-tête
              return ListTile(
                title: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Filiale / Entités',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        submois.substring(0, 3),
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        prevmois.substring(0, 3),
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        mois.substring(0, 3),
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              );
            }

            // Éléments de données
            final item = sousOpts[index - 1];

            // Couleurs en fonction des pourcentages
            Color couleurSubmois = ColorUtil.getColorFromValue(
                int.parse(item.submois.replaceAll('%', '')));
            Color couleurPrevmois = ColorUtil.getColorFromValue(
                int.parse(item.prevmois.replaceAll('%', '')));
            Color couleurNextmois = ColorUtil.getColorFromValue(
                int.parse(item.nextmois.replaceAll('%', '')));

            return Column(
              children: [
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Text(
                          item.filiale,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          item.submois,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: couleurSubmois),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          item.prevmois,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: couleurPrevmois),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          item.nextmois,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: couleurNextmois),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Divider(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class SousOptM {
  String filiale;
  String submois;
  String prevmois;
  String nextmois;

  SousOptM({
    required this.filiale,
    required this.submois,
    required this.prevmois,
    required this.nextmois,
  });

  static List<SousOptM> getSousOptM() {
    return <SousOptM>[
      SousOptM(
        filiale: "Barage AYAME",
        submois: "82 %",
        prevmois: "5 %",
        nextmois: "78 %",
      ),
      SousOptM(
        filiale: "Barage KOSSOU",
        submois: "45 %",
        prevmois: "25 %",
        nextmois: "68 %",
      ),
      SousOptM(
        filiale: "Barage TAABO",
        submois: "72 %",
        prevmois: "70 %",
        nextmois: "45 %",
      ),
      SousOptM(
        filiale: "Barage UTAG",
        submois: "13 %",
        prevmois: "69 %",
        nextmois: "98 %",
      ),
      SousOptM(
        filiale: "Barage GUIGLO",
        submois: "100 %",
        prevmois: "73 %",
        nextmois: "34%",
      ),
    ];
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//TABLEAU PROGRES DE COLLECTE ANNUELLE :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// stateless to stateful
class TabResulAnnuel extends StatefulWidget {

  const TabResulAnnuel({super.key});

  @override
  State<TabResulAnnuel> createState() => _TabResulAnnuelState();
}

class _TabResulAnnuelState extends State<TabResulAnnuel> {
  final List<SousOptA> sousOpts = SousOptA.getSousOptA();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370,
      height: 250,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView.builder(
          itemCount: sousOpts.length + 1, // +1 pour la ligne d'en-tête
          itemBuilder: (context, index) {
            if (index == 0) {
              // Ligne d'en-tête
              return ListTile(
                title: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Filiale / Entités',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '$subYear',
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '$prevYear',
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '$annee',
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              );
            }

            // Éléments de données
            final item = sousOpts[index - 1];

            // Couleurs en fonction des pourcentages
            Color couleurSubYear = ColorUtil.getColorFromValue(
                int.parse(item.subyear.replaceAll('%', '')));
            Color couleurPrevYear = ColorUtil.getColorFromValue(
                int.parse(item.prevyear.replaceAll('%', '')));
            Color couleurNextYear = ColorUtil.getColorFromValue(
                int.parse(item.nextyear.replaceAll('%', '')));

            return Column(
              children: [
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Text(
                          item.filiale,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          item.subyear,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: couleurSubYear),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          item.prevyear,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: couleurPrevYear),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          item.nextyear,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: couleurNextYear),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Divider(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class SousOptA {
  String filiale;
  String subyear;
  String prevyear;
  String nextyear;

  SousOptA({
    required this.filiale,
    required this.subyear,
    required this.prevyear,
    required this.nextyear,
  });

  static List<SousOptA> getSousOptA() {
    return <SousOptA>[
      SousOptA(
        filiale: "Barage AYAME",
        subyear: "82 %",
        prevyear: "5 %",
        nextyear: "78 %",
      ),
      SousOptA(
        filiale: "Barage KOSSOU",
        subyear: "45 %",
        prevyear: "25 %",
        nextyear: "68 %",
      ),
      SousOptA(
        filiale: "Barage TAABO",
        subyear: "72 %",
        prevyear: "70 %",
        nextyear: "45 %",
      ),
      SousOptA(
        filiale: "Barage UTAG",
        subyear: "13 %",
        prevyear: "69 %",
        nextyear: "98 %",
      ),
      SousOptA(
        filiale: "Barage GUIGLO",
        subyear: "100 %",
        prevyear: "73 %",
        nextyear: "34%",
      ),
    ];
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//TABLEAU DYNAMIQUE DES PROFILS 5 COLONNES:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class TabProfil extends StatefulWidget {
  const TabProfil({Key? key}) : super(key: key);

  @override
  State<TabProfil> createState() => _TabProfilState();
}

class _TabProfilState extends State<TabProfil> {
  List<SousTab> sousTabs = SousTab.getSousTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: ListView(
        children: [
          for (var item in sousTabs)
            Column(
              children: [
                ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _getAvatarColor(item.nom),
                      child: Text(
                        _getInitials(item.nom),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    title: Row(
                      children: [
                        const SizedBox(width: 40),
                        Expanded(
                            child: Text(item.nom,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600))),
                        Expanded(
                            child: Text(item.filiale,
                                style: const TextStyle(
                                  fontSize: 14,
                                ))),
                        Expanded(
                            child: Text(item.entite,
                                style: const TextStyle(
                                  fontSize: 14,
                                ))),
                        Expanded(
                            child: Text(item.acces,
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600))),
                      ],
                    )),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Divider(),
                ),
              ],
            ),
        ],
      ),
    );
  }

  String _getInitials(String user) {
    var buffer = StringBuffer();
    var split = user.split(" ");
    for (var s in split) {
      buffer.write(s[0]);
    }

    return buffer.toString().substring(0, split.length);
  }

  Color _getAvatarColor(String user) {
    List<Color> avatarColors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.blueGrey,
      Colors.brown,
      Colors.lime,
      Colors.grey,
      Colors.amber,
      Colors.pink,
      Colors.indigo,
    ];

    Random random = Random(user.hashCode);
    int randomIndex = random.nextInt(avatarColors.length);

    return avatarColors[randomIndex];
  }
}

class SousTab {
  String nom;
  String filiale;
  String entite;
  String acces;

  SousTab({
    required this.nom,
    required this.filiale,
    required this.entite,
    required this.acces,
  });

  static List<SousTab> getSousTab() {
    return <SousTab>[
      SousTab(
        nom: "Dorgélès LATH",
        filiale: "CIE",
        entite: "Base Palmeraie",
        acces: "Administrateur",
      ),
      SousTab(
        nom: "Cynthia EBRA",
        filiale: "CIE",
        entite: "Base Niangon",
        acces: "Contributeur",
      ),
      SousTab(
        nom: "Linda KOUASSI",
        filiale: "SODECI",
        entite: "Base Cocody",
        acces: "Editeur",
      ),
      SousTab(
        nom: "Elvis MOUSSAN",
        filiale: "SODECI",
        entite: "Base Abobo",
        acces: "Observateur",
      ),
      SousTab(
        nom: "Wilfried AMON",
        filiale: "CIE",
        entite: "Base Yopougon",
        acces: "Observateur",
      ),
      SousTab(
        nom: "Yaya KOUAKOU",
        filiale: "SODECI",
        entite: "Base Grand Bassam",
        acces: "Editeur",
      ),
      SousTab(
        nom: "Hilary SIMPLICE",
        filiale: "CIE",
        entite: "Base Niangon",
        acces: "Administrateur",
      ),
    ];
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//TABLEAU DYNAMIQUE DES CONTRIBUTEURS 9 COLONNES:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class TabContributeur extends StatefulWidget {
  const TabContributeur({Key? key}) : super(key: key);

  @override
  State<TabContributeur> createState() => _TabContributeurState();
}

class _TabContributeurState extends State<TabContributeur> {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> contributeurs = [];
  List<Map<String, dynamic>> roles = [];
  List<Map<String, dynamic>> entites = [];
  List<Map<String, dynamic>> processus = [];

  bool isLoading = true;
  bool _isMounted = false; // Variable pour suivre l'état de montage du widget


 @override
  void initState() {
    super.initState();
 _isMounted = true; // Le widget est maintenant monté
    getData();
    Timer.periodic(const Duration(seconds:2), (Timer t) => getData());
  }

 @override
  void dispose() {
    _isMounted = false; // Le widget est en train d'être démonté
    super.dispose();
  }

  Future<void> getData() async {
    try {
      final responseContributeur = await supabase.from('contributeur').select();
      final responseRole = await supabase.from('role').select();
      final responseEntite = await supabase.from('entite').select();
      final responseProcess = await supabase.from('processus').select();

    if (_isMounted) {
      setState(() {
        contributeurs = responseContributeur;
        roles = responseRole;
        entites = responseEntite;
        processus = responseProcess;
        isLoading =
            false; // Mettre à jour le chargement à false une fois les données chargées
      });
       }
    } catch (error) {
      print(
          'Une erreur est survenue lors de la récupération des données : $error');
      // Affichez un message à l'utilisateur pour indiquer qu'une erreur s'est produite.
      // Ou mettez en place un mécanisme pour gérer l'erreur de manière appropriée.
      if (_isMounted) {
      setState(() {
        isLoading =
            false; // Mettre à jour le chargement à false en cas d'erreur
      });
       }
    }
  }

  Future<void> _deleteData(int id) async {
    final response = await Supabase.instance.client
        .from('contributeur')
        .delete()
        .match({'id_contribut': id});

    if (response == null) {
      const message = "Le contributeur a été supprimé avec succès";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Succès", message, Colors.green));
    } else {
      const message = "Erreur lors de la suppression des données";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {

     fetchRole().then((refs) {
      // print(refs);
      globalRole = refs;
    }).catchError((error) {});
    fetchEntite().then((refs) {
      //print(refs);
      globalentite = refs;
    }).catchError((error) {});
    fetchProcessus().then((refs) {
      //print(refs);
      globalProcessus = refs;
    }).catchError((error) {});

    return isLoading
        ? const Center(
            child:
                CircularProgressIndicator(), // Barre de progression pendant le chargement
          )
        : ListView(children: <Widget>[
            DataTable(
              headingRowColor: WidgetStateColor.resolveWith(
                (states) => Colors.yellow,
              ),
              columns: const [
                DataColumn(
                  label: Text("Crée le",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic)),
                ),
                DataColumn(
                  label: Text("Noms",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic)),
                ),
                DataColumn(
                  label: Text("Prénoms",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic)),
                ),
                DataColumn(
                  label: Text("Emails",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic)),
                ),
                DataColumn(
                  label: Text("Contacts",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic)),
                ),
                DataColumn(
                  label: Text("Adresses",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic)),
                ),
                DataColumn(
                  label: Text("Services",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic)),
                ),
                DataColumn(
                  label: Text("Fonctions",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic)),
                ),
                DataColumn(
                  label: Text("Processus",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic)),
                ),
                DataColumn(
                  label: Text("Accès",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic)),
                ),
              ],
              rows: contributeurs.map((contributeur) {
                final date = contributeur['created_at'];
                final nomcontribut = contributeur['nom_contribut'];
                final prenomcontribut = contributeur['prenom_contribut'];
                final emailcontribut = contributeur['email_contribut'];
                final contactcontribut = contributeur['contact_contribut'];
                final adressecontribut = contributeur['adresse_contribut'];
                final fonctioncontribut = contributeur['fonction_contribut'];
// RECUPERATION DES DONNEES DES PROCESSUS ////////////////////////////////////////////////////////
                final processId = contributeur['id_process'];
                final nomProcess = processus.firstWhere((process) =>
                    process['id_process'] == processId)['nom_process'];
// RECUPERATION DES DONNEES DES ROLES ////////////////////////////////////////////////////////
                final roleId = contributeur['id_role'];
                final nomRole = roles.firstWhere(
                    (role) => role['id_role'] == roleId)['ref_role'];
// RECUPERATION DES DONNEES DES ENTITES ////////////////////////////////////////////////////////
                final entiteId = contributeur['id_entite'];
                final nomEntite = entites.firstWhere(
                    (entite) => entite['id_entite'] == entiteId)['nom_entite'];

                return DataRow(
                    onSelectChanged: (value) {
                      print(date);

                      showAlignedDialog(
                        context: context,
                        builder: (context) => ModifContributeur(
                          idcontribut: contributeur['id_contribut'],
                          nomcontribut: contributeur['nom_contribut'],
                          prenomcontribut: contributeur['prenom_contribut'],
                          emailcontribut: contributeur['email_contribut'],
                          contactcontribut: contributeur['contact_contribut'],
                          civilite: contributeur['civilite'],
                          adressecontribut: contributeur['adresse_contribut'],
                          fonctioncontribut: contributeur['fonction_contribut'],
                          initValueProcess: nomProcess,
                          initValueEntite: nomEntite,
                          initValueRole: nomRole,
                          acessaudit: contributeur['acces_audit'],
                          acesspilotage: contributeur['acces_pilotage'],
                          acessrapport: contributeur['acces_rapport'],
                          photocontribut: contributeur['photo_contribut'],
                          globalEntite1: globalentite,
                          globalProcessus1: globalProcessus,
                          globalRole1: globalRole,
                        ),
                      );
                    },
                    onLongPress: () {
                      print(contributeur['id_contribut']);
                      showAlignedDialog(
                        context: context,
                        builder: (context) => DeleteOption(
                          reference:
                              "Êtes-vous sûr de vouloir supprimer le contributeur $nomcontribut ?",
                          action: () async => await _deleteData(contributeur[
                              'id_contribut']), // Passer la fonction de suppression
                        ),
                      );
                    },
                    cells:  [ 
                      DataCell(Text(date.substring(0, 10),
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic))),
                      DataCell(Text(nomcontribut,
                          style: const TextStyle(
                              color: Colors.indigo,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic))),
                      DataCell(Text(prenomcontribut,
                          style: const TextStyle(
                              color: Colors.indigo,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic))),
                      DataCell(Text(emailcontribut,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic))),
                      DataCell(Text(contactcontribut,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic))),
                      DataCell(Text(adressecontribut,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic))),
                      DataCell(
                        Text(nomEntite,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic)),
                      ),
                      DataCell(Text(fonctioncontribut,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic))),
                      DataCell(Text(nomProcess,
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic))),
                      DataCell(
                        Text(nomRole,
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic)),
                      ),
                    ]);
              }).toList(),
            ),
          ]);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//TABLEAU DYNAMIQUE DES INDICATEURS :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class TabIndicateur extends StatefulWidget {
  const TabIndicateur({Key? key}) : super(key: key);

  @override
  State<TabIndicateur> createState() => _TabIndicateurState();
}

class _TabIndicateurState extends State<TabIndicateur> {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> indicateurs = [];
  List<Map<String, dynamic>> terminologie = [];
  List<Map<String, dynamic>> unite = [];
  List<Map<String, dynamic>> type = [];
  List<Map<String, dynamic>> processus = [];
  List<Map<String, dynamic>> critere = [];
  bool isLoading = true;
  bool _isMounted = false; // Variable pour suivre l'état de montage du widget


 @override
  void initState() {
    super.initState();
 _isMounted = true; // Le widget est maintenant monté
    getData();
    Timer.periodic(const Duration(seconds:2), (Timer t) => getData());
  }

 @override
  void dispose() {
    _isMounted = false; // Le widget est en train d'être démonté
    super.dispose();
  }

  Future<void> getData() async {
    try {
      final responseIndicateur = await supabase.from('indicateur').select();
      final responseTermino = await supabase.from('terminologie').select();
      final responseUnite = await supabase.from('unite').select();
      final responseType = await supabase.from('type').select();
      final responseProcessus = await supabase.from('processus').select();
      final responseCritere = await supabase.from('critere').select();
    if (_isMounted) {
      setState(() {
        indicateurs = responseIndicateur;
        terminologie = responseTermino;
        unite = responseUnite;
        type = responseType;
        processus = responseProcessus;
        critere = responseCritere;
        isLoading =
            false; // Mettre à jour le chargement à false une fois les données chargées
      });
       }
    } catch (error) {
      print(
          'Une erreur est survenue lors de la récupération des données : $error');
      // Affichez un message à l'utilisateur pour indiquer qu'une erreur s'est produite.
      // Ou mettez en place un mécanisme pour gérer l'erreur de manière appropriée.
      if (_isMounted) {
      setState(() {
        isLoading =
            false; // Mettre à jour le chargement à false en cas d'erreur
      });
      }
    }
  }


  Future<void> _deleteData(int id) async {
    final response = await Supabase.instance.client
        .from('indicateur')
        .delete()
        .match({'id_indic': id});

    if (response == null) {
      const message = "L'indicateur a été supprimé avec succès";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Succès", message, Colors.green));
    } else {
      const message = "Erreur lors de la suppression des données";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {

    fetchProcessus().then((refs) {
      // print(refs);
      globalProcessus = refs;
    }).catchError((error) {});
    fetchCritere().then((refs) {
      // print(refs);
      globalCritere = refs;
    }).catchError((error) {});
    fetchTermino().then((refs) {
      //print(refs);
      globalTermino = refs;
    }).catchError((error) {});
    fetchUnite().then((refs) {
      //print(refs);
      globalUnite = refs;
    }).catchError((error) {});
    fetchType().then((refs) {
      //print(refs);
      globalType = refs;
    }).catchError((error) {});

    return isLoading
        ? const Center(
            child:
                CircularProgressIndicator(), // Barre de progression pendant le chargement
          )
        : ListView(
          children: <Widget>[
            DataTable(
                headingRowColor: WidgetStateColor.resolveWith(
                  (states) => Colors.purple,
                ),
                columns: const [
                  DataColumn(
                    label: Text("Date",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic)),
                  ),
                  DataColumn(
                    label: Text("N°",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic)),
                  ),
                  DataColumn(
                    label: Text("Réferences",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic)),
                  ),
                  DataColumn(
                    label: Text("Intitulés",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic)),
                  ),
                  DataColumn(
                    label: Text("Définitions",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic)),
                  ),
                  DataColumn(
                    label: Text("Terminologies",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic)),
                  ),
                  DataColumn(
                    label: Text("Types",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic)),
                  ),
                  DataColumn(
                    label: Text("Fréquences",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic)),
                  ),
                  DataColumn(
                    label: Text("Processus",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic)),
                  ),
                  DataColumn(
                    label: Text("Critères",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic)),
                  ),
                  DataColumn(
                    label: Text("Odd",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic)),
                  ),
                  DataColumn(
                    label: Text("Gri",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic)),
                  ),
                  DataColumn(
                    label: Text("Unités",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic)),
                  ),
                ],
                rows: indicateurs.map((indicateur) {
                  final dateIndic = indicateur['date'];
                  final numIndic = indicateur['num_indic'];
                  final refIndic = indicateur['ref_indic'];
                  final intituleIndic = indicateur['intitule_indic'];
                  final definIndic = indicateur['definition_indic'];
                  final oddIndic = indicateur['odd'];
                  final griIndic = indicateur['gri'];
                  final freqIndic = indicateur['frequence'];
// RECUPERATION DES DONNEES DES PROCESSUS ////////////////////////////////////////////////////////
                  final processId = indicateur['id_process'];
                  final nomProcess = processus.firstWhere((process) =>
                      process['id_process'] == processId)['nom_process'];
// RECUPERATION DES DONNEES DES PROCESSUS ////////////////////////////////////////////////////////
                  final critereId = indicateur['id_critere'];
                  final nomCritere = critere.firstWhere((critere) =>
                      critere['id_critere'] == critereId)['nom_critere'];
// RECUPERATION DES DONNEES DES TERMINOLOGIE ////////////////////////////////////////////////////////
                  final terminoId = indicateur['id_termino'];
                  final nomTermino = terminologie.firstWhere((termino) =>
                      termino['id_termino'] == terminoId)['nom_termino'];
// RECUPERATION DES DONNEES DES TYPES ////////////////////////////////////////////////////////
                  final typeId = indicateur['id_type'];
                  final nomType = type.firstWhere(
                      (typ) => typ['id_type'] == typeId)['ref_type'];
// RECUPERATION DES DONNEES DES UNITES ////////////////////////////////////////////////////////
                  final uniteId = indicateur['id_unite'];
                  final nomUnite = unite.firstWhere(
                      (unit) => unit['id_unite'] == uniteId)['ref_unite'];

                  return DataRow(
                      onSelectChanged: (value) {
                        print(dateIndic);

                        showAlignedDialog(
                          context: context,
                          builder: (context) => ModifIndicateur(
                            idindic: indicateur['id_indic'],
                            numeroText: indicateur['num_indic'],
                            refText: indicateur['ref_indic'],
                            intText: indicateur['intitule_indic'],
                            oddText: indicateur['odd'],
                            griText: indicateur['gri'],
                            defText: indicateur['definition_indic'],
                            initValueFreq: indicateur['frequence'],
                            initValueProcess: nomProcess,
                            initValueCritere: nomCritere,
                            initValueTermino: nomTermino,
                            initValueType: nomType,
                            initValueUnite: nomUnite,
                            globalCritere1:globalCritere,
                            globalProcessus1: globalProcessus,
                            globalTermino1: globalTermino,
                            globalType1: globalType,
                            globalUnite1: globalUnite,
                          ),
                        );
                      },
                      onLongPress: () {
                        print(indicateur['id_indic']);
                        showAlignedDialog(
                          context: context,
                          builder: (context) => DeleteOption(
                            reference:
                                "Êtes-vous sûr de vouloir supprimer l'indicateur $refIndic ?",
                            action: () async => await _deleteData(indicateur[
                                'id_indic']), // Passer la fonction de suppression
                          ),
                        );
                      },
                      cells: [
                        DataCell(Text(dateIndic.substring(0, 10),
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic))),
                        DataCell(
                          Text(numIndic.toString(),
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic)),
                        ),
                        DataCell(Text(refIndic,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic))),
                        DataCell(Text(intituleIndic,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic))),
                        DataCell(Text(definIndic,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic))),
                        DataCell(Text(nomTermino,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic))),
                        DataCell(Text(nomType,
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic))),
                        DataCell(Text(freqIndic,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic))),
                        DataCell(Text(nomProcess,
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic))),
                        DataCell(Text(nomCritere,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic))),
                        DataCell(Text(oddIndic,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic))),
                        DataCell(Text(griIndic,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic))),
                        DataCell(Text(nomUnite,
                            style: const TextStyle(
                                color: Colors.indigo,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic))),
                      ]);
                }).toList())
          ]);
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//TABLEAU DYNAMIQUE DES ENTITES 6 COLONNES:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class TabEntite extends StatefulWidget {
  const TabEntite({Key? key}) : super(key: key);

  @override
  State<TabEntite> createState() => _TabEntiteState();
}

class _TabEntiteState extends State<TabEntite> {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> entites = [];
  List<Map<String, dynamic>> filiale = [];
  List<Map<String, dynamic>> ville = [];
  List<Map<String, dynamic>> pays = [];
  bool isLoading = true;
  bool _isMounted = false; // Variable pour suivre l'état de montage du widget


   @override
  void initState() {
    super.initState();
 _isMounted = true; // Le widget est maintenant monté
    getData();
   Timer.periodic(const Duration(seconds:2), (Timer t) => getData());
  }

 @override
  void dispose() {
    _isMounted = false; // Le widget est en train d'être démonté
    super.dispose();
  }


  Future<void> getData() async {
    try {
      final responseEntites = await supabase.from('entite').select();
      final responseFiliale = await supabase.from('filiale').select();
      final responseVille = await supabase.from('ville').select();
      final responsePays = await supabase.from('pays').select();
if (_isMounted) {
        setState(() {
          entites = responseEntites;
        filiale = responseFiliale;
        ville = responseVille;
        pays = responsePays;

        isLoading =  false; // Mettre à jour le chargement à false une fois les données chargées
        });
      }


    } catch (error) {
      print(
          'Une erreur est survenue lors de la récupération des données : $error');
      // Affichez un message à l'utilisateur pour indiquer qu'une erreur s'est produite.
      // Ou mettez en place un mécanisme pour gérer l'erreur de manière appropriée.
if (_isMounted) {
        setState(() {
           isLoading =
            false; // Mettre à jour le chargement à false en cas d'erreur
        });
      }
    }
  }


  Future<void> _deleteData(int id) async {
    final response = await Supabase.instance.client
        .from('entite')
        .delete()
        .match({'id_entite': id});

    if (response == null) {
      const message = "L'entité a été supprimée avec succès";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Succès", message, Colors.green));
    } else {
      const message = "Erreur lors de la suppression des données";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {

    fetchFiliale().then((refs) {
      // print(refs);
      globalFiliale = refs;
    }).catchError((error) {});
    fetchVille().then((refs) {
      //print(refs);
      globalVille = refs;
    }).catchError((error) {});

    return isLoading
        ? const Center(
            child:
                CircularProgressIndicator(), // Barre de progression pendant le chargement
          )
        : ListView(children: <Widget>[
            DataTable(
              headingRowColor: WidgetStateColor.resolveWith(
                (states) => Colors.blue,
              ),
              columns: const [
                DataColumn(
                  label: Text("Abréviat°",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic)),
                ),
                DataColumn(
                  label: Text("Entités",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic)),
                ),
                DataColumn(
                  label: Text("Emails",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic)),
                ),
                DataColumn(
                  label: Text("Contacts",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic)),
                ),
                DataColumn(
                  label: Text("Ville",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic)),
                ),
                DataColumn(
                  label: Text("Pays",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic)),
                ),
                DataColumn(
                  label: Text("Filiales",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic)),
                ),
              ],
              rows: entites.map((entite) {
                final abrEntite = entite['abr_entite'];
                final nomEntite = entite['nom_entite'];
                final emailEntite = entite['email_entite'];
                final contactEntite = entite['contact_entite'];
// RECUPERATION DES DONNEES DES VILLES ////////////////////////////////////////////////////////
                 final villeId = entite['id_ville'];
                final nomVille = ville.firstWhere(
                    (ville) => ville['id_ville'] == villeId)['ref_ville'];
// final villeElement = ville.firstWhereOrNull((ville) => ville['id_ville'] == villeId);
// final nomVille = villeElement != null ? villeElement['ref_ville'] : '';


// RECUPERATION DES DONNEES DES FILIALES ////////////////////////////////////////////////////////
                final filialeId = entite['id_filiale'];
                final nomFiliale = filiale.firstWhere((filiale) =>
                    filiale['id_filiale'] == filialeId)['nom_filiale'];
// final filialeElement = filiale.firstWhereOrNull((filiale) => filiale['id_filiale'] == filialeId);
// final nomFiliale = filialeElement != null ? filialeElement['nom_filiale'] : '';

// RECUPERATION DES DONNEES DES PAYS ////////////////////////////////////////////////////////
                final paysId = ville.firstWhere(
                    (ville) => ville['id_ville'] == villeId)['id_pays'];
                final nomPays = pays.firstWhere(
                    (pays) => pays['id_pays'] == paysId)['ref_pays'];

// final paysElement = pays.firstWhereOrNull((pays) => pays['id_pays'] == paysId);
// final nomPays = paysElement != null ? paysElement['ref_pays'] : '';

                return DataRow(
                    onSelectChanged: (value) {
                      print(entite['id_entite']);

                      showAlignedDialog(
                          context: context,
                          builder: (context) => ModifEntite(
                            identite: entite['id_entite'],
                            nomentite: entite['nom_entite'],
                            emailentite: entite['email_entite'],
                            contactentite: entite['contact_entite'],
                            abrentite: entite['abr_entite'],
                            initValueFiliale: nomFiliale,
                            initValueVille: nomVille,
                            globalFilile1: globalFiliale,
                            globalVile1: globalVille,
                          ),
                        );
                    },
                    onLongPress: () {
                        print(entite['id_entite']);
                        showAlignedDialog(
                          context: context,
                          builder: (context) => DeleteOption(
                            reference:
                                "Êtes-vous sûr de vouloir supprimer l'entite $nomEntite ?",
                            action: () async => await _deleteData(entite[
                                'id_entite']), // Passer la fonction de suppression
                          ),
                        );
                      },
                    cells: [
                      DataCell(Text(abrEntite,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic))),
                      DataCell(
                        Text(nomEntite,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic)),
                      ),
                      DataCell(Text(emailEntite,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic))),
                      DataCell(Text(contactEntite,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic))),
                      DataCell(Text(nomVille,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic))),
                      DataCell(Text(nomPays,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic))),
                      DataCell(Text(nomFiliale,
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic))),
                    ]);
              }).toList(),
            ),
          ]);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//TABLEAU DYNAMIQUE DES FILIALES 6 COLONNES:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class TabFiliale extends StatefulWidget {
  const TabFiliale({Key? key}) : super(key: key);

  @override
  State<TabFiliale> createState() => _TabFilialeState();
}

class _TabFilialeState extends State<TabFiliale> {
 final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> filiales = [];
  List<Map<String, dynamic>> filiere = [];
  bool isLoading = true;
  bool _isMounted = false; // Variable pour suivre l'état de montage du widget


   @override
  void initState() {
    super.initState();
 _isMounted = true; // Le widget est maintenant monté
   _refreshData();
    // Rafraîchissez les données toutes les 2secondes
    Timer.periodic(const Duration(seconds:2), (Timer t) => _refreshData());
  }

   Future<void> _refreshData() async {
    try {
      final responseFiliale = await supabase.from('filiale').select();
      final responseFiliere = await supabase.from('filiere').select();

      if (_isMounted) {
        setState(() {
          filiales = responseFiliale;
          filiere = responseFiliere;
          isLoading = false;
        });
      }
    } catch (error) {
      print('Erreur lors de la récupération des données : $error');
      // Gérer l'erreur de manière appropriée
    }
  }

 @override
  void dispose() {
    _isMounted = false; // Le widget est en train d'être démonté
    super.dispose();
  }


 Future<void> _deleteData(int id) async {
    final response = await Supabase.instance.client
        .from('filiale')
        .delete()
        .match({'id_filiale': id});

    if (response == null) {
      const message = "La filiale a été supprimée avec succès";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Succès", message, Colors.green));
    } else {
      const message = "Erreur lors de la suppression des données";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    fetchFiliere().then((refs) {
      // print(refs);
      globalFiliere = refs;
    }).catchError((error) {});
    return isLoading
        ? const Center(
            child:
                CircularProgressIndicator(), // Barre de progression pendant le chargement
          )
        :ListView(children: <Widget>[
      DataTable(
        headingRowColor: WidgetStateColor.resolveWith(
          (states) => const Color.fromARGB(255, 5, 179, 48),
        ),
        columns: const [
          DataColumn(
            label: Text("Noms",
              style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic)),
          ),
          DataColumn(
            label: Text("Emails",
              style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic)),
          ),
          DataColumn(
            label: Text("Contacts",
              style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic)),
          ),
          DataColumn(
            label: Text("Filières",
              style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic)),
          ),
        ],
        rows: filiales.map((filiale) {
                final nomfiliale = filiale['nom_filiale'];
                final emailfiliale = filiale['email_filiale'];
                final contactfiliale = filiale['contact_filiale'];
// RECUPERATION DES DONNEES DES FILIERES ////////////////////////////////////////////////////////
                 final filiereId = filiale['id_filiere'];
                final nomFiliere = filiere.firstWhere(
                    (filiere) => filiere['id_filiere'] == filiereId)['nom_filiere'];
// final filiereElement = filiere.firstWhereOrNull((filiere) => filiere['id_filiere'] == filiereId);
// final nomfiliere = filiereElement != null ? filiereElement['nom_filiere'] : '';

                return DataRow(
                  onSelectChanged: (value) {
                      print(filiale['id_filiale']);

                      showAlignedDialog(
                          context: context,
                          builder: (context) => ModifFiliale(
                            idfiliale: filiale['id_filiale'],
                            nomfiliale: filiale['nom_filiale'],
                            emailfiliale: filiale['email_filiale'],
                            contactfiliale: filiale['contact_filiale'],
                            initValueFiliere: nomFiliere,
                            logoFiliale: filiale['logo_filiale'],
                            globalFiliere1: globalFiliere,
                          ),
                        );
                    },
                    onLongPress: () {
                        print(filiale['id_filiale']);
                        showAlignedDialog(
                          context: context,
                          builder: (context) => DeleteOption(
                            reference:
                                "Êtes-vous sûr de vouloir supprimer la filiale $nomfiliale ?",
                            action: () async => await _deleteData(filiale[
                                'id_filiale']), // Passer la fonction de suppression
                          ),
                        );
                      },
                  cells: [
                    DataCell(Text(nomfiliale,
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic))),
                    DataCell(
                      Text(emailfiliale,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic)),
                    ),
                    DataCell(Text(contactfiliale,
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic))),
                    DataCell(Text(nomFiliere,
                        style: const TextStyle(
                          color: Colors.red,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic))),
                  ]);
             })
            .toList(),
      ),
    ]);
  }
}