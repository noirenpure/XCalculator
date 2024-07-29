import 'package:flutter/material.dart';

void main() => runApp(XCalculator());

class XCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'X-Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "DEL") {
      _output = _output.length > 1 ? _output.substring(0, _output.length - 1) : "0";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);

      if (operand == "+") {
        _output = (num1 + num2).toString();
      } else if (operand == "-") {
        _output = (num1 - num2).toString();
      } else if (operand == "×") {
        _output = (num1 * num2).toString();
      } else if (operand == "÷") {
        _output = (num1 / num2).toString();
      }

      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      if (_output == "0") {
        _output = buttonText;
      } else {
        _output = _output + buttonText;
      }
    }

    setState(() {
      output = _output.contains(".")
          ? double.parse(_output).toStringAsFixed(_output.split('.')[1] == "00" ? 0 : 2)
          : _output;
    });
  }

  Widget buildButton(String buttonText, Color color, {double padding = 24.0}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(4.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: color,
            padding: EdgeInsets.all(padding),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          onPressed: () => buttonPressed(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('X-Calculator'),
        backgroundColor: Colors.deepPurple[300],
      ),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 12.0,
              ),
              child: Text(
                output,
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Column(
              children: [
                Row(
                  children: [
                    buildButton("CLEAR", Colors.grey[300]!, padding: 16.0),
                    buildButton("DEL", Colors.grey[300]!, padding: 16.0),
                    buildButton("=", Colors.deepPurple[300]!, padding: 16.0),
                  ],
                ),
                Row(
                  children: [
                    buildButton("7", Colors.pink[100]!),
                    buildButton("8", Colors.orange[100]!),
                    buildButton("9", Colors.yellow[100]!),
                    buildButton("÷", Colors.green[100]!, padding: 16.0),
                  ],
                ),
                Row(
                  children: [
                    buildButton("4", Colors.blue[100]!),
                    buildButton("5", Colors.purple[100]!),
                    buildButton("6", Colors.red[100]!),
                    buildButton("×", Colors.cyan[100]!, padding: 16.0),
                  ],
                ),
                Row(
                  children: [
                    buildButton("1", Colors.teal[100]!),
                    buildButton("2", Colors.amber[100]!),
                    buildButton("3", Colors.lime[100]!),
                    buildButton("-", Colors.indigo[100]!, padding: 16.0),
                  ],
                ),
                Row(
                  children: [
                    buildButton(".", Colors.deepPurple[100]!),
                    buildButton("0", Colors.lightBlue[100]!),
                    buildButton("00", Colors.lightGreen[100]!),
                    buildButton("+", Colors.deepOrange[100]!, padding: 16.0),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
