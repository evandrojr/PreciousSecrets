import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of our application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Precious secrets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  FirstScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FirstScreenState createState() => _FirstScreenState();
}



class _FirstScreenState extends State<FirstScreen> {
  var passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reconfigurar SIM card'),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text("Informe o PUK do seu SIM Card:"),
              TextField(
                controller: passController,
                textAlign: TextAlign.start,
                onChanged: (String txt) {
                  if (txt == 'add-your-passoword-here') {
                    passController.text = '';
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TextEditorPage()),
                    );
                  }else{
                    print(context);
//                    Scaffold.of(context).showSnackBar(
//                      new SnackBar(
//                        content: new Text("Added to favorite"),
//                        action: new SnackBarAction(
//                          label: "UNDO",
//                          onPressed: () => Scaffold.of(context).hideCurrentSnackBar(),
//                        ),
//                      ),
//                    );
                  }
                },
              )

            ],
          )


        ),
      )





    );
  }

}


class TextEditorPage extends StatefulWidget {
  TextEditorPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TextEditorPageState createState() => _TextEditorPageState();
}

class _TextEditorPageState extends State<TextEditorPage> {
  String _segredo = '';
  var textController = new TextEditingController();
  SimpleDialog sd;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  //Loading counter value on start
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _segredo = (prefs.getString('segredo') ?? '');
      textController.text = _segredo;
    });
  }

  //Incrementing counter after click
  _salvarSegredo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
//    _segredo = (prefs.getString('segredo') ?? '');
    setState(() {
      _segredo;
    });
    prefs.setString('segredo', _segredo);
  }

  void _confirm() {
    sd = new SimpleDialog(
      title: new Text(
        'Confirma?',
        style: Theme.of(context).textTheme.display1,
      ),
      children: <Widget>[
        new SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, _salvarSegredo());
          },
          child: new Text(
            'Sim',
            style: Theme.of(context).textTheme.display1,
          ),
        ),
        new SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, () => {});
          },
          child: new Text(
            'Não',
            style: Theme.of(context).textTheme.display1,
          ),
        ),
      ],
    );
    showDialog(context: context, child: sd);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
      body: TextField(
        textAlign: TextAlign.start,
        controller: textController,
        onChanged: (String txt) {
          setState(() {
            _segredo = txt;
          });
        },
        keyboardType: TextInputType.multiline,
        maxLines: 200,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _confirm,
        tooltip: 'Salvar',
        child: Icon(Icons.save),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
