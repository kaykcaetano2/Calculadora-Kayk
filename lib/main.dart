import 'package:flutter/material.dart';
import 'calculadora.dart';

void main() {
  runApp(const App());
}

// Cabeçalho
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 42, 52, 235),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Calculadora'),
    );
  }
}

// Classe que garante mudança durante a execução
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

// Classe que define colunas e linhas
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              // Layout superior
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  color: const Color.fromARGB(255, 144, 167, 241),
                ),
              ),

              // Layout central
              Expanded(
                flex: 7,
                child: Row(
                  children: [
                    // Coluna 1
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        color: const Color.fromARGB(255, 0, 22, 130),
                        child: const Text(''),
                      ),
                    ),

                    // Calculadora com cor de fundo do container
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        color: const Color.fromARGB(255, 0, 22, 130),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: constraints.maxHeight * 0.02,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 165, 189, 228),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color.fromARGB(255, 48, 94, 230),
                              width: 3,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Calculadora(),
                        ),
                      ),
                    ),

                    // Coluna 3
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        color: const Color.fromARGB(255, 0, 22, 130),
                        child: const Text(''),
                      ),
                    ),
                  ],
                ),
              ),

              // Layout inferior
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  color: const Color.fromARGB(255, 147, 142, 238),
                  child: const Text(''),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Incrementar',
        child: const Icon(Icons.add),
      ),
    );
  }
}
