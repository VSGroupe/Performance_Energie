import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perf_energie/main.dart';
import 'package:perf_energie/widgets/Composant/Button.dart';
import 'package:perf_energie/widgets/Composant/Help.dart';
import 'package:perf_energie/widgets/Composant/TextCall.dart';
import 'package:perf_energie/widgets/Consolides/CardAffichage.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

////  INDICATEURS CALCULES DES CIBLES PAR INDICATEURS ///////////////////////////////////////////////////////////////////////////////////////////////////////

Future<List> fetchIndic() async {
  final response = await Supabase.instance.client
      .from('indicateur')
      .select()
      .eq('id_type', 1)
      .order('id_indic', ascending: true);
  List<dynamic> refs = response.map((indic) => indic['ref_indic']).toList();
  return refs;
}

Future<List> fetchFormule() async {
  final response = await Supabase.instance.client
      .from('formule')
      .select()
      .order('id_formule', ascending: true);
  List<dynamic> refs =
      response.map((formule) => formule['ref_formule']).toList();
  return refs;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

class IndiCalculPara extends StatefulWidget {
  const IndiCalculPara({super.key});

  @override
  State<IndiCalculPara> createState() => _IndiCalculParaState();
}

class _IndiCalculParaState extends State<IndiCalculPara> {
  final _formKey = GlobalKey<FormState>();
  List<dynamic> idIndic = [];
  List<dynamic> idFormul = [];
  List<Map<String, dynamic>> formule = [];
  List<Map<String, dynamic>> indicalcule = [];
  int idFormule = 0;
  late bool isNull;
  List<String?> nomFormules =
      []; // Ajout de la variable d'état pour stocker les noms de formule
  late int idVal;

  final _dataStream1 = Supabase.instance.client.from('indicalcule').stream(
      primaryKey: ['id_indicalcule']).order('id_indicalcule', ascending: true);

  Future<List> fetchidIndic() async {
    final response = await Supabase.instance.client
        .from('indicateur')
        .select('id_indic,ref_indic')
        .eq('id_type', 1)
        .order('id_indic', ascending: true);
    List<dynamic> ids = response.map((indic) => indic['id_indic']).toList();
    return ids;
  }

  Future<List> fetchidFormule() async {
    final response = await Supabase.instance.client
        .from('formule')
        .select('id_formule,ref_formule')
        .order('id_formule', ascending: true);
    List<dynamic> ids =
        response.map((formule) => formule['id_formule']).toList();
    return ids;
  }

  dynamic retrouverIndicateur(dynamic selectedValue) async {
    int index = globalIndic.indexOf(selectedValue);
    if (index != -1 && index < idIndic.length) {
      print(globalIndic);
      print(idIndic);
      idVal = idIndic[index];
      print("son identifiant est : $idVal");
      return idVal;
    } else {
      print(globalIndic);
      print(idIndic);
      print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }

  dynamic retrouverFormule(dynamic selectedValue) async {
    int index = globalFormule.indexOf(selectedValue);
    if (index != -1 && index < idFormul.length) {
      print(globalFormule);
      print(idFormul);
      idFormule = idFormul[index];
      print("son identifiant est : $idFormule");
      return idFormule;
    } else {
      print(globalFormule);
      print(idFormul);
      print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }

  Future<void> _updateData(int id, int idCalcul, BuildContext context) async {
    try {
      final response =
          await Supabase.instance.client.from('indicateur').update({
        'id_indicalcule': idCalcul,
      }).match({'id_indic': id});

      if (response == null) {
        const message =
            "L'ajout de l'indicateur primaire a été effectué avec succès";
        await Future.delayed(const Duration(milliseconds: 15));
        ScaffoldMessenger.of(context)
            .showSnackBar(showSnackBar("Succès", message, Colors.green));
      } else {
        const message = "Erreur lors de la modification des données";
        await Future.delayed(const Duration(milliseconds: 15));
        ScaffoldMessenger.of(context)
            .showSnackBar(showSnackBar("Echec", message, Colors.red));
      }
    } catch (e) {
      print("Erreur: $e");
      const message = "Une erreur s'est produite";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Erreur", message, Colors.red));
    }
  }

  Future<void> _updateDataFormule(
      int id, int idForm, BuildContext context) async {
    try {
      final response =
          await Supabase.instance.client.from('indicalcule').update({
        'id_formule': idForm,
      }).match({'id_indicalcule': id});

      if (response == null) {
        const message = "L'ajout de la formule a été effectué avec succès";
        await Future.delayed(const Duration(milliseconds: 15));
        ScaffoldMessenger.of(context)
            .showSnackBar(showSnackBar("Succès", message, Colors.green));
        getData();
      } else {
        const message = "Erreur lors de la modification des données";
        await Future.delayed(const Duration(milliseconds: 15));
        ScaffoldMessenger.of(context)
            .showSnackBar(showSnackBar("Echec", message, Colors.red));
      }
    } catch (e) {
      print("Erreur: $e");
      const message = "Une erreur s'est produite";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Erreur", message, Colors.red));
    }
  }

  Future<void> _deleteData(int id) async {
    try {
      final response = await Supabase.instance.client
          .from('indicateur')
          .update({
        'id_indicalcule': null
      }) // Mise à jour de la colonne id_termino avec null
          .match({'id_indic': id});

      if (response == null) {
        const message =
            "Suppression de l'indicateur primaire a été effectué avec succès";
        ScaffoldMessenger.of(context)
            .showSnackBar(showSnackBar("Succès", message, Colors.green));
      } else {
        const message =
            "Erreur lors de la suppression de la valeur dans la colonne id_termino";
        ScaffoldMessenger.of(context).showSnackBar(
          showSnackBar("Echec", message, Colors.red),
        );
      }
    } catch (error) {
      print("Erreur: $error");
      const message =
          "Une erreur s'est produite lors de la suppression de la valeur";
      ScaffoldMessenger.of(context).showSnackBar(
        showSnackBar("Erreur", message, Colors.red),
      );
    }
  }

  Future<dynamic> getData() async {
    final responseIndicalcule =
        await Supabase.instance.client.from('indicalcule').select();
    final responseFormule =
        await Supabase.instance.client.from('formule').select();

    setState(() {
      formule = responseFormule;
      indicalcule = responseIndicalcule.map((indicalculeData) {
        final idIndico = indicalculeData['id_formule'];
        final nomFormul = formule.firstWhereOrNull(
            (formule) => formule['id_formule'] == idIndico)?['ref_formule'];
        return {...indicalculeData, 'nomFormule': nomFormul};
      }).toList();
    });

    // Récupérer les noms de formule
    final List<String?> formuleNames = [];
    for (final indicalculeData in indicalcule) {
      final idIndico = indicalculeData['id_formule'];
      final nomFormul = formule.firstWhereOrNull(
          (formule) => formule['id_formule'] == idIndico)?['ref_formule'];
      formuleNames.add(nomFormul);
    }
    setState(() {
      nomFormules = formuleNames;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    //Timer.periodic(const Duration(seconds:3), (Timer t) => getData());
  }

  @override
  Widget build(BuildContext context) {
    fetchidIndic().then((ids) {
      idIndic = ids;
    }).catchError((error) {});

    fetchFormule().then((refs) {
      //  print(refs);
      globalFormule = refs;
    }).catchError((error) {});

    fetchidFormule().then((ids) {
      idFormul = ids;
    }).catchError((error) {});

    return Center(
      child: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _dataStream1,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Erreur lors du chargement des données'));
          } else {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final nomFormule =
                    nomFormules.isNotEmpty ? nomFormules[index] : null;
                return FutureBuilder<List<Map<String, dynamic>>>(
                  future: Supabase.instance.client
                      .from('indicateur')
                      .select()
                      .eq('id_indicalcule', data[index]['id_indicalcule'])
                      .order('id_indic', ascending: true),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Text('Erreur lors du chargement des données'));
                    } else {
                      final indicValeur = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            color: Colors.purple[400],
                          ),
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Indication de calcule: ${data[index]['ref_indicalcule']}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                      onPressed: () async {

                                        fetchIndic().then((refs) {
                                          //  print(refs);
                                          globalIndic = refs;
                                        }).catchError((error) {});

                                        final result = await showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text(
                                                "Ajout d'indicateur primaire a ${data[index]['ref_indicalcule']}",
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: indicateurColor)),
                                            content: SizedBox(
                                              width: 400,
                                              height: 150,
                                              child: Form(
                                                autovalidateMode:
                                                    AutovalidateMode.disabled,
                                                key: _formKey,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    ComboPara(
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return "Svp veuillez selectionner un indicateur";
                                                          }
                                                          return null;
                                                        },
                                                        listValeur: globalIndic,
                                                        labeltext:
                                                            "Selection d' indicateur primaire",
                                                        onChanged: (dynamic
                                                            selectedValue) {
                                                          retrouverIndicateur(
                                                              selectedValue);
                                                        }),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context, false);
                                                },
                                                child: const Text('Annuler',
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  () async {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      Navigator.pop(
                                                          context, true);
                                                    }
                                                  }();
                                                },
                                                child: const Text('Enregistrer',
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ],
                                          ),
                                        );
                                        if (result == true) {
                                          // ignore: use_build_context_synchronously
                                          await _updateData(
                                              idVal,
                                              data[index]['id_indicalcule'],
                                              context);
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.add_to_photos_rounded,
                                        color: Colors.white,
                                      ))
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CardMoule(
                                    width: 1000,
                                    height: 130,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: indicValeur.length,
                                      itemBuilder: (context1, subIndex) {
                                        return CardMoule(
                                          color: Colors.purple[100],
                                          width: 250,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                            'Reférence : ',
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Text(
                                                            '${indicValeur[subIndex]['ref_indic']}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                        .purple[
                                                                    700],
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text('Intitulé',
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        SizedBox(
                                                          width: 180,
                                                          child: Text(
                                                              '${indicValeur[subIndex]['intitule_indic']}',
                                                              style: const TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                IconButton(
                                                  icon:
                                                      const Icon(Icons.delete),
                                                  onPressed: () async {
                                                    print(
                                                        "l'id de suppression est ${indicValeur[subIndex]['id_indic']}");
                                                    final confirmed =
                                                        await showDialog(
                                                      context: context1,
                                                      builder: (context1) =>
                                                          AlertDialog(
                                                        title: const Text(
                                                            "Confirmation de la suppression",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .red)),
                                                        content: Text(
                                                            "Êtes-vous sûr de vouloir supprimer ${indicValeur[subIndex]['ref_indic']} ?",
                                                            style: const TextStyle(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                        context1)
                                                                    .pop(false),
                                                            child: const Text(
                                                                "Non",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                )),
                                                          ),
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                        context1)
                                                                    .pop(true),
                                                            child: const Text(
                                                                "Oui",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                    if (confirmed == true) {
                                                      await _deleteData(
                                                          indicValeur[subIndex]
                                                              ['id_indic']);
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  CardMoule(
                                      width: 200,
                                      height: 130,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            buttonIcon(
                                                width: 150,
                                                height: 30,
                                                size: 14,
                                                tap: () async {
                                                  final result =
                                                      await showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                      title: Text(
                                                          "Modification de la formule de ${data[index]['ref_indicalcule']} et $nomFormule ",
                                                          style: const TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  indicateurColor)),
                                                      content: SizedBox(
                                                        width: 400,
                                                        height: 150,
                                                        child: Form(
                                                          autovalidateMode:
                                                              AutovalidateMode
                                                                  .disabled,
                                                          key: _formKey,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .stretch,
                                                            children: [
                                                              ComboPara(
                                                                  validator:
                                                                      (value) {
                                                                    if (value ==
                                                                            null ||
                                                                        value
                                                                            .isEmpty) {
                                                                      return "Svp veuillez selectionner la formule";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  listValeur:
                                                                      globalFormule,
                                                                  labeltext:
                                                                      "Selection de la formule",
                                                                  onChanged:
                                                                      (dynamic
                                                                          selectedValue) {
                                                                    retrouverFormule(
                                                                        selectedValue);
                                                                  }),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            print(data[index][
                                                                'id_indicalcule']);
                                                            print(idFormule);
                                                            //print(nomFormule);
                                                            Navigator.pop(
                                                                context, false);
                                                          },
                                                          child: const Text(
                                                              'Annuler',
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            print(data[index][
                                                                'id_indicalcule']);
                                                            print(idFormule);
                                                            //print(nomFormule);
                                                            () async {
                                                              if (_formKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                Navigator.pop(
                                                                    context,
                                                                    true);
                                                              }
                                                            }();
                                                          },
                                                          child: const Text(
                                                              'Enregistrer',
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                  if (result == true) {
                                                    // ignore: use_build_context_synchronously
                                                    await _updateDataFormule(
                                                        data[index]
                                                            ['id_indicalcule'],
                                                        idFormule,
                                                        context);
                                                  }
                                                },
                                                backgroundColor:
                                                    indicateurColor,
                                                text: "Ajout Formule",
                                                color: Colors.white,
                                                icon: Icons.calculate),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text('Formule de la liste',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.purple)),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                                nomFormule ?? "Aucun Opérateur",
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red)),
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
