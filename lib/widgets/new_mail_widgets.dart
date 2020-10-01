import 'package:flutter/material.dart';

import '../constants/constants.dart';

mixin NewMailWidgets {
  Widget mailDataFields(TextEditingController fieldController, String label,
      IconData prefixIcon, Function(String) validateField,
      {IconData suffixIcon,
      Function suffixTiconPressed,
      TextCapitalization textCapitalization = TextCapitalization.sentences}) {
    return TextFormField(
      controller: fieldController,
      keyboardType: TextInputType.text,
      autofocus: false,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelText: label,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIconButton(suffixIcon, suffixTiconPressed),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      validator: (value) => validateField(value),
    );
  }

  Widget mailMultiLineFields(
      TextEditingController fieldController, String label,
      {IconData prefixIcon,
      TextInputAction textInputAction = TextInputAction.newline,
      TextCapitalization textCapitalization = TextCapitalization.sentences}) {
    return TextFormField(
      controller: fieldController,
      textAlignVertical: TextAlignVertical.top,
      textInputAction: TextInputAction.newline,
      textCapitalization: TextCapitalization.sentences,
      minLines: null,
      maxLines: null,
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget suffixIconButton(IconData icon, Function suffixFunction) {
    return IconButton(
      icon: Icon(icon),
      onPressed: () => suffixFunction,
    );
  }

  emailFailed(BuildContext context, onPressed) {
    alertReturn(context, Image.asset(Const.failGif), 'Falha ao enviar', [
      FlatButton(
        child: Text("Descartar"),
        onPressed: onPressed,
      )
    ]);
  }

  Future<bool> leaveMailPage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Deseja cancelar e-mail?"),
        content: Text('ATENÇÃO: Todos os dados serão perdidos !'),
        actions: <Widget>[
          FlatButton(
            child: Text('SIM'),
            onPressed: () => Navigator.pop(context, true),
          ),
          FlatButton(
            child: Text('NÃO'),
            onPressed: () => Navigator.pop(context, false),
          ),
        ],
      ),
    );
  }

  emailSent(BuildContext context, onPressed) {
    alertReturn(
        context, Image.asset(Const.sucssessGif), 'Enviado com sucesso !', [
      FlatButton(
        child: Text("Novo"),
        onPressed: onPressed,
      ),
      FlatButton(
        child: Text("Sair"),
        onPressed: () {
          Navigator.pop(context, true);
        },
      )
    ]);
  }

  Future<Widget> alertReturn(
      BuildContext context, Image img, String txt, List<Widget> actions) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(txt),
        content: img,
        actions: actions,
      ),
    );
  }
}
