import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sql To Java',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _sqlController = new TextEditingController();
  final _javaController = new TextEditingController();

  @override
  void dispose() {
    _sqlController.dispose();
    _javaController.dispose();
    super.dispose();
  }

  void _sqlToJava() {
    var text = _sqlController.text;

    if (text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Aviso'),
          content: const Text(
              'Debes capturar la sentencia SQL que quieres convertir a código Java.'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.pop(context, 'Aceptar'),
              child: const Text('Aceptar'),
            )
          ],
        ),
      );
      return;
    }

    var lineas = text.split('\n');

    if (lineas.length < 2) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Aviso'),
          content: const Text(
              'La sentencia SQL debe contener al menos dos líneas de texto.'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.pop(context, 'Aceptar'),
              child: const Text('Aceptar'),
            )
          ],
        ),
      );
      return;
    }

    var res = '';
    var primeraLinea = true;

    for (var linea in lineas) {
      if (primeraLinea) {
        res = 'String sql = "${linea.trim()} ";\n';
        primeraLinea = false;
      } else {
        res += 'sql += "${linea.trim()} ";\n';
      }
    }

    _javaController.text = res.trim();
  }

  void _javaToSql() {
    var text = _javaController.text;

    if (text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Aviso'),
          content: const Text(
              'Debes capturar el código Java que quieres convertir a sentencia SQL.'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.pop(context, 'Aceptar'),
              child: const Text('Aceptar'),
            )
          ],
        ),
      );
      return;
    }

    var lineas = text.split('\n');

    if (lineas.length < 2) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Aviso'),
          content: const Text(
              'El código Java debe contener al menos dos líneas de texto.'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.pop(context, 'Aceptar'),
              child: const Text('Aceptar'),
            )
          ],
        ),
      );
      return;
    }

    var res = '';

    for (var linea in lineas) {
      var partes = linea.split('"');

      print(partes);
      if (partes.length == 3) {
        res += '${partes[1].trim()} \n';
      }
    }

    _sqlController.text = res.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("SQL"),
                Expanded(
                  child: TextField(
                    autofocus: true,
                    controller: _sqlController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0x07000000),
                      hintText:
                          'Pega la sentencia SQL que quieras convertir a código Java.',
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 16.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: Text(">"),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  primary: Colors.white,
                ),
                onPressed: _sqlToJava,
              ),
              SizedBox(
                height: 16.0,
              ),
              TextButton(
                child: Text("<"),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  primary: Colors.white,
                ),
                onPressed: _javaToSql,
              ),
            ],
          ),
          SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Java"),
                Expanded(
                  child: TextField(
                    controller: _javaController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0x07000000),
                      hintText:
                          'Pega el código Java que quieras convertir a sentencia SQL.',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
