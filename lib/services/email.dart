import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import '../constants/constants.dart';

class EmailSingleton {
  static EmailSingleton _instance;
  factory EmailSingleton(
      {int smtp = 0,
      String username = Const.defaultUserMail,
      String password = Const.defaultUserPass}) {
    _instance ??= EmailSingleton._internalConstructor(smtp, username, password);
    return _instance;
  }
  EmailSingleton._internalConstructor(this.smtp, this.username, this.password);

  String username, password;
  int smtp;

  SmtpServer findServer(String username, String password, smtp) {
    username = username;
    var server;
    switch (smtp) {
      case 2:
        server = hotmail(username, password);
        break;
      case 3:
        server = yahoo(username, password);
        break;
      case 4:
        server = mailgun(username, password);
        break;
      case 5:
        server = qq(username, password);
        break;
      case 1:
      default:
        server = gmail(username, password);
    }
    return server;
  }

  Future<bool> sendMessage(String mensagem, String destinatario, String assunto,
      {Attachment anexo, String comCopia}) async {
    final message = Message()
      ..from = Address(username, 'Eu')
      ..recipients.add(destinatario)
      ..subject = assunto
      ..attachments.add(anexo)
      ..ccRecipients.add(comCopia)
      ..text = mensagem;

    try {
      SmtpServer smtpServer = findServer(username, password, smtp);
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());

      return true;
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
      return false;
    }
  }
}
