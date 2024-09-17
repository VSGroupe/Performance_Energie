
import 'package:flutter/material.dart';
import 'package:perf_energie/widgets/GlobaleVariable/date.dart';

// MOULE D'UN WIDGET DE TEXT FLOTTANT::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class TextInfo extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontStyle? fontStyle;
  final FontWeight? weight;
  final bool? isTooltip;

  const TextInfo(
      {Key? key,
      required this.text,
      this.size,
      this.color,
      this.weight,
      this.isTooltip,
      this.fontStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isTooltip == true) {
      return Tooltip(
        message: text,
        preferBelow: false,
        child: Text(
          text,
          style: TextStyle(
              fontSize: size ?? 16,
              color: color ?? Colors.black,
              fontWeight: weight ?? FontWeight.normal,
              fontStyle: fontStyle ?? FontStyle.normal),
        ),
      );
    } else {
      return Text(
        text,
        style: TextStyle(
            fontSize: size ?? 16,
            color: color ?? Colors.black,
            fontWeight: weight ?? FontWeight.normal,
            fontStyle: fontStyle ?? FontStyle.normal),
      );
    }
  }
}

// CHAMP DE SAISIE TEXT MULTILIGNE ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class MultilineText extends StatefulWidget {
  final  TextEditingController? controller;
  final String labeltext;
  final double? labelsize;
  final Color? labelcolor;
  final double? textsize;
  final Color? textcolor;
  final int? maxLines;
  final String textButton;
  final double? sizetextButton;
  final Color? colorButton;
  final double? spaceButonTextField;
  final double? radiusborder;

  const MultilineText({
    required this.labeltext,
    this.controller,
    this.labelcolor,
    this.labelsize,
    this.textsize,
    this.textcolor,
    this.maxLines,
    required this.textButton,
    this.sizetextButton,
    this.colorButton,
    this.spaceButonTextField,
    this.radiusborder,
    Key? key, // Use Key? key instead of super.key
  }) : super(key: key);

  @override
  _MultilineTextState createState() => _MultilineTextState();
}

class _MultilineTextState extends State<MultilineText> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          style: TextStyle(
            fontSize: widget.textsize ?? 15,
            color: widget.textcolor ?? Colors.black,
          ),
          controller: _textEditingController,
          maxLines: widget.maxLines ?? 6, // Permet un nombre illimité de lignes
          decoration: InputDecoration(
            labelText: widget.labeltext,
            labelStyle: TextStyle(
              color: widget.labelcolor ?? Colors.black,
              fontSize: widget.labelsize ?? 15,
              fontWeight: FontWeight.w800,
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radiusborder ?? 8)),
          ),
        ),
        SizedBox(height: widget.spaceButonTextField ?? 16),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
                widget.colorButton ?? Colors.orangeAccent),
          ),
          onPressed: () {
            String enteredText = _textEditingController.text;
            print('Texte saisi : $enteredText');
          },
          child: Text(
            widget.textButton,
            style: TextStyle(
                color: widget.colorButton ?? Colors.white,
                fontSize: widget.sizetextButton ?? 15,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

//TEXTE FIELD DES SAISIES AVEC SUPPRESSION:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class textfield extends StatelessWidget {
  final  TextEditingController? controller;
  final String hintText;
  final String label;
  final bool? autofocus;
  final bool? readOnly;
  final double? labelsize;
  final double? hintsize;
  final IconData? preicon;
  final IconData? suficon;
  final Color? iconColor;
  final double? radiusborder;

  const textfield(
      {required this.hintText,
      required this.label,
      this.controller,
      this.autofocus,
      this.readOnly,
      this.hintsize,
      this.labelsize,
      this.preicon,
      this.suficon,
      this.iconColor,
      this.radiusborder,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autofocus ?? false,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        hintText: (hintText),
        labelText: (label),
        labelStyle: TextStyle(fontSize: labelsize ?? 15),
        hintStyle: TextStyle(fontSize: hintsize ?? 13),
        iconColor: iconColor,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusborder ?? 10)),
        prefixIcon: Icon(preicon),
        suffixIcon: GestureDetector(
          onTap: () {
            // setState(() {
            //   _obsureText = !_obsureText;
            // });
          },
          child: Icon(suficon),
        ),
      ),
    );
  }
}

//TEXTE FIELD DES SAISIES SANS SUPPRESSION :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class textfieldIcon extends StatelessWidget {

   final TextInputType? keyboardType;
  final String? Function(String?) validator;
  final  TextEditingController? controller;
  final String hintText;
  final String label;
  final bool? autofocus;
  final bool? readOnly;
  final IconData? preicon;
  final IconData? suficon;
  final Color? iconColor;
  final double? labelsize;
  final double? hintsize;
  final double? radiusborder;

  const textfieldIcon(
      {required this.hintText,
      required this.label,
       this.controller,
       this.keyboardType,
       required this.validator,
      this.autofocus,
      this.readOnly,
      this.hintsize,
      this.labelsize,
      this.preicon,
      this.suficon,
      this.iconColor,
      this.radiusborder,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType : keyboardType,
      validator: validator,
      controller: controller,
      autofocus: autofocus ?? false,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        hintText: (hintText),
        labelText: (label),
        labelStyle: TextStyle(fontSize: labelsize ?? 15),
        hintStyle: TextStyle(fontSize: hintsize ?? 13),
        iconColor: iconColor,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusborder ?? 10)),
        prefixIcon: Icon(preicon),
        suffixIcon: Icon(suficon),
      ),
    );
  }
}



//TEXTE FIELD EN FOND BLANC POUR LES RECHERCHES :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class TextFieldRech extends StatelessWidget {
  final  TextEditingController? controller;
  final VoidCallback ontap;
  final String hintText;
  final String label;
  final bool? autofocus;
  final bool? readOnly;
  final double? labelsize;
  final double? hintsize;
  final IconData? preicon;
  final IconData? suficon;
  final Color? iconColor;
  final double? radiusborder;

  const TextFieldRech({
    required this.ontap,
    required this.hintText,
    required this.label,
    this.controller,
    this.autofocus,
    this.readOnly,
    this.hintsize,
    this.labelsize,
    this.preicon,
    this.suficon,
    this.iconColor,
    this.radiusborder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlignVertical: TextAlignVertical.bottom,
      autofocus: autofocus ?? false,
      readOnly: readOnly ?? false,
      style: const TextStyle(color: Color.fromARGB(255, 1, 71, 3)), // Texte en blanc
      decoration: InputDecoration(
        hintText: hintText,
        labelText: label,
        labelStyle: TextStyle(fontSize: labelsize ?? 13, color: Colors.black,fontWeight: FontWeight.bold), // Texte en blanc
        hintStyle: TextStyle(fontSize: hintsize ?? 13, color: Colors.black), // Texte en blanc
        iconColor: iconColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusborder ?? 10),
          borderSide: const BorderSide(color: Colors.black), // Bordure en noir
        ),
        enabledBorder: OutlineInputBorder(
          // gapPadding: 2
          borderRadius: BorderRadius.circular(radiusborder ?? 10),
          borderSide: const BorderSide(color: Colors.black, width: 1), // Bordure en noir
        ),
        fillColor: Colors.white, // Fond en blanc
        filled: true,
        prefixIcon: Icon(preicon, color: iconColor?? Colors.green), // Icone en blanc
        suffixIcon: IconButton (
          iconSize: 15,
            onPressed: ontap,
            icon: (const Icon(Icons.close)) , color: iconColor?? Colors.green), // Icone en blanc
        ),
      );
  }
}


//TEXTE FIELD DES MOTS DE PASSE :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class passfield extends StatefulWidget {
  final String? Function(String?) validator;
  final  TextEditingController? controller;
  final String hintText;
  final String label;
  final double? labelsize;
  final double? hintsize;
  final IconData? preicon;
  final IconData? suficon;
  final Color? iconColor;
  final double? radiusborder;

  const passfield(
      {required this.hintText,
      required this.label,
      this.controller,
      required this.validator,
      this.preicon,
      this.suficon,
      this.hintsize,
      this.labelsize,
      this.iconColor,
      this.radiusborder,
      super.key});

  @override
  State<passfield> createState() => passfieldState();
}

class passfieldState extends State<passfield> {
  bool _obsureText = true;
  
  get validator => null;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: validator,
        obscureText: _obsureText,
        decoration: InputDecoration(
          hintText: (widget.hintText),
          labelStyle: TextStyle(fontSize: widget.labelsize ?? 15),
          hintStyle: TextStyle(fontSize: widget.hintsize ?? 13),
          labelText: (widget.label),
          iconColor: widget.iconColor,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radiusborder ?? 10)),
          suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obsureText = !_obsureText;
                });
              },
              child:
                  Icon(_obsureText ? Icons.visibility : Icons.visibility_off)),
        ));
  }
}

//COMBO DE SELECTION :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class ComboActualise extends StatefulWidget {
  final String? Function(dynamic)? validator;
  final List<dynamic> listValeur;
  final String labeltext;
  final double? labelsize;
  final double? textsize;
  final FontStyle? textStyle;
  final FontWeight? textweight;
  final Color? colorborder;
  final double? radiusborder;
  final String initValue;
  final ValueChanged<String>? onChanged; // Ajout de la fonction de rappel onChanged

  const ComboActualise({
    required this.initValue,
    this.validator,
    required this.listValeur,
    required this.labeltext,
    this.labelsize,
    this.textsize,
    this.textStyle,
    this.textweight,
    this.colorborder,
    this.radiusborder,
    this.onChanged, // Ajout de la fonction de rappel onChanged
    Key? key,
  }) : super(key: key);

  @override
  State<ComboActualise> createState() => _ComboActualiseState();
}

class _ComboActualiseState extends State<ComboActualise> {
  String selectedValue = '';


@override
void initState() {
  super.initState();
  selectedValue = widget.initValue;
}

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.colorborder ?? Colors.blue),
        ),
        labelText: widget.labeltext,
        labelStyle: TextStyle(
          fontSize: widget.labelsize ?? 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radiusborder ?? 8),
        ),
      ),
      style: TextStyle(
          fontSize: widget.textsize ?? 15,
          fontWeight: widget.textweight,
          fontStyle: widget.textStyle),
      value: selectedValue,
      onChanged: (dynamic value) {
        setState(() {
          selectedValue = value!;
          // Appel de la fonction de rappel onChanged avec la nouvelle valeur sélectionnée
          if (widget.onChanged != null) {
            widget.onChanged!(selectedValue);
            print(" la valeur dans le combo est $selectedValue");
          }
        });
      },
      items: widget.listValeur
          .map<DropdownMenuItem<dynamic>>(
            (value) => DropdownMenuItem<dynamic>(
              value: value,
              child: Text(value.toString()),
            ),
          )
          .toList(),
    );
  }
}

//COMBO DE SELECTION DU MOIS :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class comboMois extends StatefulWidget {
  const comboMois({super.key});

  @override
  _comboMoisState createState() => _comboMoisState();
}

class _comboMoisState extends State<comboMois> {
  late String selectedMonth;
  String month = getMois();
  List<String> mois = [
    "Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet",
    "Août", "Septembre", "Octobre", "Novembre", "Décembre"
  ];

  @override
  void initState() {
    super.initState();
    selectedMonth = month ;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      dropdownColor: Colors.green,
      iconSize: 30,
      value: selectedMonth,
      onChanged: (String? newValue) {
        setState(() {
          selectedMonth = newValue!;
        });
      },
      items: mois.map((String mois) {
        return DropdownMenuItem<String>(
          value: mois,
          child: Text(mois, 
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),),
        );
      }).toList(),
      underline: Container(), // Enlève le soulignement
      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white), // Icône en blanc
    );
  }
}

//COMBO DE PARAMETRAGE DES AXES, ENJEU, PROCESSUS:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class ComboPara extends StatefulWidget {
  final String? Function(dynamic)? validator;
  final List<dynamic> listValeur;
  final String labeltext;
  final double? labelsize;
  final double? textsize;
  final FontStyle? textStyle;
  final FontWeight? textweight;
  final Color? colorborder;
  final double? radiusborder;
  final ValueChanged<dynamic>? onChanged;

  const ComboPara({
     this.validator,
    required this.listValeur,
    required this.labeltext,
    this.labelsize,
    this.textsize,
    this.textStyle,
    this.textweight,
    this.colorborder,
    this.radiusborder,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<ComboPara> createState() => ComboParaState();
}

class ComboParaState extends State<ComboPara> {
  dynamic selectedValue; // Initialize selectedValue to null

  @override
  void initState() {
    super.initState();
    // Remove initialization of selectedValue here
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      validator: widget.validator,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.colorborder ?? Colors.blue),
        ),
        labelText: widget.labeltext,
        labelStyle: TextStyle(
          fontSize: widget.labelsize ?? 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radiusborder ?? 8),
        ),
      ),
      style: TextStyle(
          fontSize: widget.textsize ?? 15,
          fontWeight: widget.textweight,
          fontStyle: widget.textStyle),
      value: selectedValue,
      onChanged: (dynamic value) {
        setState(() {
          selectedValue = value;
          if (widget.onChanged != null) {
            widget.onChanged!(selectedValue);
          }
        });
      },
      items: widget.listValeur
          .map<DropdownMenuItem<dynamic>>(
            (value) => DropdownMenuItem<dynamic>(
              value: value,
              child: Text(value.toString()),
            ),
          )
          .toList(),
    );
  }
}