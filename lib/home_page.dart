import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'temperature_provider.dart';
import 'auth_service.dart';

class HomePage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final temp = Provider.of<TemperatureProvider>(context);
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Konversi Suhu"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authService.logout();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Input Celsius",
              ),
              onChanged: (value) {
                temp.setCelsius(double.tryParse(value) ?? 0);
              },
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: temp.type,
              items: ["Fahrenheit", "Kelvin"]
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (value) {
                temp.setType(value!);
              },
            ),
            const SizedBox(height: 20),
            Text(
              "Hasil: ${temp.result.toStringAsFixed(2)} ${temp.type}",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
