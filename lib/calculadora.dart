import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';
import 'dart:math';

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
  double _numero = 0;
  String _expressao = '0';
  String _resultado = '';
  double _base = 0;
  double _expo = 0;

  void _pressionarBotao(String valor) {
    setState(() {
      if (valor == _C) {
        _expressao = '0';
        _resultado = '';
        _numero = 0;
      } else if (valor == '=') {
        if (_expressao.startsWith("sin")) {
          _expressao = _expressao.replaceAll("sin", "");
          _numero = double.parse(_expressao);
          _expressao = (sin(_numero * (pi / 180))).toString();
          _calcularResultado();
        } else if (_expressao.startsWith("cos")) {
          _expressao = _expressao.replaceAll("cos", "");
          _numero = double.parse(_expressao);
          _expressao = (cos(_numero * (pi / 180))).toString();
          _calcularResultado();
        } else if (_expressao.startsWith("tan")) {
          _expressao = _expressao.replaceAll("tan", "");
          _numero = double.parse(_expressao);
          _expressao = ((_numero * (pi / 180))).toString();
          _calcularResultado();
        } else if (_expressao.contains("^")) {
          _base = double.parse(_expressao[0]);
          _expo = double.parse(_expressao.substring(2));
          _expressao = pow(_base, _expo).toString();
          _calcularResultado();
        } else {
          _calcularResultado();
        }
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
    expressao = expressao.replaceAll('π', '3.14');

    ExpressionEvaluator avaliador = const ExpressionEvaluator();
    double resultado = double.parse(
      avaliador.eval(Expression.parse(expressao), {}).toStringAsFixed(5),
    );
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
                  _botao('sin'),
                  _botao('cos'),
                  _botao('tan'),
                  _botao('^'),
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
