# Precious Secrets

Change 'add-your-passoword-here' and hard code your password before compiling. Very naive, isn't? I completely agree! So fix it yourself and stop complaing about life! I am busy right now at more relevant projects like PsicHelp. For me, that way will do for now.


```
File:
lib/main.dart

class _FirstScreenState extends State<FirstScreen> {
  var passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reconfigurar SIM card'),
      ),
      body: Center(
        child: TextField(
          controller: passController,
          textAlign: TextAlign.start,
          onChanged: (String txt) {
            if (txt == 'add-your-passoword-here') {
              passController.text = '';
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TextEditorPage()),
              );
            }
          },
        ),
      ),
    );
  }

}

```


## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.io/).
