import 'package:flutter/material.dart';
import 'package:fluttermailer/constants/base.dart';
import '../constants/constants.dart';

mixin LoginWidgets {
  Widget imageLogo() {
    return Image.asset(
      Const.defaultLogo,
      height: 120,
      fit: BoxFit.fitHeight,
    );
  }

  Widget buildTextField(String hintText, TextEditingController fieldController,
      {Function toggleVisibility, bool isHidden}) {
    return TextField(
      enabled: !Base().isBusy,
      controller: fieldController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        prefixIcon: hintText == "E-mail" ? Icon(Icons.email) : Icon(Icons.lock),
        suffixIcon: hintText == "Senha"
            ? IconButton(
                onPressed: toggleVisibility,
                icon: isHidden
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
              )
            : null,
      ),
      obscureText: hintText == "Senha" ? isHidden : false,
    );
  }

  Widget buildButtonContainer(loginPressed) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: BorderSide(color: Colors.black12, width: 1)),
      onPressed: loginPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            'LOGIN',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
          SizedBox(
            height: 50,
            width: 20,
          ),
        ],
      ),
      color: Colors.deepOrangeAccent,
      elevation: 5,
      textColor: Colors.white,
    );
  }

  Widget buildAnonymousLabel(onPressed) {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Não quer se identificar?"),
            SizedBox(
              width: 10.0,
            ),
            FlatButton(
              child: Text(
                "MODO ANÔNIMO",
                style: TextStyle(
                  color: Const.primarySwatch,
                ),
              ),
              onPressed: onPressed,
            )
          ],
        ),
      ),
    );
  }

  int findServer(String username) {
    var provider = username.split('@');
    var server = provider[1];

    if (server.contains('hotmail') ||
        server.contains('live') ||
        server.contains('outlook')) return 2;
    if (server.contains('yahoo')) return 3;
    if (server.contains('mailgun')) return 4;
    if (server.contains('qq')) return 5;
    if (server.contains('gmail')) return 1;
    return 0;
  }
}
