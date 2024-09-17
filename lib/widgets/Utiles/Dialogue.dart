import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:perf_energie/main.dart';
import 'package:perf_energie/widgets/Composant/Button.dart';
import 'package:perf_energie/widgets/Composant/Help.dart';
import 'package:perf_energie/widgets/Composant/TextCall.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';
import 'package:perf_energie/widgets/Constant/ImgConstant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DeleteOption extends StatefulWidget {
  final String? reference;
  final Future<void> Function() action;

  const DeleteOption({required this.action, this.reference, super.key});

  @override
  State<DeleteOption> createState() => _DeleteOptionState();
}

class _DeleteOptionState extends State<DeleteOption> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirmation de la suppression",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
      content: Text(widget.reference ?? "Êtes-vous sûr de vouloir supprimer ?",
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Non",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        ),
        TextButton(
          onPressed: () async {
            await widget.action();
          },
          child: const Text("Oui",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              )),
        ),
      ],
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MODIFICATION DE L'INDICATEUR ///////////////////////////////////////////////////////////////////////

class ModifIndicateur extends StatefulWidget {
  final int numeroText;
  final String intText;
  final String griText;
  final String refText;
  final String defText;
  final String oddText;
  final String initValueProcess;
  final String initValueCritere;
  final String initValueTermino;
  final String initValueType;
  final String initValueUnite;
  final String initValueFreq;
  final int idindic;
  List<dynamic> globalType1;
  List<dynamic> globalTermino1;
  List<dynamic> globalUnite1;
  List<dynamic> globalCritere1;
  List<dynamic> globalProcessus1;

   ModifIndicateur(
      {required this.idindic,
      required this.globalType1,
      required this.globalTermino1,
      required this.globalUnite1,
      required this.globalCritere1,
      required this.globalProcessus1,
      required this.numeroText,
      required this.intText,
      required this.griText,
      required this.refText,
      required this.defText,
      required this.oddText,
      required this.initValueProcess,
      required this.initValueCritere,
      required this.initValueTermino,
      required this.initValueType,
      required this.initValueUnite,
      required this.initValueFreq,
      super.key});

  @override
  State<ModifIndicateur> createState() => _ModifIndicateurState();
}

class _ModifIndicateurState extends State<ModifIndicateur> {
  final _formKey = GlobalKey<FormState>();
  Set<List<dynamic>> idsRec = {};
  List<dynamic> idProcess = [];
  List<dynamic> idCritere = [];
  List<dynamic> idTermino = [];
  List<dynamic> idUnite = [];
  List<dynamic> idType = [];
  late int idProcessValeur;
  late int idCritereValeur;
  late int idUniteValeur;
  late int idTypeValeur;
  late int idTerminoValeur;
  late String frequenceValeur;


  Future<Set<List>> fetchidCombo() async {
    final response1 = await Supabase.instance.client
        .from('processus')
        .select('id_process,ref_process');
    List<dynamic> idsProcess =
        response1.map((process) => process['id_process']).toList();

    final response2 = await Supabase.instance.client
        .from('terminologie')
        .select('id_termino,ref_termino');
    List<dynamic> idsTermino =
        response2.map((axe) => axe['id_termino']).toList();

    final response3 = await Supabase.instance.client
        .from('unite')
        .select('id_unite,ref_unite');
    List<dynamic> idsUnite =
        response3.map((unite) => unite['id_unite']).toList();

    final response4 =
        await Supabase.instance.client.from('type').select('id_type,ref_type');
    List<dynamic> idsType = response4.map((type) => type['id_type']).toList();

    final response5 = await Supabase.instance.client
        .from('critere')
        .select('id_critere,ref_critere');
    List<dynamic> idsCritere =
        response5.map((critere) => critere['id_critere']).toList();

    return {idsProcess, idsTermino, idsUnite, idsType, idsCritere};
  }

  Future<void> getData() async {
    Set<List> comboData = await fetchidCombo();
    List<dynamic> idsProcess = comboData.elementAt(0);
    List<dynamic> idsTermino = comboData.elementAt(1);
    List<dynamic> idsUnite = comboData.elementAt(2);
    List<dynamic> idsType = comboData.elementAt(3);
    List<dynamic> idsCritere = comboData.elementAt(4);

    idProcess = idsProcess;
    idTermino = idsTermino;
    idUnite = idsUnite;
    idType = idsType;
    idCritere = idsCritere;

    // Utilisez idsProcess comme nécessaire
    print("Processus est $idProcess"); // Cela imprime les idsProcess récupérés
    print("Terminologie est $idTermino"); // Cela imprime les idsProcess récupérés
    print("Unite est $idUnite"); // Cela imprime les idsProcess récupérés
    print("Type est $idType"); // Cela imprime les idsProcess récupérés
    print("Critere est $idCritere"); // Cela imprime les idsProcess récupérés
  }

  @override
  void initState() {
    super.initState();
    getData(); // Appel de getData() lorsque le widget est créé
  }

  dynamic retrouverProcess(dynamic selectedValue) async {
    int index = globalProcessus.indexOf(selectedValue);
    if (index != -1 && index < idProcess.length) {
      //print(globalProcessus);
      print(idProcess);
      idProcessValeur = idProcess[index];
      print("son processus est : $idProcessValeur");
      return idProcessValeur;
    } else {
      // print(globalProcessus);
      // print(idProcess);
      // print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }

  dynamic retrouverCritere(dynamic selectedValue) async {
    int index = globalCritere.indexOf(selectedValue);
    if (index != -1 && index < idCritere.length) {
      //print(globalProcessus);
      print(idCritere);
      idCritereValeur = idCritere[index];
      print("son critere est : $idCritereValeur");
      return idCritereValeur;
    } else {
      // print(globalProcessus);
      // print(idProcess);
      // print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }

  dynamic retrouverunite(dynamic selectedValue) async {
    int index = globalUnite.indexOf(selectedValue);
    if (index != -1 && index < idUnite.length) {
      print(globalUnite);
      print(idUnite);
      idUniteValeur = idUnite[index];
      print("son unite est : $idUniteValeur");
      return idUniteValeur;
    } else {
      //print(globaluniteus);
      //print(idunite);
      print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }

  dynamic retrouverType(dynamic selectedValue) async {
    int index = globalType.indexOf(selectedValue);
    if (index != -1 && index < idType.length) {
      //print(globalType);
      //print(idType);
      idTypeValeur = idType[index];
      print("son type est : $idTypeValeur");
      return idTypeValeur;
    } else {
      // print(globalTypeus);
      // print(idType);
      // print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }

  dynamic retrouverTermino(dynamic selectedValue) async {
    int index = globalTermino.indexOf(selectedValue);
    if (index != -1 && index < idTermino.length) {
      // print(globalTermino);
      //print(idTermino);
      idTerminoValeur = idTermino[index];
      print("sa terminologie est : $idTerminoValeur");
      return idTerminoValeur;
    } else {
      // print(globalTerminous);
      // print(idTermino);
      // print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }

  Future<void> _updateData(
      int id,
      String ref,
      String int,
      String odd,
      String gri,
      String def,
      String frequenceValeur,
      int idProcessValeur,
      int idCritereValeur,
      int idTerminoValeur,
      int idTypeValeur,
      int idUniteValeur,
      BuildContext context) async {
    try {
      final response =
          await Supabase.instance.client.from('indicateur').update({
        'ref_indic': ref,
        'intitule_indic': int,
        'definition_indic': def,
        'odd': odd,
        'gri': gri,
        'id_process': idProcessValeur,
        'id_critere': idCritereValeur,
        'id_termino': idTerminoValeur,
        'id_unite': idUniteValeur,
        'id_type': idTypeValeur,
        'frequence': frequenceValeur,
      }).match({'id_indic': id});

      if (response == null) {
        const message = "L'indicateur a été modifié avec succès";
        await Future.delayed(const Duration(milliseconds: 15));
        ScaffoldMessenger.of(context)
            .showSnackBar(showSnackBar("Succès", message, Colors.green));
      } else {
        print(response);
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
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {

    final numeroTextController = TextEditingController(text: widget.numeroText.toString());
    final intTextController = TextEditingController(text: widget.intText);
    final griTextController = TextEditingController(text: widget.griText);
    final refTextController = TextEditingController(text: widget.refText);
    final defTextController = TextEditingController(text: widget.defText);
    final oddTextController = TextEditingController(text: widget.oddText);

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Material(
        child: Container(
            width: 900,
            height: 715,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "MODIFICATION DE L' INDICATEUR",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Form(
                      autovalidateMode: AutovalidateMode.disabled,
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 400,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    textfieldIcon(
                                      readOnly: true,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Svp veuillez saisir le numéro de l'indicateur";
                                        }
                                        return null;
                                      },
                                      hintText: "",
                                      label: "Numéro de l'indicateur",
                                      controller: numeroTextController,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    textfieldIcon(
                                      autofocus: true,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Svp veuillez saisir l'intitulé de l'indicateur'";
                                        }
                                        return null;
                                      },
                                      hintText: "",
                                      label: "Intitulé de l'indicateur",
                                      controller: intTextController,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    textfieldIcon(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Svp veuillez saisir le gri de l'indicateur";
                                        }
                                        return null;
                                      },
                                      hintText: "",
                                      label: "Gri de l'indicateur",
                                      controller: griTextController,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ComboActualise(
                                        initValue: widget.initValueType,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Svp veuillez selectionner son type de calcul";
                                          }
                                          return null;
                                        },
                                        listValeur: widget.globalType1,
                                        labeltext:
                                            "Selection du type de calcul",
                                        onChanged: (dynamic selectedValue) {
                                          retrouverType(selectedValue);
                                        }),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ComboActualise(
                                        initValue: widget.initValueProcess,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Svp veuillez selectionner son processus";
                                          }
                                          return null;
                                        },
                                        listValeur: widget.globalProcessus1,
                                        labeltext: "Selection du processus",
                                        onChanged: (dynamic selectedValue) {
                                          retrouverProcess(selectedValue);
                                        }),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ComboActualise(
                                        initValue: widget.initValueFreq,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Svp veuillez selectionner sa fréquence";
                                          }
                                          return null;
                                        },
                                        listValeur: const [
                                          "Quotidien",
                                          "Hebdomadaire",
                                          " Mensuelle",
                                          "Trimestrielle",
                                          "Semestrielle",
                                          "Annuelle"
                                        ],
                                        labeltext: "Selection de la fréquence",
                                        onChanged: (dynamic selectedValue) {
                                          frequenceValeur = selectedValue;
                                          print(
                                              "La valeur sélectionnée est : $frequenceValeur");
                                        }),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: 400,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    textfieldIcon(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Svp veuillez saisir la réference de l'indicateur";
                                        }
                                        return null;
                                      },
                                      hintText: "",
                                      label: "Réference de l'indicateur",
                                      controller: refTextController,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    textfieldIcon(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Svp veuillez saisir la définition de l'indicateur";
                                        }
                                        return null;
                                      },
                                      hintText: "",
                                      label: "Définition l'indicateur",
                                      controller: defTextController,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    textfieldIcon(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Svp veuillez saisir l'odd'de l'indicateur";
                                        }
                                        return null;
                                      },
                                      hintText: "",
                                      label: "Odd de l'indicateur",
                                      controller: oddTextController,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ComboActualise(
                                        initValue: widget.initValueTermino,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Svp veuillez selectionner sa terminologie";
                                          }
                                          return null;
                                        },
                                        listValeur: widget.globalTermino1,
                                        labeltext:
                                            "Selection de la terminologie",
                                        onChanged: (dynamic selectedValue) {
                                          retrouverTermino(selectedValue);
                                        }),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ComboActualise(
                                        initValue: widget.initValueUnite,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Svp veuillez selectionner l'unité";
                                          }
                                          return null;
                                        },
                                        listValeur: widget.globalUnite1,
                                        labeltext: "Selection de l'unité",
                                        onChanged: (dynamic selectedValue) {
                                          retrouverunite(selectedValue);
                                        }),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ComboActualise(
                                        initValue: widget.initValueCritere,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Svp veuillez selectionner son critère";
                                          }
                                          return null;
                                        },
                                        listValeur: widget.globalCritere1,
                                        labeltext: "Selection du critère",
                                        onChanged: (dynamic selectedValue) {
                                          retrouverCritere(selectedValue);
                                        }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          buttonType(
                              tap: () async {
                                if (_formKey.currentState!.validate()) {
                                  await _updateData(
                                      widget.idindic,
                                      refTextController.text,
                                      intTextController.text,
                                      oddTextController.text,
                                      griTextController.text,
                                      defTextController.text,
                                      frequenceValeur,
                                      idProcessValeur,
                                      idCritereValeur, 
                                      idTerminoValeur,
                                      idTypeValeur,
                                      idUniteValeur,
                                      context);
                                }
                              },
                              color: Colors.purple,
                              hovercolor: Colors.purpleAccent,
                              text: "Modifier")
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MODIFICATION DU ENTITE ///////////////////////////////////////////////////////////////////////

class ModifContributeur extends StatefulWidget {
  final String civilite;
  final String nomcontribut;
  final String prenomcontribut;
  final String emailcontribut;
  final String contactcontribut;
  final String adressecontribut;
  final String fonctioncontribut;
  final String? photocontribut;
  final bool acessaudit;
  final bool acesspilotage;
  final bool acessrapport;
  final String initValueProcess;
  final String initValueRole;
  final String initValueEntite;
  final int idcontribut;
  List<dynamic> globalRole1;
  List<dynamic> globalProcessus1;
  List<dynamic> globalEntite1;

   ModifContributeur(
      {required this.globalRole1,
      required this.globalProcessus1,
      required this.globalEntite1,
      required this.idcontribut,
      required this.civilite,
      required this.nomcontribut,
      required this.prenomcontribut,
      required this.emailcontribut,
      required this.contactcontribut,
      required this.adressecontribut,
      required this.fonctioncontribut,
      required this.photocontribut,
      required this.acessaudit,
      required this.acesspilotage,
      required this.acessrapport,
      required this.initValueProcess,
      required this.initValueRole,
      required this.initValueEntite,
      super.key});

  @override
  State<ModifContributeur> createState() => _ModifContributeurState();
}

class _ModifContributeurState extends State<ModifContributeur> {
  final _formKey = GlobalKey<FormState>();
  Set<List<dynamic>> idsRec = {};
  List<dynamic> idRole = [];
  List<dynamic> idEntite = [];
  List<dynamic> idProcess = [];
  late int idRoleValeur;
  late int idEntiteValeur;
  late int idProcessValeur;
  late String civiliteValeur;
  bool isAudit = false;
  bool isPilotage = false;
  bool isRapport = false;
  String? image;


  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        image = pickedImage.path;
        print(image);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<Set<List>> fetchidCombo() async {
    final response1 =
        await Supabase.instance.client.from('role').select('id_role');
    List<dynamic> idsRole = response1.map((role) => role['id_role']).toList();

    final response2 =
        await Supabase.instance.client.from('entite').select('id_entite');
    List<dynamic> idsEntite =
        response2.map((entite) => entite['id_entite']).toList();

    final response3 =
        await Supabase.instance.client.from('processus').select('id_process');
    List<dynamic> idsProcess =
        response3.map((process) => process['id_process']).toList();

    return {idsRole, idsEntite, idsProcess};
  }

  Future<void> getData() async {
    Set<List> comboData = await fetchidCombo();
    List<dynamic> idsRole = comboData.elementAt(0);
    List<dynamic> idsEntite = comboData.elementAt(1);
    List<dynamic> idsProcess = comboData.elementAt(2);
    idRole = idsRole;
    idEntite = idsEntite;
    idProcess = idsProcess;

    print("Role est $idRole"); // Cela imprime les idsRole récupérés
    print("Entite est $idEntite"); // Cela imprime les idsEntite récupérés
    print("Processus est $idProcess"); // Cela imprime les idsProcess récupérés
  }

  @override
  void initState() {
    super.initState();
    getData(); // Appel de getData() lorsque le widget est créé
  }

  dynamic retrouverRole(dynamic selectedValue) async {
    int index = globalRole.indexOf(selectedValue);
    if (index != -1 && index < idRole.length) {
      //print(globalProcessus);
      //print(idProcess);
      idRoleValeur = idRole[index];
      print("son identifiant est : $idRoleValeur");
      return idRoleValeur;
    } else {
      // print(globalProcessus);
      // print(idProcess);
      // print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }

  dynamic retrouverEntite(dynamic selectedValue) async {
    int index = globalentite.indexOf(selectedValue);
    if (index != -1 && index < idEntite.length) {
      //print(globalUnite);
      //print(idUnite);
      idEntiteValeur = idEntite[index];
      print("son identifiant est : $idEntiteValeur");
      return idEntiteValeur;
    } else {
      // print(globaluniteus);
      // print(idunite);
      // print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }

  dynamic retrouverProcess(dynamic selectedValue) async {
    int index = globalProcessus.indexOf(selectedValue);
    if (index != -1 && index < idProcess.length) {
      //print(globalUnite);
      //print(idUnite);
      idProcessValeur = idProcess[index];
      print("son identifiant est : $idProcessValeur");
      return idProcessValeur;
    } else {
      // print(globaluniteus);
      // print(idunite);
      // print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }

  Future<void> _updateData(
      int id,
      String civilite,
      String nom,
      String prenom,
      String email,
      String contact,
      String adresse,
      String fonction,
      String photo,
      int idProcessValeur,
      int idEntiteValeur,
      int idRoleValeur,
      bool idAudit,
      bool isPilotage,
      bool isRapport,
      BuildContext context) async {
    try {
      final response =
          await Supabase.instance.client.from('contributeur').update({
        'nom_contribut': nom,
        'prenom_contribut': prenom,
        'email_contribut': email,
        'contact_contribut': contact,
        'adresse_contribut': adresse,
        'fonction_contribut': fonction,
        'photo_contribut': image,
        'civilite': civilite,
        'id_role': idRoleValeur,
        'id_entite': idEntiteValeur,
        'id_process': idProcessValeur,
        'acces_audit': isAudit,
        'acces_pilotage': isPilotage,
        'acces_rapport': isRapport,
      }).match({'id_contribut': id});

      if (response == null) {
        const message = "Le processus a été modifié avec succès";
        await Future.delayed(const Duration(milliseconds: 15));
        ScaffoldMessenger.of(context)
            .showSnackBar(showSnackBar("Succès", message, Colors.green));
      } else {
        print(response);
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
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {

    final nomTextController = TextEditingController(text: widget.nomcontribut);
    final prenomTextController =
        TextEditingController(text: widget.prenomcontribut);
    final emailTextController =
        TextEditingController(text: widget.emailcontribut);
    final contactTextController =
        TextEditingController(text: widget.contactcontribut);
    final adresseTextController =
        TextEditingController(text: widget.adressecontribut);
    final fonctionTextController =
        TextEditingController(text: widget.fonctioncontribut);

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Material(
        child: Container(
            width: 900,
            height: 850,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                  autovalidateMode: AutovalidateMode.disabled,
                  key: _formKey,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "MODIFICATION D'UN CONTRIBUTEUR",
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: widget.photocontribut == null
                                        ? Image.asset(
                                            imgAvatar,
                                            width: 70,
                                          )
                                        : Image.network(
                                            widget.photocontribut!,
                                            width: 70,
                                          )),
                                const SizedBox(
                                  height: 10,
                                ),
                                buttonIcon(
                                    tap: () {
                                      _getImage();
                                    },
                                    width: 120,
                                    text: "Photo",
                                    backgroundColor: primaryColor,
                                    color: Colors.white,
                                    icon: Icons.add),
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            SizedBox(
                              width: 300,
                              child: ComboActualise(
                                  initValue: widget.civilite,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Svp veuillez selectionner la civilité";
                                    }
                                    return null;
                                  },
                                  listValeur: const [
                                    "Monsieur",
                                    "Madame",
                                    "Mademoiselle"
                                  ],
                                  labeltext: "Civilité",
                                  onChanged: (dynamic selectedValue) {
                                    civiliteValeur = selectedValue;
                                    print(
                                        "La valeur civilite est : $civiliteValeur");
                                  }),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 900,
                          height: 350,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 400,
                                height: 350,
                                child: Column(
                                  children: [
                                    textfieldIcon(
                                        autofocus: true,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Svp veuillez saisir le nom";
                                          }
                                          return null;
                                        },
                                        controller: nomTextController,
                                        hintText: "Veillez saisir son nom",
                                        label: "Nom du contributeur"),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    textfieldIcon(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Svp veuillez saisir les prénom";
                                          }
                                          return null;
                                        },
                                        controller: prenomTextController,
                                        hintText: "Veillez saisir ses prénoms ",
                                        label: "Prénoms du contributeur"),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    textfieldIcon(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Svp veuillez saisir le Email";
                                          }
                                          return null;
                                        },
                                        controller: emailTextController,
                                        hintText: "Veillez saisir son Email",
                                        label: "Email du contributeur"),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ComboActualise(
                                        initValue: widget.initValueRole,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Svp veuillez selectionner son niveau d'accès";
                                          }
                                          return null;
                                        },
                                        listValeur: widget.globalRole1,
                                        labeltext:
                                            "Selection du niveau d'accès",
                                        onChanged: (selectedValue) async {
                                          retrouverRole(selectedValue);
                                        }),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: 400,
                                height: 350,
                                child: Column(
                                  children: [
                                    textfieldIcon(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Svp veuillez saisir le contact";
                                          }
                                          return null;
                                        },
                                        controller: contactTextController,
                                        hintText: "Veillez saisir son contact",
                                        label: "Contact du contributeur"),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    textfieldIcon(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Svp veuillez saisir l'adresse";
                                          }
                                          return null;
                                        },
                                        controller: adresseTextController,
                                        hintText: "Son lieu d'habitation",
                                        label: "Domiciliation du contributeur"),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    textfieldIcon(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Svp veuillez saisir la fonstion";
                                          }
                                          return null;
                                        },
                                        controller: fonctionTextController,
                                        hintText: "Son poste dans la structure",
                                        label: "Fonction du contributeur"),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ComboActualise(
                                        initValue: widget.initValueEntite,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Svp veuillez selectionner son entité de service";
                                          }
                                          return null;
                                        },
                                        listValeur: widget.globalEntite1,
                                        labeltext: "Selection de l'entité",
                                        onChanged: (selectedValue) async {
                                          retrouverEntite(selectedValue);
                                        }),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 500,
                          height: 100,
                          child: ComboActualise(
                              initValue: widget.initValueProcess,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Svp veuillez selectionner son processus";
                                }
                                return null;
                              },
                              listValeur: widget.globalProcessus1,
                              labeltext: "Selection du processus",
                              onChanged: (selectedValue) async {
                                retrouverProcess(selectedValue);
                              }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 600,
                          height: 50,
                          child: Row(
                            children: [
                              Expanded(
                                child: CheckboxListTile(
                                  title: const Text('Accès Audit'),
                                  value: widget.acessaudit,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isAudit = value ?? false;
                                      print("Audit $value");
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: CheckboxListTile(
                                  title: const Text('Accès Pilotage'),
                                  value: widget.acesspilotage,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      print("Pilotage $value");
                                      isPilotage = value ?? false;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: CheckboxListTile(
                                  title: const Text('Accès Rapport'),
                                  value: widget.acessrapport,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      print("Rapport $value");
                                      isRapport = value ?? false;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        buttonType(
                            tap: () async {
                              if (_formKey.currentState!.validate()) {
                                await _updateData(
                                    widget.idcontribut,
                                    civiliteValeur,
                                    nomTextController.text,
                                    prenomTextController.text,
                                    emailTextController.text,
                                    contactTextController.text,
                                    adresseTextController.text,
                                    fonctionTextController.text,
                                    image!,
                                    idProcessValeur,
                                    idEntiteValeur,
                                    idRoleValeur,
                                    isAudit,
                                    isPilotage,
                                    isRapport,
                                    context); // Correction : await pour attendre la fin de l'exécution de la fonction
                              }
                            },
                            color: Colors.amber,
                            hovercolor: Colors.amberAccent,
                            text: "Modifier")
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MODIFICATION D'ENTITE///////////////////////////////////////////////////////////////////////

class ModifEntite extends StatefulWidget {
  final String nomentite;
  final String abrentite;
  final String emailentite;
  final String contactentite;
  final String initValueFiliale;
  final String initValueVille;
  final int identite;
  List<dynamic> globalFilile1;
  List<dynamic> globalVile1;

   ModifEntite(
      {required this.globalFilile1,
      required this.globalVile1,
      required this.identite,
      required this.nomentite,
      required this.abrentite,
      required this.emailentite,
      required this.contactentite,
      required this.initValueFiliale,
      required this.initValueVille,
      super.key});

  @override
  State<ModifEntite> createState() => _ModifEntiteState();
}

class _ModifEntiteState extends State<ModifEntite> {
  final _formKey = GlobalKey<FormState>();
  Set<List<dynamic>> idsRec = {};
  List<dynamic> idFiliale = [];
  List<dynamic> idVille = [];
  late int idFilialeValeur;
  late int idVilleValeur;

  Future<Set<List>> fetchidCombo() async {
    final response1 =
        await Supabase.instance.client.from('filiale').select('id_filiale');
    List<dynamic> idsFiliale =
        response1.map((filiale) => filiale['id_filiale']).toList();

    final response2 =
        await Supabase.instance.client.from('ville').select('id_ville');
    List<dynamic> idsVille =
        response2.map((ville) => ville['id_ville']).toList();

    return {idsFiliale, idsVille};
  }

  Future<void> getData() async {
    Set<List> comboData = await fetchidCombo();
    List<dynamic> idsFiliale = comboData.elementAt(0);
    List<dynamic> idsVille = comboData.elementAt(1);
    idFiliale = idsFiliale;
    idVille = idsVille;

    print("filiaile est $idFiliale"); // Cela imprime les idsRole récupérés
    print("ville est $idVille"); // Cela imprime les idsEntite récupérés
  }

  @override
  void initState() {
    super.initState();
    getData(); // Appel de getData() lorsque le widget est créé
  }

  dynamic retrouverFiliale(dynamic selectedValue) async {
    int index = globalFiliale.indexOf(selectedValue);
    if (index != -1 && index < idFiliale.length) {
      //print(globalFiliale);
      //print(idProcess);
      idFilialeValeur = idFiliale[index];
      print("son identifiant est : $idFilialeValeur");
      return idFilialeValeur;
    } else {
      // print(globalFiliale);
      // print(idProcess);
      // print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }

  dynamic retrouverVille(dynamic selectedValue) async {
    int index = globalVille.indexOf(selectedValue);
    if (index != -1 && index < idVille.length) {
      //print(globalVille);
      //print(idVille);
      idVilleValeur = idVille[index];
      print("son identifiant est : $idVilleValeur");
      return idVilleValeur;
    } else {
      // print(globalVille);
      // print(idVille);
      // print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }

  Future<void> _updateData(
      int id,
      String nom,
      String abr,
      String email,
      String contact,
      int idFilialeValeur,
      int idVilleValeur,
      BuildContext context) async {
    try {
      final response = await Supabase.instance.client.from('entite').update({
        'nom_entite': nom,
        'abr_entite': abr,
        'email_entite': email,
        'contact_entite': contact,
        'id_filiale': idFilialeValeur,
        'id_ville': idVilleValeur,
      }).match({'id_entite': id});

      if (response == null) {
        const message = "L'entité a été modifiée avec succès";
        await Future.delayed(const Duration(milliseconds: 15));
        ScaffoldMessenger.of(context)
            .showSnackBar(showSnackBar("Succès", message, Colors.green));
      } else {
        print(response);
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
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    
    final nomTextController = TextEditingController(text: widget.nomentite);
    final abrTextController = TextEditingController(text: widget.abrentite);
    final emailTextController = TextEditingController(text: widget.emailentite);
    final contactTextController =
        TextEditingController(text: widget.contactentite);

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Material(
        child: Container(
            width: 600,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                  autovalidateMode: AutovalidateMode.disabled,
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "MODIFICATION D'UNE ENTITE",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: 500,
                        child: Column(
                          children: [
                            textfieldIcon(
                                autofocus: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez saisir le nom de l'entité";
                                  }
                                  return null;
                                },
                                controller: nomTextController,
                                hintText: "Veillez saisir le nom de l'entité",
                                label: "Nom de l'entités"),
                            const SizedBox(
                              height: 10,
                            ),
                            textfieldIcon(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez saisir l'abréviation de l'entité";
                                  }
                                  return null;
                                },
                                controller: abrTextController,
                                hintText:
                                    "Veillez saisir l'abréviation de l'entité",
                                label: "Abréviation de l'Entité"),
                            const SizedBox(
                              height: 10,
                            ),
                            textfieldIcon(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez saisir le Email de l'entité";
                                  }
                                  return null;
                                },
                                controller: emailTextController,
                                hintText:
                                    "veuillez saisir le Email de l'entité",
                                label: "Email de l'entité"),
                            const SizedBox(
                              height: 10,
                            ),
                            textfieldIcon(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez saisir le contact de l'entité";
                                  }
                                  return null;
                                },
                                controller: contactTextController,
                                hintText:
                                    "Veillez saisir le contact de l'entité",
                                label: "Contact de l'Entité"),
                            const SizedBox(
                              height: 10,
                            ),
                            ComboActualise(
                                initValue: widget.initValueFiliale,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez selectionner la filiale de l'entité";
                                  }
                                  return null;
                                },
                                listValeur: widget.globalFilile1,
                                labeltext: "Selection de la filiale",
                                onChanged: (selectedValue) async {
                                  retrouverFiliale(selectedValue);
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                            ComboActualise(
                                initValue: widget.initValueVille,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez selectionner la ville de l'entité";
                                  }
                                  return null;
                                },
                                listValeur: widget.globalVile1,
                                labeltext: "Selection de la ville",
                                onChanged: (selectedValue) async {
                                  retrouverVille(selectedValue);
                                }),
                            const SizedBox(
                              height: 20,
                            ),
                            buttonType(
                                tap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await _updateData(
                                        widget.identite,
                                        nomTextController.text,
                                        abrTextController.text,
                                        emailTextController.text,
                                        contactTextController.text,
                                        idFilialeValeur,
                                        idVilleValeur,
                                        context); // Correction : await pour attendre la fin de l'exécution de la fonction
                                  }
                                },
                                color: Colors.blue,
                                hovercolor: Colors.blueAccent,
                                text: "Modifier")
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MODIFICATION DE FILIALE ///////////////////////////////////////////////////////////////////////

class ModifFiliale extends StatefulWidget {
  final String nomfiliale;
  final String emailfiliale;
  final String contactfiliale;
  final String initValueFiliere;
  final String? logoFiliale;
  final int idfiliale;
  List<dynamic> globalFiliere1;

  ModifFiliale(
      {required this.globalFiliere1,
      required this.idfiliale,
      required this.nomfiliale,
      required this.emailfiliale,
      required this.contactfiliale,
      required this.logoFiliale,
      required this.initValueFiliere,
      super.key});

  @override
  State<ModifFiliale> createState() => _ModifFilialeState();
}

class _ModifFilialeState extends State<ModifFiliale> {
  final _formKey = GlobalKey<FormState>();
  Set<List<dynamic>> idsRec = {};
  List<dynamic> idFiliere = [];
  late int idfiliereValeur;
  String? image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        image = pickedImage.path;
        print(image);
      } else {
        print('No image selected.');
      }
    });
  }

   @override
  void initState() {
    super.initState();

  }

  Future<List> fetchidFiliere() async {
    final response =
        await Supabase.instance.client.from('filiere').select('id_filiere');
    List<dynamic> ids =
        response.map((filiere) => filiere['id_filiere']).toList();
    return ids;
  }

  dynamic retrouverFiliere(dynamic selectedValue) async {
    int index = globalFiliere.indexOf(selectedValue);
    if (index != -1 && index < idFiliere.length) {
      print(globalFiliere);
      print(idFiliere);
      idfiliereValeur = idFiliere[index];
      print("son identifiant est : $idfiliereValeur");
      return idfiliereValeur;
    } else {
      print(globalFiliere);
      print(idFiliere);
      print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }

  Future<void> _updateData(int id, String nom, String email, String contact,
      int idFiliereValeur, String? image, BuildContext context) async {
    try {
      final response = await Supabase.instance.client.from('filiale').update({
        'nom_filiale': nom,
        'email_filiale': email,
        'contact_filiale': contact,
        'id_filiere': idFiliereValeur,
        'logo_filiale': image!,
      }).match({'id_filiale': id});

      if (response == null) {
        const message = "La filiale a été modifiée avec succès";
        await Future.delayed(const Duration(milliseconds: 15));
        ScaffoldMessenger.of(context)
            .showSnackBar(showSnackBar("Succès", message, Colors.green));
      } else {
        print(response);
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
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) { 

    fetchidFiliere().then((ids) {
      idFiliere = ids;
    }).catchError((error) {});

    final nomTextController = TextEditingController(text: widget.nomfiliale);
    final emailTextController =
        TextEditingController(text: widget.emailfiliale);
    final contactTextController =
        TextEditingController(text: widget.contactfiliale);

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Material(
        child: Container(
            width: 600,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                  autovalidateMode: AutovalidateMode.disabled,
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "MODIFICATION D'UNE NOUVELLE FILIALE",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              widget.logoFiliale == null
                                  ? Image.asset(
                                      imgAvatar,
                                      width: 70,
                                    )
                                  : Image.network(
                                      widget.logoFiliale!,
                                      width: 70,
                                    ),
                              const SizedBox(
                                height: 10,
                              ),
                              buttonIcon(
                                  tap: () {
                                    _getImage();
                                  },
                                  width: 120,
                                  text: "Logo",
                                  backgroundColor: primaryColor,
                                  color: Colors.white,
                                  icon: Icons.add),
                            ],
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          SizedBox(
                              width: 300,
                              child: ComboActualise(
                                  initValue: widget.initValueFiliere,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Svp veuillez selectionner la filière";
                                    }
                                    return null;
                                  },
                                  listValeur: widget.globalFiliere1,
                                  labeltext: "Selection de la filière",
                                  onChanged: (dynamic selectedValue) {
                                    retrouverFiliere(selectedValue);
                                  })),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 500,
                        child: Column(
                          children: [
                            textfieldIcon(
                                autofocus: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez saisir le nom de la filiale";
                                  }
                                  return null;
                                },
                                hintText: "Veillez saisir le nom de la filiale",
                                label: "Nom Filiale",
                                controller: nomTextController),
                            const SizedBox(
                              height: 10,
                            ),
                            textfieldIcon(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez saisir le Email de la filiale";
                                  }
                                  return null;
                                },
                                hintText:
                                    "Veillez saisir le Email de la filiale",
                                label: "Email de la filiale",
                                controller: emailTextController),
                            const SizedBox(
                              height: 10,
                            ),
                            textfieldIcon(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez saisir le contact de la filiale";
                                  }
                                  return null;
                                },
                                hintText:
                                    "Veillez saisir le contact de la filiale",
                                label: "Contact de la filiale",
                                controller: contactTextController),
                            const SizedBox(
                              height: 20,
                            ),
                            buttonType(
                                tap: () async {
                                  print("erreur");
                                  if (_formKey.currentState!.validate()) {
                                    await _updateData(
                                        widget.idfiliale,
                                        nomTextController.text,
                                        emailTextController.text,
                                        contactTextController.text,
                                        idfiliereValeur,
                                        image!,
                                        context); // Correction : await pour attendre la fin de l'exécution de la fonction
                                  }
                                },
                                color: Colors.green,
                                hovercolor: Colors.greenAccent,
                                text: "Modifier")
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
