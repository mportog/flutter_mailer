import 'package:flutter/material.dart';

class RadioWidgetDemo extends StatefulWidget {
  RadioWidgetDemo() : super();

  final String title = "Radio Widget Demo";

  @override
  RadioWidgetDemoState createState() => RadioWidgetDemoState();
}

class RadioWidgetDemoState extends State<RadioWidgetDemo> {
  int selectedRadio;
  int selectedRadioTile;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Divider(
            height: 20,
            color: Colors.green,
          ),
          RadioListTile(
            value: 1,
            groupValue: selectedRadioTile,
            title: Text("Radio 1"),
            subtitle: Text("Radio 1 Subtitle"),
            onChanged: (val) {
              setSelectedRadioTile(val);
              setSelectedRadio(val);
            },
            secondary: OutlineButton(
              child: Text("Say Hi"),
              onPressed: () {},
            ),
            selected: true,
          ),
          RadioListTile(
            value: 2,
            groupValue: selectedRadioTile,
            title: Text("Radio 2"),
            subtitle: Text("Radio 2 Subtitle"),
            onChanged: (val) {
              setSelectedRadioTile(val);
              setSelectedRadio(val);
            },
            secondary: OutlineButton(
              child: Text("Say Hi"),
              onPressed: () {},
            ),
            selected: false,
          ),
          Divider(
            height: 20,
            color: Colors.green,
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add Conta'),
            subtitle: Text('Adicionar conta de email'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Config'),
            subtitle: Text('Permissões e dados armazenados'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Info'),
            subtitle: Text('Informções do app'),
            onTap: () {},
          ),
          Divider(
            height: 20,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
