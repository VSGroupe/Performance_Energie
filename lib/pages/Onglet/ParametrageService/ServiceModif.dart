import 'package:flutter/material.dart';
import 'package:perf_energie/main.dart';
import 'package:perf_energie/widgets/Composant/Help.dart';
import 'package:perf_energie/widgets/Composant/TextCall.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


//  FONCTION DE REMPLISSAGES DE LA LISTE DES COMBOS  ///////////////////////////////////////////////////////////////////////////////////////////////////////

Future<List> fetchGroup() async {
  final response = await Supabase.instance.client.from('group').select();
  List<dynamic> refs = response.map((group) => group['nom_group']).toList();
  return refs;
}

Future<List> fetchPays() async {
  final response = await Supabase.instance.client.from('pays').select();
  List<dynamic> refs = response.map((pays) => pays['ref_pays']).toList();
  return refs;
}


//  MISE A JOUR DES GROUPES  ///////////////////////////////////////////////////////////////////////////////////////////////////////

class GroupParametrage extends StatefulWidget {
  const GroupParametrage({super.key});
  @override
  State<GroupParametrage> createState() => _GroupParametrageState();
}

class _GroupParametrageState extends State<GroupParametrage> {
  final _formKey = GlobalKey<FormState>();
  final _dataStream = Supabase.instance.client
      .from('group')
      .stream(primaryKey: ['id_group']).order('id_group', ascending: true);

  Future<void> _deleteData(int id) async {
    final response = await Supabase.instance.client
        .from('group')
        .delete()
        .match({'id_group': id});

    if (response == null) {
      const message = "Le groupe a été supprimé avec succès";
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
      int id, String nom, String email, String contact, BuildContext context) async {
    final response = await Supabase.instance.client.from('group').update({
      'nom_group': nom,
      'email_group': email,
      'contact_group': contact,

    }).match({'id_group': id});

    if (response == null) {
      const message = "Le groupe a été modifié avec succès";
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
              final nomController =
                  TextEditingController(text: data[index]['nom_group']);
              final emailController =
                  TextEditingController(text: data[index]['email_group']);
              final contactController =
                  TextEditingController(text: data[index]['contact_group']);
              return ListTile(
                title: Text(data[index]['nom_group'],
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data[index]['email_group'],
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                    Text(data[index]['contact_group'],
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600))
                  ],
                ),
                        
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
                            "Êtes-vous sûr de vouloir supprimer le groupe ${data[index]['nom_group']} ?",
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
                      await _deleteData(data[index]['id_group']);
                    }
                  },
                ),
                onTap: () async {
                  final result = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Modification du groupe",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal)),
                      content: SizedBox(
                        width: 400,
                        height: 200,
                        child: Form(
                          autovalidateMode: AutovalidateMode.disabled,
                          key: _formKey,
                          child: Column(
                            children: [
                              textfieldIcon(
                                autofocus: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez entrer le nom du groupe";
                                  }
                                  return null;
                                },
                                hintText: "",
                                label: "Nom du groupe",
                                controller: nomController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              textfieldIcon(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez entrer le Email du groupe";
                                  }
                                  return null;
                                },
                                hintText: "",
                                label: "Email du groupe",
                                controller: emailController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              textfieldIcon(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez entrer le contact du groupe";
                                  }
                                  return null;
                                },
                                hintText: "",
                                label: "Contact du group",
                                controller: contactController,
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
                    await _updateData(data[index]['id_group'], nomController.text,
                        emailController.text, contactController.text, context);
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


//  MISE A JOUR DES FILIERES ///////////////////////////////////////////////////////////////////////////////////////////////////////

class FiliereParametrage extends StatefulWidget {
  const FiliereParametrage({super.key});
  @override
  State<FiliereParametrage> createState() => _FiliereParametrageState();
}

class _FiliereParametrageState extends State<FiliereParametrage> {
  final _formKey = GlobalKey<FormState>();
  final _dataStream = Supabase.instance.client
      .from('filiere')
      .stream(primaryKey: ['id_filiere']).order('id_filiere', ascending: true);
  List<dynamic> idGroup = [];
  List<dynamic> idRef = [];
  late int idgroupValeur;

  Future<List> fetchidGroup() async {
    final response =
        await Supabase.instance.client.from('group').select('id_group,nom_group');
    List<dynamic> ids = response.map((group) => group['id_group']).toList();
    return ids;
  }

  Future<dynamic> retrouverValeur(dynamic selectedValue) async {
    int index = globalgroup.indexOf(selectedValue);
    if (index != -1 && index < idGroup.length) {
      idgroupValeur = idGroup[index];
      print("son identifiant est : $idgroupValeur");
      return idgroupValeur;
    } else {
      print("NULL");
      return null;
    }
  }

  Future<void> _deleteData(int id) async {
    final response = await Supabase.instance.client
        .from('filiere')
        .delete()
        .match({'id_filiere': id});

    if (response == null) {
      const message = "La filière a été supprimée avec succès";
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

  Future<void> _updateData(int id,  String nom, int idgroupValeur,
      BuildContext context) async {
    final response = await Supabase.instance.client.from('filiere').update({
      'nom_filiere': nom,
      'id_group': idgroupValeur,
    }).match({'id_filiere': id});

    if (response == null) {
      const message = "La filière a été modifiée avec succès";
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
    fetchGroup().then((refs) {
      //  print(refs);
      globalgroup = refs;
    }).catchError((error) {});
    fetchidGroup().then((ids) {
      idGroup = ids;
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
              final nomController =
                  TextEditingController(text: data[index]['nom_filiere']);
              return ListTile(
                title: Text(data[index]['nom_filiere'],
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo)),
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
                            "Êtes-vous sûr de vouloir supprimer la filière ${data[index]['nom_filiere']} ?",
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
                      await _deleteData(data[index]['id_filiere']);
                    }
                  },
                ),
                onTap: () async {
                  var filiereData = data[index]['id_group'] as int?;
                  print("l'id du group dans la filiere est $filiereData");
                  final responseGroup =
                      await Supabase.instance.client.from('group').select();
                  var refgroup = responseGroup.firstWhere(
                      (group) => group['id_group'] == filiereData)['nom_group'];

                  // ignore: use_build_context_synchronously
                  final result = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Modification de la filière",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo)),
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
                                    return "Svp veuillez entrer le nom de la filière";
                                  }
                                  return null;
                                },
                                hintText: "",
                                label: "Nom de la filière",
                                controller: nomController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const SizedBox(height: 20),
                              ComboActualise(
                                  initValue: refgroup,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Svp veuillez sélectionner le groupe";
                                    }
                                    return null;
                                  },
                                  listValeur: globalgroup,
                                  labeltext: "Sélection du groupe",
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
                                            " Le groupe actuel de cette filière est : ",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.italic,
                                        )),
                                    TextSpan(
                                        text: refgroup,
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
                        data[index]['id_filiere'],
                        nomController.text,
                        idgroupValeur,
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

//  MISE A JOUR DES PAYS ///////////////////////////////////////////////////////////////////////////////////////////////////////

class PaysParametrage extends StatefulWidget {
  const PaysParametrage({super.key});
  @override
  State<PaysParametrage> createState() => _PaysParametrageState();
}

class _PaysParametrageState extends State<PaysParametrage> {
  final _formKey = GlobalKey<FormState>();
  final _dataStream = Supabase.instance.client
      .from('pays')
      .stream(primaryKey: ['id_pays']).order('id_pays', ascending: true);

  Future<void> _deleteData(int id) async {
    final response = await Supabase.instance.client
        .from('pays')
        .delete()
        .match({'id_pays': id});

    if (response == null) {
      const message = "Le pays a été supprimé avec succès";
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
      int id, String ref, String identic, BuildContext context) async {
    final response = await Supabase.instance.client.from('pays').update({
      'ref_pays': ref,
      'identification': identic,
    }).match({'id_pays': id});

    if (response == null) {
      const message = "Le pays a été modifié avec succès";
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
                  TextEditingController(text: data[index]['ref_pays']);
              final idenController =
                  TextEditingController(text: data[index]['identification']);
              return ListTile(
                title: Text(data[index]['ref_pays'],
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange)),
                subtitle: Text(data[index]['identification'],
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
                            "Êtes-vous sûr de vouloir supprimer le pays ${data[index]['ref_pays']} ?",
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
                      await _deleteData(data[index]['id_pays']);
                    }
                  },
                ),
                onTap: () async {
                  final result = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Modification du pays",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange)),
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
                                    return "Svp veuillez entrer le nom du pays";
                                  }
                                  return null;
                                },
                                hintText: "",
                                label: "Nom du pays",
                                controller: refController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              textfieldIcon(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez entrer son identification";
                                  }
                                  return null;
                                },
                                hintText: "",
                                label: "N° Identification du pays",
                                controller: idenController,
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
                    await _updateData(data[index]['id_pays'], refController.text,
                        idenController.text, context);
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


//  MISE A JOUR DES VILLES ///////////////////////////////////////////////////////////////////////////////////////////////////////

class VilleParametrage extends StatefulWidget {
  const VilleParametrage({super.key});
  @override
  State<VilleParametrage> createState() => _VilleParametrageState();
}

class _VilleParametrageState extends State<VilleParametrage> {
  final _formKey = GlobalKey<FormState>();
  final _dataStream = Supabase.instance.client
      .from('ville')
      .stream(primaryKey: ['id_ville']).order('id_ville', ascending: true);
  List<dynamic> idPays = [];
  List<dynamic> idRef = [];
  late int idpaysValeur;

  Future<List> fetchidPays() async {
    final response =
        await Supabase.instance.client.from('pays').select('id_pays,ref_pays');
    List<dynamic> ids = response.map((pays) => pays['id_pays']).toList();
    return ids;
  }

  Future<dynamic> retrouverValeur(dynamic selectedValue) async {
    int index = globalpays.indexOf(selectedValue);
    if (index != -1 && index < idPays.length) {
      idpaysValeur = idPays[index];
      print("son identifiant est : $idpaysValeur");
      return idpaysValeur;
    } else {
      print("NULL");
      return null;
    }
  }

  Future<void> _deleteData(int id) async {
    final response = await Supabase.instance.client
        .from('ville')
        .delete()
        .match({'id_ville': id});

    if (response == null) {
      const message = "La ville a été supprimée avec succès";
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

  Future<void> _updateData(int id, String ref, int idaxeValeur,
      BuildContext context) async {
    final response = await Supabase.instance.client.from('ville').update({
      'ref_ville': ref,
      'id_pays': idpaysValeur,
    }).match({'id_ville': id});

    if (response == null) {
      const message = "La ville a été modifiée avec succès";
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
    fetchPays().then((refs) {
      //  print(refs);
      globalpays = refs;
    }).catchError((error) {});
    fetchidPays().then((ids) {
      idPays = ids;
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
                  TextEditingController(text: data[index]['ref_ville']);
              return ListTile(
                title: Text(data[index]['ref_ville'],
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
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
                            "Êtes-vous sûr de vouloir supprimer la ville ${data[index]['ref_ville']} ?",
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
                      await _deleteData(data[index]['id_ville']);
                    }
                  },
                ),
                onTap: () async {
                  var villeData = data[index]['id_pays'] as int?;
                  print("l'id du pays dans la ville est $villeData");
                  final responsePays =
                      await Supabase.instance.client.from('pays').select();
                  var refpays = responsePays.firstWhere(
                      (pays) => pays['id_pays'] == villeData)['ref_pays'];

                  // ignore: use_build_context_synchronously
                  final result = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Modification de la ville",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red)),
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
                                    return "Svp veuillez entrer le nom de la ville";
                                  }
                                  return null;
                                },
                                hintText: "",
                                label: "Nom de la ville",
                                controller: refController,
                              ),
                              const SizedBox(height: 20),
                              ComboActualise(
                                  initValue: refpays,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Svp veuillez sélectionner le pays";
                                    }
                                    return null;
                                  },
                                  listValeur: globalpays,
                                  labeltext: "Sélection du pays",
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
                                            " Le pays actuel de cette ville est : ",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.italic,
                                        )),
                                    TextSpan(
                                        text: refpays,
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
                        data[index]['id_ville'],
                        refController.text,
                        idpaysValeur,
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
