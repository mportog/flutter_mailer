import 'package:flutter/material.dart';
import 'package:fluttermailer/constants/base.dart';
import 'package:fluttermailer/constants/constants.dart';
import 'package:fluttermailer/screens/new_mail.dart';
import 'package:fluttermailer/services/shared_prefs.dart';
import 'package:fluttermailer/widgets/login_widget.dart';

import '../services/email.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with LoginWidgets, Base {
  bool _isHidden = true;
  bool _keepLogged = false;
  InternalCache prefs = InternalCache();
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: true,
          top: true,
          child: Container(
            padding: EdgeInsets.only(
                top: 80.0, right: 20.0, left: 20.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                imageLogo(),
                verticalSeparator(max: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Mailer ",
                      style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment(0, 0),
                          child: Icon(Icons.local_post_office),
                        ),
                        Positioned(
                          right: -1,
                          child: Icon(
                            Icons.flight_takeoff,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                verticalSeparator(max: 2),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.black12, width: 1)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Column(
                      children: <Widget>[
                        verticalSeparator(),
                        buildTextField(
                          "E-mail",
                          _userController,
                          isHidden: false,
                        ),
                        verticalSeparator(max: 2),
                        buildTextField("Senha", _passController,
                            isHidden: _isHidden,
                            toggleVisibility: () => _toggleVisibility()),
                        verticalSeparator(max: 2),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text('Manter sessão ativa'),
                              Checkbox(
                                  value: _keepLogged,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      _keepLogged = newValue;
                                    });
                                  }),
                            ],
                          ),
                        ),
                        verticalSeparator(max: 2),
                        buildButtonContainer(() => _loginPressed(false)),
                        SizedBox(
                          height: 5.0,
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSeparator(),
                buildAnonymousLabel(() => _loginPressed(true))
              ],
            ),
          ),
        ),
      ),
    );
  }

  _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  _loginPressed(bool anonymous) async {
    if (isBusy) return;
    String user;
    String pass;
    int smtp = 0;
    if (anonymous) {
      user = Const.defaultUserMail;
      pass = Const.defaultUserPass;
      smtp = 1;
    } else {
      if (_keepLogged) {
        prefs.setPreferences(user, pass);
      }
      user = _userController.text;
      pass = _passController.text;
      user.contains('@') ? smtp = findServer(user.trim()) : smtp = 0;
    }
    if (smtp > 0) {
      EmailSingleton(username: user, password: pass, smtp: smtp);
      _animLogin(user, pass);
    } else {
      setState(() => _userController.text = 'Digite um e-mail válido !');
      isBusy = false;
    }
  }

  Future _animLogin(String usr, String pss) async {
    await Future.delayed(Duration(
      seconds: 1,
    ));
    isBusy = false;
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewMail()),
    );
  }
}
