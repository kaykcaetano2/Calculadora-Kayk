import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';

// Classe: Calculadora
class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  // Constante botão: limpar
  final String _C = 'C';
  // Variáveis: expressão e resultado
  String _expressao = '0';
  String _resultado = '';

  void _pressionarBotao(String valor) {
    setState(() {
      if (valor == _C) {
        _expressao = '0';
        _resultado = '';
      } else if (valor == '=') {
        _calcularResultado();
      } else {
        if (_expressao == '0') {
          _expressao = valor;
        } else {
          _expressao += valor;
        }
      }
    });
  }

  // Função que calcula a expressão
  void _calcularResultado() {
    try {
      _resultado = _avaliarExpressao(_expressao).toString();
    } catch (e) {
      _resultado = 'Cálculo inviável.';
    }
  }

  // Função usando a biblioteca expressions
  double _avaliarExpressao(String expressao) {
    expressao = expressao.replaceAll('x', '*');
    expressao = expressao.replaceAll('÷', '/');
    expressao = expressao.replaceAll('π', '14');
    ExpressionEvaluator avaliador = const ExpressionEvaluator();
    double resultado = avaliador.eval(Expression.parse(expressao), {});
    return resultado;
  }

  // Função: botão com valor específico
  Widget _botao(String valor) {
    return OutlinedButton(
      onPressed: () => _pressionarBotao(valor),
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color.fromARGB(255, 67, 69, 188),
        side: const BorderSide(
          color: Color.fromARGB(255, 92, 112, 202),
          width: 1,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Text(
        valor,
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          children: [
            Expanded(
              child: Text(_expressao, style: const TextStyle(fontSize: 24)),
            ),
            const Divider(color: Color.fromARGB(255, 92, 103, 202)),
            Expanded(
              child: Text(_resultado, style: const TextStyle(fontSize: 24)),
            ),
            // Botões: números e sinais
            Expanded(
              flex: 3,
              child: GridView.count(
                crossAxisCount: 4,
                childAspectRatio: 2,
                children: [
                  _botao('7'),
                  _botao('8'),
                  _botao('9'),
                  _botao('÷'),
                  _botao('4'),
                  _botao('5'),
                  _botao('6'),
                  _botao('x'),
                  _botao('1'),
                  _botao('2'),
                  _botao('3'),
                  _botao('-'),
                  _botao('.'),
                  _botao('0'),
                  _botao('π'),
                  _botao('+'),
                  _botao('('),
                  _botao(')'),
                  _botao(_C),
                  _botao('='),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
