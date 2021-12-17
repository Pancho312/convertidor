import 'package:flutter/material.dart';

void main() => runApp(MyConvert());

class MyConvert extends StatefulWidget {
  @override
  State<MyConvert> createState() => _MyConvertState();
}

class _MyConvertState extends State<MyConvert> {
  final Map<String, int> _measuresMap = {
    'meters': 0,
    'kilometers': 1,
    'grams': 2,
    'kilograms': 3,
    'feet': 4,
    'miles': 5,
    'pounds (lbs)': 6,
    'ounces': 7,
  };

  final dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
  };
  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds (lbs)',
    'ounces',
  ];

  double? _numberFrom;
  String? _startMeasure;
  String? _convertedMeasure;
  String? _resultMessage;

  final TextStyle inputStyle = TextStyle(
    fontSize: 20,
    color: Colors.blue[900],
  );
  final TextStyle labelStyle = TextStyle(
    fontSize: 24,
    color: Colors.teal[700],
  );

  @override
  void initState() {
    _numberFrom = 0;
    _startMeasure;
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Convertidor de Medidas',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Center(
            child: Text('Convertidor de Medidas',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          toolbarHeight: 100.0,
          leading: Image.asset(
            'img/cal.jpg',
            width: 40.0,
            height: 80.0,
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          color: Colors.green,
          child: Column(
            children: [
              Text(
                'Value',
                style: labelStyle,
              ),
              Spacer(),
              /* DropdownButton(
                items: _measures.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
                value: _startMeasure,
              ),*/
              Spacer(),
              TextField(
                style: inputStyle,
                decoration: const InputDecoration(
                  hintText: "Por favor inserte la medida a convertir",
                ),
                onChanged: (text) {
                  var rv = double.tryParse(text);
                  if (rv != null) {
                    setState(() {
                      _numberFrom = rv;
                    });
                  }
                },
              ),
              Spacer(),
              Text('convertir '),
              Text(
                'de.. ',
                style: labelStyle,
              ),
              DropdownButton(
                isExpanded: true,
                style: inputStyle,
                items: _measures.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _startMeasure = value;
                  });
                },
                value: _startMeasure,
              ),
              Spacer(),
              Text(
                'A ...',
                style: labelStyle,
              ),
              Spacer(),
              DropdownButton(
                isExpanded: true,
                style: inputStyle,
                items: _measures.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: inputStyle,
                    ),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _convertedMeasure = value;
                  });
                },
                value: _convertedMeasure,
              ),
              Spacer(
                flex: 2,
              ),
              RaisedButton(
                child: Text(
                  'Convertir',
                  style: inputStyle,
                ),
                onPressed: () {
                  if (_startMeasure!.isEmpty ||
                      _convertedMeasure!.isEmpty ||
                      _numberFrom == 0) {
                    return;
                  } else {
                    convert(_numberFrom!, _startMeasure!, _convertedMeasure!);
                  }
                },
              ),
              Spacer(
                flex: 2,
              ),
              Text((_resultMessage == null) ? '' : _resultMessage!,
                  style: labelStyle),
              Spacer(
                flex: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void convert(double value, String from, String to) {
    int? nFrom = _measuresMap[from];
    int? nTo = _measuresMap[to];
    var multiplier = _formulas[nFrom.toString()][nTo];
    double result = value * multiplier;
    if (result == 0) {
      _resultMessage = 'Esta conversión no se puede realizar';
    } else {
      _resultMessage =
          '${_numberFrom.toString()} $_startMeasure are ${result.toString()} $_convertedMeasure';
    }
    setState(() {
      _resultMessage = _resultMessage;
    });
  }
}
