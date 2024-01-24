import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Flutter',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[900],
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: Colors.white,
            fontSize: 48.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: ColorScheme.dark(
          primary: Colors.deepPurple,
          onPrimary: Colors.black,
          secondary: Colors.blue,
          onSecondary: Colors.black,
        ),
      ),
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _output = '0';
  double _num1 = 0;
  String _operator = '';
  bool _resetInput = false;

  void _buttonPressed(String buttonText) {
    if (buttonText == 'C') {
      _resetCalculator();
    } else if (buttonText == '=') {
      _calculateResult();
    } else if (buttonText == '.') {
      _handleDot();
    } else if (buttonText == '+' || buttonText == '-' || buttonText == 'x' || buttonText == '/') {
      _handleOperator(buttonText);
    } else {
      _handleNumber(buttonText);
    }
  }

  void _resetCalculator() {
    setState(() {
      _output = '0';
      _num1 = 0;
      _operator = '';
      _resetInput = false;
    });
  }

  void _calculateResult() {
    if (_operator.isNotEmpty) {
      double num2 = double.parse(_output);
      double result = 0;

      switch (_operator) {
        case '+':
          result = _num1 + num2;
          break;
        case '-':
          result = _num1 - num2;
          break;
        case 'x':
          result = _num1 * num2;
          break;
        case '/':
          result = _num1 / num2;
          break;
      }

      setState(() {
        _output = result.toStringAsFixed(2); // Ajusta la cantidad de decimales
        _num1 = 0;
        _operator = '';
        _resetInput = true;
      });
    }
  }

  void _handleDot() {
    if (!_output.contains('.')) {
      setState(() {
        _output += '.';
      });
    }
  }

  void _handleOperator(String operator) {
    if (_num1 == 0) {
      // Si no hay un primer número, asigna el valor actual del display
      _num1 = double.parse(_output);
    } else {
      // Si ya hay un primer número, realiza la operación anterior
      _calculateResult();
    }

    setState(() {
      _operator = operator;
      _resetInput = true;
    });
  }

  void _handleNumber(String buttonText) {
    setState(() {
      if (_resetInput || _output == '0') {
        _output = buttonText;
        _resetInput = false;
      } else {
        _output += buttonText;
      }
    });
  }

  Widget _buildButton(String buttonText, Color buttonColor) {
    return Container(
      child: ElevatedButton(
        onPressed: () => _buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          padding: EdgeInsets.all(20.0),
          shape: CircleBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora Flutter'),
        backgroundColor: Colors.grey[900],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            alignment: Alignment.bottomRight,
            child: Text(
              _output,
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('7', Colors.deepPurple),
              _buildButton('8', Colors.deepPurple),
              _buildButton('9', Colors.deepPurple),
              _buildButton('/', Colors.blue),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('4', Colors.deepPurple),
              _buildButton('5', Colors.deepPurple),
              _buildButton('6', Colors.deepPurple),
              _buildButton('x', Colors.blue),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('1', Colors.deepPurple),
              _buildButton('2', Colors.deepPurple),
              _buildButton('3', Colors.deepPurple),
              _buildButton('-', Colors.blue),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('.', Colors.deepPurple),
              _buildButton('0', Colors.deepPurple),
              _buildButton('C', Colors.red),
              _buildButton('+', Colors.blue),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('=', Colors.blue),
            ],
          ),
        ],
      ),
    );
  }
}