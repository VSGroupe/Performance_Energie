import 'package:flutter/material.dart';
import 'package:perf_energie/main.dart';
import 'package:perf_energie/widgets/Composant/Help.dart';
import 'package:perf_energie/widgets/Composant/TextCall.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//  FONCTION DE REMPLISSAGES DE LA LISTE DES COMBOS  ///////////////////////////////////////////////////////////////////////////////////////////////////////

Future<List> fetchAxes() async {
  final response = await Supabase.instance.client.from('axe').select();
  List<dynamic> refs = response.map((axe) => axe['ref_axe']).toList();
  return refs;
}

Future<List> fetchEnjeux() async {
  final response = await Supabase.instance.client.from('enjeu').select();
  List<dynamic> refs = response.map((enjeu) => enjeu['ref_enjeu']).toList();
  return refs;
}

//  MISE A JOUR DES AXES  ///////////////////////////////////////////////////////////////////////////////////////////////////////

class AxeParametrage extends StatefulWidget {
  const AxeParametrage({super.key});
  @override
  State<AxeParametrage> createState() => _AxeParametrageState();
}

class _AxeParametrageState extends State<AxeParametrage> {
  final _formKey = GlobalKey<FormState>();
  final _dataStream = Supabase.instance.client
      .from('axe')
      .stream(primaryKey: ['id_axe']).order('id_axe', ascending: true);

  Future<void> _deleteData(int id) async {
    final response = await Supabase.instance.client
        .from('axe')
        .delete()
        .match({'id_axe': id});

    if (response == null) {
      const message = "L'axe a été supprimé avec succès";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Succès", message, Colors.green));
    } else {
      const message = "Erreur lors de la suppression des données";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
  }

  Future<void> _updateData(
      int id, String ref, String nom, BuildContext context) async {
    final response = await Supabase.instance.client.from('axe').update({
      'ref_axe': ref,
      'nom_axe': nom,
    }).match({'id_axe': id});

    if (response == null) {
      const message = "L'axe a été modifié avec succès";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Succès", message, Colors.green));
    } else {
      const message = "Erreur lors de la modification des données";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _dataStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final refController =
                  TextEditingController(text: data[index]['ref_axe']);
              final nomController =
                  TextEditingController(text: data[index]['nom_axe']);
              return ListTile(
                title: Text(data[index]['ref_axe'],
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: primaryColor)),
                subtitle: Text(data[index]['nom_axe'],
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600)),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    final confirmed = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Confirmation de la suppression",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red)),
                        content: Text(
                            "Êtes-vous sûr de vouloir supprimer l'${data[index]['ref_axe']} ?",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600)),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("Non",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("Oui",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                    );
                    if (confirmed == true) {
                      await _deleteData(data[index]['id_axe']);
                    }
                  },
                ),
                onTap: () async {
                  final result = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Modification de l'axe",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: axeColor)),
                      content: SizedBox(
                        width: 400,
                        height: 150,
                        child: Form(
                          autovalidateMode: AutovalidateMode.disabled,
                          key: _formKey,
                          child: Column(
                            children: [
                              textfieldIcon(
                                autofocus: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez entrer la reférence de l'axe";
                                  }
                                  return null;
                                },
                                hintText: "",
                                label: "Reférence de l'axe",
                                controller: refController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              textfieldIcon(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez entrer le nom de l'axe";
                                  }
                                  return null;
                                },
                                hintText: "",
                                label: "Définition de l'axe",
                                controller: nomController,
                              ),
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
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                        ),
                        TextButton(
                          onPressed: () {
                            () async {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pop(context, true);
                              }
                            }();
                          },
                          child: const Text('Enregistrer',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  );
                  if (result == true) {
                    // ignore: use_build_context_synchronously
                    await _updateData(data[index]['id_axe'], refController.text,
                        nomController.text, context);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}

//  MISE A JOUR DES ENJEUX  ///////////////////////////////////////////////////////////////////////////////////////////////////////

class EnjeuParametrage extends StatefulWidget {
  const EnjeuParametrage({super.key});
  @override
  State<EnjeuParametrage> createState() => _EnjeuParametrageState();
}

class _EnjeuParametrageState extends State<EnjeuParametrage> {
  final _formKey = GlobalKey<FormState>();
  final _dataStream = Supabase.instance.client
      .from('enjeu')
      .stream(primaryKey: ['id_enjeu']).order('id_enjeu', ascending: true);
  List<dynamic> idAxes = [];
  List<dynamic> idRef = [];
  late int idaxeValeur;

  Future<List> fetchidAxe() async {
    final response =
        await Supabase.instance.client.from('axe').select('id_axe,ref_axe');
    List<dynamic> ids = response.map((axe) => axe['id_axe']).toList();
    return ids;
  }

  Future<dynamic> retrouverValeur(dynamic selectedValue) async {
    int index = globalAxes.indexOf(selectedValue);
    if (index != -1 && index < idAxes.length) {
      idaxeValeur = idAxes[index];
      print("son identifiant est : $idaxeValeur");
      return idaxeValeur;
    } else {
      print("NULL");
      return null;
    }
  }

  Future<void> _deleteData(int id) async {
    final response = await Supabase.instance.client
        .from('enjeu')
        .delete()
        .match({'id_enjeu': id});

    if (response == null) {
      const message = "L'enjeu a été supprimé avec succès";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Succès", message, Colors.green));
    } else {
      const message = "Erreur lors de la suppression des données";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
  }

  Future<void> _updateData(int id, String ref, String nom, int idaxeValeur,
      BuildContext context) async {
    final response = await Supabase.instance.client.from('enjeu').update({
      'ref_enjeu': ref,
      'nom_enjeu': nom,
      'id_axe': idaxeValeur,
    }).match({'id_enjeu': id});

    if (response == null) {
      const message = "L'enjeu a été modifié avec succès";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Succès", message, Colors.green));
    } else {
      const message = "Erreur lors de la modification des données";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchAxes().then((refs) {
      //  print(refs);
      globalAxes = refs;
    }).catchError((error) {});
    fetchidAxe().then((ids) {
      idAxes = ids;
    }).catchError((error) {});
    return Center(
      child: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _dataStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final refController =
                  TextEditingController(text: data[index]['ref_enjeu']);
              final nomController =
                  TextEditingController(text: data[index]['nom_enjeu']);
              return ListTile(
                title: Text(data[index]['ref_enjeu'],
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: enjeuColor)),
                subtitle: Text(data[index]['nom_enjeu'],
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600)),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    final confirmed = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Confirmation de la suppression",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red)),
                        content: Text(
                            "Êtes-vous sûr de vouloir supprimer l'${data[index]['ref_enjeu']} ?",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600)),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("Non",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("Oui",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                    );
                    if (confirmed == true) {
                      await _deleteData(data[index]['id_enjeu']);
                    }
                  },
                ),
                onTap: () async {
                  var enjeuData = data[index]['id_axe'] as int?;
                  print("l'id de l'axe dans l'enjeu est $enjeuData");
                  final responseAxe =
                      await Supabase.instance.client.from('axe').select();
                  var refaxe = responseAxe.firstWhere(
                      (axe) => axe['id_axe'] == enjeuData)['ref_axe'];

                  // ignore: use_build_context_synchronously
                  final result = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Modification de l'enjeu",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: enjeuColor)),
                      content: SizedBox(
                        width: 500,
                        height: 300,
                        child: Form(
                          autovalidateMode: AutovalidateMode.disabled,
                          key: _formKey,
                          child: Column(
                            children: [
                              textfieldIcon(
                                autofocus: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez entrer la reférence de l'enjeu";
                                  }
                                  return null;
                                },
                                hintText: "",
                                label: "Reférence de l'enjeu",
                                controller: refController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              textfieldIcon(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez entrer le nom de l'enjeu";
                                  }
                                  return null;
                                },
                                hintText: "",
                                label: "Définition de l'enjeu",
                                controller: nomController,
                              ),
                              const SizedBox(height: 20),
                              ComboActualise(
                                  initValue: refaxe,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Svp veuillez selectionner la réference de son axe";
                                    }
                                    return null;
                                  },
                                  listValeur: globalAxes,
                                  labeltext: "Selection de l'axe",
                                  onChanged: (selectedValue) async {
                                    retrouverValeur(selectedValue);
                                  }),
                              const SizedBox(
                                height: 15,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                        text:
                                            " L'axe actuel de cet enjeu est : ",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.italic,
                                        )),
                                    TextSpan(
                                        text: refaxe,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                        ))
                                  ],
                                ),
                              ),
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
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                        ),
                        TextButton(
                          onPressed: () {
                            () async {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pop(context, true);
                              }
                            }();
                          },
                          child: const Text('Enregistrer',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  );
                  if (result == true) {
                    // ignore: use_build_context_synchronously
                    await _updateData(
                        data[index]['id_enjeu'],
                        refController.text,
                        nomController.text,
                        idaxeValeur,
                        context);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}


//  MISE A JOUR DES PROCESSUS  ///////////////////////////////////////////////////////////////////////////////////////////////////////

class ProcessusParametrage extends StatefulWidget {
  const ProcessusParametrage({super.key});
  @override
  State<ProcessusParametrage> createState() => _ProcessusParametrageState();
}

class _ProcessusParametrageState extends State<ProcessusParametrage> {
  final _formKey = GlobalKey<FormState>();
  final _dataStream = Supabase.instance.client
      .from('processus')
      .stream(primaryKey: ['id_process']).order('id_process', ascending: true);
  List<dynamic> idEnjeux = [];
  List<dynamic> idRef = [];
  late int idenjeuValeur;

  Future<List> fetchidEnjeux() async {
    final response = await Supabase.instance.client
        .from('enjeu')
        .select('id_enjeu,ref_enjeu');
    List<dynamic> ids = response.map((enjeu) => enjeu['id_enjeu']).toList();
    return ids;
  }

  Future<dynamic> retrouverValeur(dynamic selectedValue) async {
    int index = globalEnjeux.indexOf(selectedValue);
    if (index != -1 && index < idEnjeux.length) {
      idenjeuValeur = idEnjeux[index];
      print("son identifiant est : $idenjeuValeur");
      return idenjeuValeur;
    } else {
      print("NULL");
      return null;
    }
  }

  Future<void> _deleteData(int id) async {
    final response = await Supabase.instance.client
        .from('processus')
        .delete()
        .match({'id_process': id});

    if (response == null) {
      const message = "Le processsus a été supprimé avec succès";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Succès", message, Colors.green));
    } else {
      const message = "Erreur lors de la suppression des données";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
  }

  Future<void> _updateData(int id, String ref, String nom, int idenjeuValeur,
      BuildContext context) async {
    final response = await Supabase.instance.client.from('processus').update({
      'ref_process': ref,
      'nom_process': nom,
      'id_enjeu': idenjeuValeur,
    }).match({'id_process': id});

    if (response == null) {
      const message = "Le processus a été modifié avec succès";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Succès", message, Colors.green));
    } else {
      const message = "Erreur lors de la modification des données";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchidEnjeux().then((ids) {
      idEnjeux = ids;
    }).catchError((error) {});

    fetchEnjeux().then((refs) {
      //  print(refs);
      globalEnjeux = refs;
    }).catchError((error) {});

    return Center(
      child: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _dataStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final refController =
                  TextEditingController(text: data[index]['ref_process']);
              final nomController =
                  TextEditingController(text: data[index]['nom_process']);
              return ListTile(
                title: Text(data[index]['ref_process'],
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: processusColor)),
                subtitle: Text(data[index]['nom_process'],
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600)),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    final confirmed = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Confirmation de la suppression",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red)),
                        content: Text(
                            "Êtes-vous sûr de vouloir supprimer du ${data[index]['ref_process']} ?",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600)),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("Non",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("Oui",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                    );
                    if (confirmed == true) {
                      await _deleteData(data[index]['id_process']);
                    }
                  },
                ),
                onTap: () async {
                  var processData = data[index]['id_enjeu'] as int?;
                  print("l'id de l'enjeu dans le processus est $processData");

                  final responseEnjeu =
                      await Supabase.instance.client.from('enjeu').select();
                  var refenjeu = responseEnjeu.firstWhere(
                      (axe) => axe['id_enjeu'] == processData)['ref_enjeu'];

                  // ignore: use_build_context_synchronously
                  final result = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Modification du processus",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: processusColor)),
                      content: SizedBox(
                        width: 500,
                        height: 300,
                        child: Form(
                          autovalidateMode: AutovalidateMode.disabled,
                          key: _formKey,
                          child: Column(
                            children: [
                              textfieldIcon(
                                autofocus: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez entrer la reférence du processus";
                                  }
                                  return null;
                                },
                                hintText: "",
                                label: "Reférence du processus",
                                controller: refController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              textfieldIcon(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez entrer le nom du processus";
                                  }
                                  return null;
                                },
                                hintText: "",
                                label: "Définition du processus",
                                controller: nomController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ComboActualise(
                                initValue: refenjeu,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez sélectionner la réference de son enjeu";
                                  }
                                  return null;
                                },
                                listValeur: globalEnjeux,
                                labeltext: "Sélection de l'enjeu",
                                onChanged: (selectedValue) async {
                                  retrouverValeur(selectedValue);
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              RichText(
                                  text: TextSpan(children: [
                                const TextSpan(
                                    text:
                                        " L'enjeu actuel de cet processus est : ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                    )),
                                TextSpan(
                                    text: refenjeu,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ))
                              ]))
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
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                        ),
                        TextButton(
                          onPressed: () {
                            () async {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pop(context, true);
                              }
                            }();
                          },
                          child: const Text('Enregistrer',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  );
                  if (result == true) {
                    // ignore: use_build_context_synchronously
                    await _updateData(
                        data[index]['id_process'],
                        refController.text,
                        nomController.text,
                        idenjeuValeur,
                        context);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}


//  MISE A JOUR DES CRITERES  ///////////////////////////////////////////////////////////////////////////////////////////////////////

class CritereParametrage extends StatefulWidget {
  const CritereParametrage({super.key});
  @override
  State<CritereParametrage> createState() => _CritereParametrageState();
}

class _CritereParametrageState extends State<CritereParametrage> {
  final _formKey = GlobalKey<FormState>();
  final _dataStream = Supabase.instance.client
      .from('critere')
      .stream(primaryKey: ['id_critere']).order('id_critere', ascending: true);
  List<dynamic> idEnjeux = [];
  List<dynamic> idRef = [];
  late int idenjeuValeur;
  late String refenjeuInitial =
      ''; // Variable pour stocker la référence de l'axe

  Future<List> fetchidEnjeux() async {
    final response = await Supabase.instance.client
        .from('enjeu')
        .select('id_enjeu,ref_enjeu');
    List<dynamic> ids = response.map((enjeu) => enjeu['id_enjeu']).toList();
    return ids;
  }

  Future<dynamic> retrouverValeur(dynamic selectedValue) async {
    int index = globalEnjeux.indexOf(selectedValue);
    if (index != -1 && index < idEnjeux.length) {
      idenjeuValeur = idEnjeux[index];
      print("son identifiant est : $idenjeuValeur");
      return idenjeuValeur;
    } else {
      print("NULL");
      return null;
    }
  }

  Future<void> _deleteData(int id) async {
    final response = await Supabase.instance.client
        .from('critere')
        .delete()
        .match({'id_critere': id});

    if (response == null) {
      const message = "Le critère a été supprimé avec succès";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Succès", message, Colors.green));
    } else {
      const message = "Erreur lors de la suppression des données";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
  }

  Future<void> _updateData(int id, String ref, String nom, int idenjeuValeur,
      BuildContext context) async {
    final response = await Supabase.instance.client.from('critere').update({
      'ref_critere': ref,
      'nom_critere': nom,
      'id_enjeu': idenjeuValeur,
    }).match({'id_critere': id});

    if (response == null) {
      const message = "Le critère a été modifié avec succès";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Succès", message, Colors.green));
    } else {
      const message = "Erreur lors de la modification des données";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchidEnjeux().then((ids) {
      idEnjeux = ids;
    }).catchError((error) {});

    fetchEnjeux().then((refs) {
      //  print(refs);
      globalEnjeux = refs;
    }).catchError((error) {});

    return Center(
      child: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _dataStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final refController =
                  TextEditingController(text: data[index]['ref_critere']);
              final nomController =
                  TextEditingController(text: data[index]['nom_critere']);
              return ListTile(
                title: Text(data[index]['ref_critere'],
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: critereColor)),
                subtitle: Text(data[index]['nom_critere'],
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600)),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    final confirmed = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Confirmation de la suppression",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red)),
                        content: Text(
                            "Êtes-vous sûr de vouloir supprimer du ${data[index]['ref_critere']} ?",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600)),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("Non",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("Oui",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                    );
                    if (confirmed == true) {
                      await _deleteData(data[index]['id_critere']);
                    }
                  },
                ),
                onTap: () async {
                  var critereData = data[index]['id_enjeu'] as int?;
                  print("l'id de l'enjeu dans le critère est $critereData");

                  final responseEnjeu =
                      await Supabase.instance.client.from('enjeu').select();
                  var refenjeu = responseEnjeu.firstWhere(
                      (axe) => axe['id_enjeu'] == critereData)['ref_enjeu'];

                  // ignore: use_build_context_synchronously
                  final result = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Modification du critère",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: critereColor)),
                      content: SizedBox(
                        width: 500,
                        height: 300,
                        child: Form(
                          autovalidateMode: AutovalidateMode.disabled,
                          key: _formKey,
                          child: Column(
                            children: [
                              textfieldIcon(
                                autofocus: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez entrer la reférence du critère";
                                  }
                                  return null;
                                },
                                hintText: "",
                                label: "Reférence du critère",
                                controller: refController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              textfieldIcon(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez entrer le nom du critère";
                                  }
                                  return null;
                                },
                                hintText: "",
                                label: "Définition du critère",
                                controller: nomController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ComboActualise(
                                initValue: refenjeu,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez sélectionner la réference de son enjeu";
                                  }
                                  return null;
                                },
                                listValeur: globalEnjeux,
                                labeltext: "Sélection de l'enjeu",
                                onChanged: (selectedValue) async {
                                  retrouverValeur(selectedValue);
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              RichText(
                                  text: TextSpan(children: [
                                const TextSpan(
                                    text:
                                        " L'enjeu actuel de ce critère est : ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                    )),
                                TextSpan(
                                    text: refenjeu,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ))
                              ]))
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
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                        ),
                        TextButton(
                          onPressed: () {
                            () async {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pop(context, true);
                              }
                            }();
                          },
                          child: const Text('Enregistrer',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  );
                  if (result == true) {
                    // ignore: use_build_context_synchronously
                    await _updateData(
                        data[index]['id_critere'],
                        refController.text,
                        nomController.text,
                        idenjeuValeur,
                        context);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}


// AUTRES ENREGISTREMENTS //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// MISE A JOUR DE TERMINOLOGIE ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class TerminoParametrage extends StatefulWidget {
  const TerminoParametrage({super.key});
  @override
  State<TerminoParametrage> createState() => _TerminoParametrageState();
}

class _TerminoParametrageState extends State<TerminoParametrage> {
  final _formKey = GlobalKey<FormState>();
  final _dataStream = Supabase.instance.client
      .from('terminologie')
      .stream(primaryKey: ['id_termino']).order('id_termino', ascending: true);

  Future<void> _deleteData(int id) async {
    final response = await Supabase.instance.client
        .from('termino')
        .delete()
        .match({'id_termino': id});

    if (response == null) {
      const message = "La terminologie a été supprimé avec succès";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Succès", message, Colors.green));
    } else {
      const message = "Erreur lors de la suppression des données";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
  }

  Future<void> _updateData(
      int id, String ref, String nom, BuildContext context) async {
    final response =
        await Supabase.instance.client.from('terminologie').update({
      'ref_termino': ref,
      'nom_termino': nom,
    }).match({'id_termino': id});

    if (response == null) {
      const message = "La terminologie a été modifié avec succès";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Succès", message, Colors.green));
    } else {
      const message = "Erreur lors de la modification des données";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _dataStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final refController =
                  TextEditingController(text: data[index]['ref_termino']);
              final nomController =
                  TextEditingController(text: data[index]['nom_termino']);
              return ListTile(
                title: Text(data[index]['ref_termino'],
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey)),
                subtitle: Text(data[index]['nom_termino'],
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600)),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    final confirmed = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Confirmation de la suppression",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red)),
                        content: Text(
                            "Êtes-vous sûr de vouloir supprimer l'${data[index]['ref_termino']} ?",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600)),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("Non",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("Oui",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                    );
                    if (confirmed == true) {
                      await _deleteData(data[index]['id_terminologie']);
                    }
                  },
                ),
                onTap: () async {
                  final result = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Modification de la terminologie",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey)),
                      content: SizedBox(
                        width: 400,
                        height: 150,
                        child: Form(
                          autovalidateMode: AutovalidateMode.disabled,
                          key: _formKey,
                          child: Column(
                            children: [
                              textfieldIcon(
                                autofocus: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez entrer la reférence de la terminologie";
                                  }
                                  return null;
                                },
                                hintText: "",
                                label: "Reférence de la terminologie",
                                controller: refController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              textfieldIcon(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez entrer le nom de la terminologie";
                                  }
                                  return null;
                                },
                                hintText: "",
                                label: "Définition de la terminologie",
                                controller: nomController,
                              ),
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
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                        ),
                        TextButton(
                          onPressed: () {
                            () async {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pop(context, true);
                              }
                            }();
                          },
                          child: const Text('Enregistrer',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  );
                  if (result == true) {
                    // ignore: use_build_context_synchronously
                    await _updateData(data[index]['id_termino'],
                        refController.text, nomController.text, context);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}

// AUTRES ENREGISTREMENTS //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// MISE A JOUR DE UNITES ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class UniteParametrage extends StatefulWidget {
  const UniteParametrage({super.key});
  @override
  State<UniteParametrage> createState() => _UniteParametrageState();
}

class _UniteParametrageState extends State<UniteParametrage> {
  final _formKey = GlobalKey<FormState>();
  final _dataStream = Supabase.instance.client
      .from('unite')
      .stream(primaryKey: ['id_unite']).order('id_unite', ascending: true);

  Future<void> _deleteData(int id) async {
    final response = await Supabase.instance.client
        .from('unite')
        .delete()
        .match({'id_unite': id});

    if (response == null) {
      const message = "L'Unité a été supprimé avec succès";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Succès", message, Colors.green));
    } else {
      const message = "Erreur lors de la suppression des données";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
  }

  Future<void> _updateData(
      int id, String ref, String nom, BuildContext context) async {
    final response = await Supabase.instance.client.from('unite').update({
      'ref_unite': ref,
      'abr_unite': nom,
    }).match({'id_unite': id});

    if (response == null) {
      const message = "L'unité a été modifié avec succès";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Succès", message, Colors.green));
    } else {
      const message = "Erreur lors de la modification des données";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _dataStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final refController =
                  TextEditingController(text: data[index]['ref_unite']);
              final nomController =
                  TextEditingController(text: data[index]['abr_unite']);
              return ListTile(
                title: Text(data[index]['ref_unite'],
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                subtitle: Text(data[index]['abr_unite'],
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600)),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    final confirmed = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Confirmation de la suppression",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red)),
                        content: Text(
                            "Êtes-vous sûr de vouloir supprimer l'${data[index]['ref_unite']} ?",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600)),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("Non",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("Oui",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                    );
                    if (confirmed == true) {
                      await _deleteData(data[index]['id_unite']);
                    }
                  },
                ),
                onTap: () async {
                  final result = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Modification de l'unité",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      content: SizedBox(
                        width: 400,
                        height: 150,
                        child: Form(
                          autovalidateMode: AutovalidateMode.disabled,
                          key: _formKey,
                          child: Column(
                            children: [
                              textfieldIcon(
                                autofocus: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez entrer la reférence de l'unité";
                                  }
                                  return null;
                                },
                                hintText: "",
                                label: "Reférence de l'unité",
                                controller: refController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              textfieldIcon(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez entrer l'abréviation'de l'unité";
                                  }
                                  return null;
                                },
                                hintText: "",
                                label: "Abréviation de l'unité",
                                controller: nomController,
                              ),
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
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                        ),
                        TextButton(
                          onPressed: () {
                            () async {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pop(context, true);
                              }
                            }();
                          },
                          child: const Text('Enregistrer',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  );
                  if (result == true) {
                    // ignore: use_build_context_synchronously
                    await _updateData(data[index]['id_unite'],
                        refController.text, nomController.text, context);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}

// AUTRES ENREGISTREMENTS //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// MISE A JOUR DE TYPES ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class TypeParametrage extends StatefulWidget {
  const TypeParametrage({super.key});
  @override
  State<TypeParametrage> createState() => _TypeParametrageState();
}

class _TypeParametrageState extends State<TypeParametrage> {
  final _formKey = GlobalKey<FormState>();
  final _dataStream = Supabase.instance.client
      .from('type')
      .stream(primaryKey: ['id_type']).order('id_type', ascending: true);

  Future<void> _deleteData(int id) async {
    final response = await Supabase.instance.client
        .from('type')
        .delete()
        .match({'id_type': id});

    if (response == null) {
      const message = "Le type de calcul a été supprimé avec succès";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Succès", message, Colors.green));
    } else {
      const message = "Erreur lors de la suppression des données";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
  }

  Future<void> _updateData(
      int id, String ref, String nom, BuildContext context) async {
    final response = await Supabase.instance.client.from('type').update({
      'ref_type': ref,
      'nom_type': nom,
    }).match({'id_type': id});

    if (response == null) {
      const message = "Le type de calcul a été modifié avec succès";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Succès", message, Colors.green));
    } else {
      const message = "Erreur lors de la modification des données";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _dataStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final refController =
                  TextEditingController(text: data[index]['ref_type']);
              final nomController =
                  TextEditingController(text: data[index]['nom_type']);
              return ListTile(
                title: Text(data[index]['ref_type'],
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber)),
                subtitle: Text(data[index]['nom_type'],
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600)),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    final confirmed = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Confirmation de la suppression",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red)),
                        content: Text(
                            "Êtes-vous sûr de vouloir supprimer l'${data[index]['ref_type']} ?",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600)),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("Non",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("Oui",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                    );
                    if (confirmed == true) {
                      await _deleteData(data[index]['id_type']);
                    }
                  },
                ),
                onTap: () async {
                  final result = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Modification du type de calcul",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber)),
                      content: SizedBox(
                        width: 400,
                        height: 150,
                        child: Form(
                          autovalidateMode: AutovalidateMode.disabled,
                          key: _formKey,
                          child: Column(
                            children: [
                              textfieldIcon(
                                autofocus: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez entrer la reférence du type de calcul";
                                  }
                                  return null;
                                },
                                hintText: "",
                                label: "Reférence du type de calcul",
                                controller: refController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              textfieldIcon(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez entrer l'abréviation du type de calcul";
                                  }
                                  return null;
                                },
                                hintText: "",
                                label: "Abréviation du type de calcuul",
                                controller: nomController,
                              ),
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
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                        ),
                        TextButton(
                          onPressed: () {
                            () async {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pop(context, true);
                              }
                            }();
                          },
                          child: const Text('Enregistrer',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  );
                  if (result == true) {
                    // ignore: use_build_context_synchronously
                    await _updateData(data[index]['id_type'],
                        refController.text, nomController.text, context);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}

// AUTRES ENREGISTREMENTS //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// MISE A JOUR DE FORMULES ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class FormuleParametrage extends StatefulWidget {
  const FormuleParametrage({super.key});
  @override
  State<FormuleParametrage> createState() => _FormuleParametrageState();
}

class _FormuleParametrageState extends State<FormuleParametrage> {
  final _formKey = GlobalKey<FormState>();
  final _dataStream = Supabase.instance.client
      .from('formule')
      .stream(primaryKey: ['id_formule']).order('id_formule', ascending: true);

  Future<void> _deleteData(int id) async {
    final response = await Supabase.instance.client
        .from('formule')
        .delete()
        .match({'id_formule': id});

    if (response == null) {
      const message = "La formule a été supprimé avec succès";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Succès", message, Colors.green));
    } else {
      const message = "Erreur lors de la suppression des données";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
  }

  Future<void> _updateData(
      int id, String ref, String nom, BuildContext context) async {
    final response = await Supabase.instance.client.from('formule').update({
      'ref_formule': ref,
      'operation': nom,
    }).match({'id_formule': id});

    if (response == null) {
      const message = "La formule a été modifié avec succès";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Succès", message, Colors.green));
    } else {
      const message = "Erreur lors de la modification des données";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _dataStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final refController =
                  TextEditingController(text: data[index]['ref_formule']);
              final nomController =
                  TextEditingController(text: data[index]['operation']);
              return ListTile(
                title: Text(data[index]['ref_formule'],
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple)),
                subtitle: Text(data[index]['operation'],
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600)),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    final confirmed = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Confirmation de la suppression",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red)),
                        content: Text(
                            "Êtes-vous sûr de vouloir supprimer l'${data[index]['ref_formule']} ?",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600)),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("Non",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("Oui",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                    );
                    if (confirmed == true) {
                      await _deleteData(data[index]['id_formule']);
                    }
                  },
                ),
                onTap: () async {
                  final result = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Modification de la formule",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple)),
                      content: SizedBox(
                        width: 400,
                        height: 150,
                        child: Form(
                          autovalidateMode: AutovalidateMode.disabled,
                          key: _formKey,
                          child: Column(
                            children: [
                              textfieldIcon(
                                autofocus: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez entrer la reférence de la formule";
                                  }
                                  return null;
                                },
                                hintText: "",
                                label: "Reférence de la formule",
                                controller: refController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              textfieldIcon(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez entrer l'abréviation de la formule";
                                  }
                                  return null;
                                },
                                hintText: "",
                                label: "Abréviation de la formule",
                                controller: nomController,
                              ),
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
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                        ),
                        TextButton(
                          onPressed: () {
                            () async {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pop(context, true);
                              }
                            }();
                          },
                          child: const Text('Enregistrer',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  );
                  if (result == true) {
                    // ignore: use_build_context_synchronously
                    await _updateData(data[index]['id_formule'],
                        refController.text, nomController.text, context);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
