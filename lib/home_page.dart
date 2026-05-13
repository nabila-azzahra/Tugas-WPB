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
        title: const Text(
          "Konversi Suhu",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0088CC),
        iconTheme: const IconThemeData(color: Colors.white),
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
              decoration: InputDecoration(
                labelText: "Input Celsius",
                labelStyle: const TextStyle(color: Color(0xFF0088CC)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF0088CC), width: 2),
                ),
                prefixIcon: const Icon(Icons.thermostat, color: Color(0xFF0088CC)),
              ),
              onChanged: (value) {
                temp.setCelsius(double.tryParse(value) ?? 0);
              },
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: temp.type,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF0088CC)),
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
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF0088CC).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF0088CC).withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  const Text(
                    "Hasil Konversi",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF0088CC),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${temp.result.toStringAsFixed(2)} ${temp.type}",
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0088CC),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
