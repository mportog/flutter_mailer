import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttermailer/constants/base.dart';
import 'package:fluttermailer/services/email.dart';
import 'package:fluttermailer/services/shared_prefs.dart';
import 'package:fluttermailer/widgets/new_mail_widgets.dart';
import 'package:mailer/mailer.dart';

import '../services/email.dart';

class NewMail extends StatefulWidget {
  @override
  _NewMailState createState() => _NewMailState();
}

class _NewMailState extends State<NewMail>
    with NewMailWidgets, Base, InternalCache {
  final _to = TextEditingController();
  final _copy = TextEditingController();
  final _hiddenCopy = TextEditingController();
  final _ass = TextEditingController();
  final _body = TextEditingController();

  List<String> attachment = <String>[];
  List<String> to = [];
  List<String> contact = [];
  Attachment attach;

  ScrollController _hideButtonController;
  var _isVisible;

  @override
  void dispose() {
    _to.dispose();
    _copy.dispose();
    _hiddenCopy.dispose();

    _ass.dispose();
    _body.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    _isVisible = true;
    _hideButtonController = new ScrollController();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible == true) {
          setState(() {
            _isVisible = false;
          });
        }
      } else {
        if (_hideButtonController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (_isVisible == false) {
            setState(() {
              _isVisible = true;
            });
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => leaveMailPage(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Novo E-mail'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.restore), onPressed: () => _clearFields()),
            SizedBox(
              width: 10,
            ),
            IconButton(icon: Icon(Icons.send), onPressed: () => _sendEmail()),
          ],
        ),
        body: SingleChildScrollView(
          controller: _hideButtonController,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  mailDataFields(_to, 'Para', Icons.person_add, null),
                  SizedBox(
                    height: 15,
                  ),
                  mailDataFields(_copy, 'Cc', Icons.content_copy, null),
                  SizedBox(
                    height: 15,
                  ),
                  mailDataFields(
                      _hiddenCopy, 'CcO', Icons.visibility_off, null),
                  SizedBox(
                    height: 15,
                  ),
                  mailDataFields(_ass, 'Assunto', Icons.description, null),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text('Anexo: '),
                      ),
                      Wrap(
                        children: <Widget>[
                          //! lista de chips
                        ],
                      ),
                      IconButton(
                          icon: Icon(Icons.attach_file), onPressed: () {}),
                    ],
                  ),
                  mailMultiLineFields(_body, 'Corpo'),
                  verticalSeparator(max: 5.5),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: Visibility(
          visible: _isVisible,
          child: FloatingActionButton.extended(
            icon: Icon(Icons.send),
            onPressed: () => _sendEmail(),
            label: Text('Enviar'),
          ),
        ),
      ),
    );
  }

  _sendEmail() async {
    var email = EmailSingleton();
    var retorno = await email.sendMessage(
        '${_body.text}\nEnviado por Flutter Mailer app.', _to.text, _ass.text,
        anexo: attach, comCopia: _copy.text);
    retorno ? emailSent(context, _descartar) : emailFailed(context, _descartar);
  }

  _clearFields() {
    _to.clear();
    _copy.clear();
    _ass.clear();
    _body.clear();
  }

  _descartar() {
    _clearFields();
    Navigator.pop(context, true);
  }
}
