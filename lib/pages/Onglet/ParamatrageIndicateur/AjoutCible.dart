import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perf_energie/widgets/Composant/Help.dart';
import 'package:perf_energie/widgets/Composant/TextCall.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//  AJOUT DES CIBLES PAR INDICATEURS ///////////////////////////////////////////////////////////////////////////////////////////////////////

class IndicParametrage extends StatefulWidget {
  const IndicParametrage({super.key});
  @override
  State<IndicParametrage> createState() => _IndicParametrageState();
}

class _IndicParametrageState extends State<IndicParametrage> {
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> unite = [];
  List<Map<String, dynamic>> indicateur = [];
  List<String?> nomUnites = []; // Ajout de la variable d'état pour stocker les noms de formule

  final _dataStream = Supabase.instance.client
      .from('indicateur')
      .stream(primaryKey: ['id_indic']).eq('id_type','1').order('id_indic', ascending: true);

  Future<void> _updateData(int id, String cible, BuildContext context) async {
    try {
      final response =
          await Supabase.instance.client.from('indicateur').update({
        'date_cible': DateTime.now().toIso8601String(),
        'cible_indic': cible,
      }).match({'id_indic': id});

      if (response == null) {
        const message = "La cible de l'indicateur a été modifié avec succès";
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


  Future<dynamic> getData() async {
    final responseIndicateur =
        await Supabase.instance.client.from('indicateur').select();
    final responseUnite =
        await Supabase.instance.client.from('unite').select();

    setState(() {
      unite = responseUnite;
      indicateur = responseIndicateur.map((indicateurData) {
        final idIndico = indicateurData['id_unite'];
        final nomUnit = unite
            .firstWhereOrNull((unite) => unite['id_unite'] == idIndico)?['abr_unite'];
        return {
          ...indicateurData,
          'nomUnite': nomUnit
        };
      }).toList();
    });

    // Récupérer les noms de formule
    final List<String?> uniteNames = [];
    for (final indicateurData in indicateur) {
      final idIndico = indicateurData['id_unite'];
      final nomUnit = unite
          .firstWhereOrNull((unite) => unite['id_unite'] == idIndico)?['abr_unite'];
      uniteNames.add(nomUnit);
    }
    setState(() {
      nomUnites = uniteNames;
    });
  }


  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<List<Map<dynamic, dynamic>>>(
        stream: _dataStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final nomUnite = nomUnites.isNotEmpty ? nomUnites[index] : null;
              final cibleController =
                  TextEditingController(text: data[index]['cible_indic']);
              return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(data[index]['ref_indic'],
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: indicateurColor)),
                    Row(
                      children: [
                        Text(data[index]['cible_indic'],
                            style: const TextStyle(
                            color: Colors.red,
                                fontSize: 17, fontWeight: FontWeight.w600)),
                      const SizedBox(width: 5,),
                         Text(nomUnite?? "---",
                        style: const TextStyle(
                          color: Colors.red,
                            fontSize: 17, fontWeight: FontWeight.w600)) //METTRE L'UNITE ICI APRES
                      ],
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data[index]['intitule_indic'],
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Modifié le ",
                            style: TextStyle(
                            //color: Colors.red,
                                fontSize: 15, fontWeight: FontWeight.w800)),
                          Text(data[index]['date_cible'],
                        style: const TextStyle(
                          //color: Colors.red,
                            fontSize: 15, fontWeight: FontWeight.w600))  
                      ],
                    ),
                  ],
                ),
                onTap: () async {
                  final result = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                          "Modification de la cible de l'indicateur",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: indicateurColor)),
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
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      double.tryParse(value) == null) {
                                    return "Svp veuillez entrer un nombre valide";
                                  }
                                  return null;
                                },
                                hintText: "",
                                label: "Cible de cet indicateur",
                                controller: cibleController,
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
                        data[index]['id_indic'], cibleController.text, context);
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
