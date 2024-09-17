import 'package:flutter/material.dart';
import 'package:perf_energie/widgets/Composant/TextCall.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// TABLLEAU D'AFFICHAGE DES INDICATEURS DE PERFORMANCES:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

// ignore: must_be_immutable
class IndicReseigne extends StatefulWidget {
  const IndicReseigne({super.key});

  @override
  State<IndicReseigne> createState() => _IndicReseigneState();
}

class _IndicReseigneState extends State<IndicReseigne> {
  bool isVisible = true;
  bool isLoading = false;

  final _dataStream = Supabase.instance.client
      .from('indicateur')
      .stream(primaryKey: ['id_indicateur']).order('id_indic', ascending: true);

// if (type == true && valide == true) {
//   couleur = Colors.green;
// } else if (type == false && valide == false) {
//   couleur = Colors.red;
// } else {
//   couleur = Colors.orange;
// }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          color: Colors.green,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // SizedBox(width: 10,),
                  const SizedBox(
                    width: 100,
                    child: Center(
                      child: Text(
                        'Reférence',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 500,
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
                          width: 350,
                          child: TextFieldRech(
                            preicon: Icons.search,
                            hintText: "Recherche par indicateur",
                            label: "Recherche par indicateur",
                            ontap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      width: 220,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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

                  const SizedBox(
                    width: 200,
                    child: Center(
                      child: Text(
                        'Réalisé',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 200,
                    child: Center(child: comboMois()),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  const SizedBox(
                    width: 150,
                    child: Center(
                      child: Text(
                        'Cible',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 100,
                    child: Center(
                      child: Text(
                        'Écart',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 150,
                    child: Center(
                      child: Text(
                        'Modifié le',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 1900,
          height: 580,
          child: Center(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _dataStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final data = snapshot.data!;

                return ListView.builder(
                    itemCount: data.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == data.length) {
                        // Affichez un indicateur de chargement lorsque l'utilisateur atteint la fin de la table
                        return isLoading
                            ? Container(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                alignment: Alignment.center,
                                child: const CircularProgressIndicator(),
                              )
                            : const SizedBox
                                .shrink(); // Cachez l'indicateur de chargement s'il n'y a plus de données à charger
                      } else {
                        // Affichez les lignes de données normales
                        var item = data[index];

                        return ListTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
/////////////////////////////////////////// COULLEUR DES INDICATEURS DE CALCUL////////////////////////////////////////////////////
                              Container(
                                height: 40,
                                color: _getColorForItemType(
                                    item['id_type'].toString()),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
/////////////////////////////////////////// REFERENCE DES INDICATEURS////////////////////////////////////////////////////
                                    SizedBox(
                                      width: 100,
                                      child: Center(
                                        child:
                                            Text(item['ref_indic'].toString()),
                                      ),
                                    ),
/////////////////////////////////////////// INTITULE DES INDICATEURS////////////////////////////////////////////////////
                                    SizedBox(
                                      width: 500,
                                      child: Text(
                                        item['intitule_indic'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
/////////////////////////////////////////// PROCESSUS DES INDICATEURS////////////////////////////////////////////////////
                                    SizedBox(
                                      width: 220,
                                      child: Visibility(
                                        visible:
                                            item['id_type'].toString() == "1",
                                        child: Center(
                                          child: Text(
                                              item['id_process'].toString()),
                                        ),
                                      ),
                                    ),
/////////////////////////////////////////// REALISE DES INDICATEURS////////////////////////////////////////////////////
                                    SizedBox(
                                      width: 200,
                                      child: Row(
                                        children: [
                                          const Text("{item['valRealise']}"),
                                          Checkbox(
                                            value: true,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                // Mettez à jour votre logique ici
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
/////////////////////////////////////////// MOIS DU REALISE DES INDICATEURS////////////////////////////////////////////////////
                                    SizedBox(
                                      width: 250,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          const Text("{item['valMois']}"),
                                          SizedBox(
                                            width: 40,
                                            child: Visibility(
                                              visible:
                                                  item['id_type'].toString() ==
                                                      "1",
                                              child: IconButton(
/////////////////////////////////////////// MODIFICATION DES DONNEES DE L'INDICATEUR////////////////////////////////////////////////////
                                                onPressed: () async {
                                                  await showDialog(
                                                      context: context,
                                                      builder:
                                                          (context) =>
                                                              AlertDialog(
                                                                titlePadding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        0,
                                                                        20,
                                                                        0,
                                                                        0),
                                                                title: Center(
                                                                  child:
                                                                      RichText(
                                                                    text: TextSpan(
                                                                        children: [
                                                                          const TextSpan(
                                                                            text:
                                                                                "RENSEIGNEMENT DE L'INDICATEUR ",
                                                                            style:
                                                                                TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                "${item['ref_indic']}",
                                                                            style: const TextStyle(
                                                                                fontSize: 20,
                                                                                color: Colors.red,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ]),
                                                                  ),
                                                                ),
                                                                content:
                                                                    SizedBox(
                                                                  width: 500,
                                                                  height: 150,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children: [
                                                                      // Ajoutez ici les éléments que vous souhaitez afficher dans le dialogue
                                                                      Text(
                                                                        "Intitulés: ${item['intitule_indic']}",
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            400,
                                                                        child:
                                                                            textfield(
                                                                          hintText:
                                                                              "Entrer la valeur de l'indicateur",
                                                                          label:
                                                                              "Indicateurs",
                                                                          autofocus:
                                                                              true,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                actions: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .fromLTRB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            30),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              40,
                                                                          width:
                                                                              200,
                                                                          child:
                                                                              ElevatedButton(
                                                                            style:
                                                                                const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green)),
                                                                            onPressed:
                                                                                () {},
                                                                            child:
                                                                                const Text('Modifier', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              40,
                                                                          width:
                                                                              150,
                                                                          child:
                                                                              ElevatedButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context).pop(); // Fermer le dialogue
                                                                            },
                                                                            child:
                                                                                const Text('Fermer', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ));
                                                },
                                                icon: Icon(
                                                  Icons.border_color_outlined,
                                                  color: Colors.amber[800],
                                                ),
                                              ),
                                            ),
                                          ),
/////////////////////////////////////////// VALIDATEUR ADMIN DES INDICATEURS////////////////////////////////////////////////////
                                          SizedBox(
                                            width: 40,
                                            child: Checkbox(
                                              value: true,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  // Mettez à jour votre logique ici
                                                });
                                              },
                                            ),
                                          ),
/////////////////////////////////////////// JAUGE DE VALIDATION DES INDICATEURS////////////////////////////////////////////////////
                                          Container(
                                            width: 22,
                                            height: 22,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Colors.red,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
/////////////////////////////////////////// CIBLES DES INDICATEURS////////////////////////////////////////////////////
                                    SizedBox(
                                      width: 150,
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                item['cible_indic'].toString()),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const Text("{item['valCible']}"),
                                          ],
                                        ),
                                      ),
                                    ),
/////////////////////////////////////////// ECART DE VALIDATION DES INDICATEURS////////////////////////////////////////////////////
                                    const SizedBox(
                                      width: 100,
                                      child: Center(
                                        child: Text("{item['ecart']} %"),
                                      ),
                                    ),
/////////////////////////////////////////// DATE DE MODIFICATION DES INDICATEURS////////////////////////////////////////////////////
                                    SizedBox(
                                      width: 150,
                                      child: Center(
                                        child: Text(
                                            item['date_cible'] ?? 'Aucun date'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 2,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        );
                      }
                    });
              },
            ),
          ),
        ),
      ],
    );
  }

  Color _getColorForItemType(String? type) {
    switch (type) {
      case "1":
        return Colors.transparent; // Ligne verte pour "primaire"
      case "2":
        return Colors.blue; // Ligne bleue pour "calculer"
      case "3":
        return Colors.amber; // Ligne rouge pour "test"
      default:
        return Colors.teal; // Couleur par défaut
    }
  }
}
