import 'package:flutter/material.dart';
import 'package:perf_energie/widgets/Composant/TextCall.dart';

// TABLLEAU D'AFFICHAGE DES INDICATEURS DE PERFORMANCES:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class IndicateurModel {
  String references;
  String intitules;
  String processus;
  bool realise;
  String valRealise;
  bool mois;
  String valMois;
  int valCible;
  String cible;
  int ecart;
  bool type;

  IndicateurModel({
    required this.references,
    required this.intitules,
    required this.processus,
    required this.realise,
    required this.valRealise,
    required this.mois,
    required this.valMois,
    required this.valCible,
    required this.cible,
    required this.ecart,
    required this.type,
  });
}

// ignore: must_be_immutable
class IndicReseigne extends StatefulWidget {
  const IndicReseigne({super.key});

  @override
  State<IndicReseigne> createState() => _IndicReseigneState();
}

class _IndicReseigneState extends State<IndicReseigne> {

  bool isVisible = true;
  final List<IndicateurModel> data = [
    IndicateurModel(
      references: 'GEN-001',
      intitules:
          'Superficie des plantations industrielles (Mature et Immature)',
      processus: 'Agricole',
      realise: false,
      valRealise: '- - - (Ha)',
      mois: true,
      valMois: '- - - (Ha)',
      valCible: 10,
      cible: ' Hectares',
      ecart: 23,
      type: true,
    ),
    IndicateurModel(
      references: 'GEN-002',
      intitules: 'Superficie des plantations villageoise encadrées',
      processus: 'Agricole',
      realise: true,
      valRealise: '- - - (Ha)',
      mois: false,
      valMois: '- - - (Ha)',
      valCible: 15,
      cible: ' Hectares',
      ecart: 53,
      type: true,
    ),
    IndicateurModel(
      references: 'GEN-003',
      intitules:
          'Superficie des plantations villageoise encadrées géolocalisées',
      processus: 'Agricole',
      realise: false,
      valRealise: '- - - (Ha)',
      mois: true,
      valMois: '- - - (Ha)',
      valCible: 12,
      cible: ' Hectares',
      ecart: 81,
      type: false,
    ),
    IndicateurModel(
      references: 'GEN-004',
      intitules: 'Point des entrées et sorties',
      processus: 'finances',
      realise: false,
      valRealise: '- - - (Ha)',
      mois: true,
      valMois: '- - - (Ha)',
      valCible: 48,
      cible: ' Hectares',
      ecart: 37,
      type: true,
    ),
  ];
  bool isSelect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: Container(
              height: 40,
              color: Colors.green,
              child: Padding(
                padding:const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // SizedBox(width: 10,),
                      const SizedBox(
                        width: 100,
                        child: Expanded(
                            child: Text(
                          'Réf',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                      ),

                      SizedBox(
                        width: 500,
                        child: Expanded(
                            child: Row(
                          children: [
                           const Text(
                              'Intitulés',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                           const SizedBox(
                              width: 30,
                            ),
                            SizedBox(
                              width: 250,
                              height: 27,
                              child: TextFieldRech(
                                preicon: Icons.search,
                                hintText: "Recherche par indicateur",
                                label: "Recherche par indicateur",
                                ontap: (){},
                              ),
                            ),
                          ],
                        )),
                      ),

                      Expanded(
                          child: Row(
                        children: [
                          Visibility(
                            visible: isVisible,
                            child: Row(
                              children: [
                                const Text(
                                  'Processus',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: const Icon(
                                  Icons.search_sharp,
                                  color: Colors.white,
                                )),
                              ],
                            ),
                          ),
                          
                            Visibility(
                              visible: !isVisible,
                              child: SizedBox(
                                width: 200,
                                height: 27,
                                child: TextFieldRech(
                                  preicon: Icons.search,
                                  hintText: "Processus...",
                                  label: "Processus...",
                                  ontap: () {
                                    setState(() {
                                      isVisible = !isVisible;
                                    });
                                  },
                                ),
                              ),
                            ),
                        ],
                      )),

                    const Expanded(
                          child: Text(
                        'Réalisé',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),

                      SizedBox(
                        width: 200,
                        height: 30,
                        child: Expanded(child: comboMois()),
                      ),
                     const SizedBox(
                        width: 30,
                      ),

                    const Expanded(
                          child: Text(
                        'Cible',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),

                      const Expanded(
                          child: Text(
                        'Écart',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
          for (var item in data)
            ListTile(
              title: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      color: item.type
                          ? Colors.transparent
                          : const Color.fromARGB(255, 245, 181, 139),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          children: [
                            SizedBox(
                                width: 100,
                                child: Expanded(
                                    child: Text(item.references.toString()))),
                            SizedBox(
                              width: 500,
                              child: Expanded(
                                  child: Text(item.intitules.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold))),
                            ),
                            SizedBox(
                              width: 200,
                              child: Visibility(
                                  visible: item.type,
                                  child: Expanded(
                                      child: Text(item.processus.toString()))),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(item.valRealise.toString()),
                                  Checkbox(
                                    value: item.realise,
                                    onChanged: (bool? value) {
                                      // Mettez à jour l'état 'realise' lorsqu'une case à cocher est modifiée
                                      // Vous pouvez ajouter votre logique ici
                                      setState(() {
                                        item.realise = value!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(item.valMois.toString()),
                                const SizedBox(
                                  width: 30,
                                ),
                                SizedBox(
                                  width: 50,
                                  child: Visibility(
                                    visible: item.type,
                                    child: IconButton(
                                        onPressed: () {
                                          _openDialog({
                                            'references': item.references,
                                            'intitules': item.intitules,
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.border_color_outlined,
                                          color: Colors.amber,
                                        )),
                                  ),
                                ),
                                Checkbox(
                                  value: item.mois,
                                  onChanged: (value) {
                                    // Mettez à jour l'état 'realise' lorsqu'une case à cocher est modifiée
                                    // Vous pouvez ajouter votre logique ici
                                    setState(() {
                                      item.mois = value!;
                                    });
                                  },
                                ),
                                Container(
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.red),
                                )
                              ],
                            )),
                            const SizedBox(
                              width: 50,
                            ),
                            Expanded(
                                child: Row(
                              children: [
                                Text(item.valCible.toString()),
                                Text(item.cible.toString()),
                              ],
                            )),
                            Expanded(child: Text("${item.ecart} %")),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 2,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Fonction pour ouvrir le dialogue avec les détails de l'élément
  Future<void> _openDialog(Map<String, dynamic> item) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          title: Center(
            child: RichText(
              text: TextSpan(children: [
                const TextSpan(
                  text: "VALIDATEUR DE L'INDICATEUR ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: "${item['references']}",
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
              ]),
            ),
          ),
          content: SizedBox(
            width: 500,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Ajoutez ici les éléments que vous souhaitez afficher dans le dialogue
                Text(
                  'Intitulés: ${item['intitules']}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  width: 400,
                  child: textfield(
                    hintText: "Entrer la valeur de l'indicateur",
                    label: "Indicateurs",
                    autofocus: true,
                  ),
                )
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 40,
                    width: 300,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.green)),
                      onPressed: () {},
                      child: const Text('Modifier',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Fermer le dialogue
                      },
                      child: const Text('Fermer',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
