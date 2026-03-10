import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Konverter Suhu Pro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Konverter Suhu'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _inputController = TextEditingController(
    text: "0",
  );
  String _selectedUnit = 'Celsius';
  final List<String> _units = ['Celsius', 'Fahrenheit', 'Kelvin', 'Reamur'];

  // Variabel penampung hasil
  double _c = 0, _f = 32, _k = 273.15, _r = 0;

  @override
  void initState() {
    super.initState();
    _calculateConversions("0");
  }

  void _calculateConversions(String value) {
    double input = double.tryParse(value) ?? 0;
    double celsius;

    // 1. Konversi dari Satuan Input ke Celsius (Base)
    switch (_selectedUnit) {
      case 'Fahrenheit':
        celsius = (input - 32) * 5 / 9;
        break;
      case 'Kelvin':
        celsius = input - 273.15;
        break;
      case 'Reamur':
        celsius = input * 5 / 4;
        break;
      default:
        celsius = input;
    }

    // 2. Konversi dari Celsius ke Semua Satuan
    setState(() {
      _c = celsius;
      _f = (celsius * 9 / 5) + 32;
      _k = celsius + 273.15;
      _r = celsius * 4 / 5;
    });
  }

  void _adjustValue(int delta) {
    double current = double.tryParse(_inputController.text) ?? 0;
    double newValue = current + delta;
    _inputController.text = newValue.toStringAsFixed(0);
    _calculateConversions(_inputController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Nabila Azzahra Prasetya',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text('NIM: 3124521034', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 30),

              // Unit Selector (Input Mode)
              DropdownButton<String>(
                value: _selectedUnit,
                items: _units
                    .map(
                      (u) => DropdownMenuItem(
                        value: u,
                        child: Text("Input as $u"),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  setState(() => _selectedUnit = val!);
                  _calculateConversions(_inputController.text);
                },
              ),

              // Input Field yang menggantikan Text statis
              SizedBox(
                width: 150,
                child: TextField(
                  controller: _inputController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                  decoration: const InputDecoration(suffixText: ""),
                  onChanged: _calculateConversions,
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(indent: 80, endIndent: 80),
              ),

              // Output Display Section
              _buildResultRow("Celsius", _c, "°C"),
              _buildResultRow("Fahrenheit", _f, "°F"),
              _buildResultRow("Kelvin", _k, "K"),
              _buildResultRow("Reamur", _r, "°R"),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _adjustValue(-1),
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () => _adjustValue(1),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget _buildResultRow(String label, double value, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        '$label: ${value.toStringAsFixed(2)} $unit',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}