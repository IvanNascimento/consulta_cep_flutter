import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:viacep/views/home.dart';
import 'package:viacep/views/registros.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const ViaCepApp());
}

class ViaCepApp extends StatelessWidget {
  const ViaCepApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eclipse ViaCep',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(title: 'Eclipse verificador de Cep'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});
  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController mainCtrl = PageController();
  int _pagAtual = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset:
          false, // Evitar do teclado fazer os elementos subirem
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      alignment: Alignment.centerLeft,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      title: const Text("Solar Eclipse IMC"),
                      content: const Wrap(
                        children: [
                          Text("Sair do aplicativo!"),
                          Text("Deseja realmente sair do aplicativo ?")
                        ],
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Não')),
                        TextButton(
                            onPressed: () {
                              SystemNavigator.pop(animated: true);
                            },
                            child: const Text('Sim'))
                      ],
                    );
                  });
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Column(children: [
        Expanded(
            child: PageView(
          controller: mainCtrl,
          onPageChanged: (value) {
            setState(() {
              _pagAtual = value;
            });
          },
          children: const [Home(), Registros()],
        )),
        BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.blueAccent,
            currentIndex: _pagAtual,
            onTap: (value) {
              mainCtrl.jumpToPage(value);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt), label: "Registros"),
            ]),
      ]),
    ));
  }
}
