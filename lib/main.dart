import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'السعي وضريبة التصرف',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Arial',
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _amountController = TextEditingController();
  String _resultAmount1 = "";
  String _resultAmount2 = "";

  void _calculatePercentages() {
    String enteredText = _amountController.text;

    if (enteredText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("من فضلك ادخل المبلغ الصحيح")),
      );
      return;
    }

    double amount = double.tryParse(enteredText) ?? 0.0;
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("الرجاء إدخال مبلغ صحيح أكبر من 0")),
      );
      return;
    }

    double amount1 = amount * 0.05; // 5%
    double amount2 = amount * 0.025; // 2.5%

    setState(() {
      _resultAmount1 = "ضريبة التصرفات العقارية (5%): $amount1 ريال سعودي";
      _resultAmount2 = "السعي (2.5%): $amount2 ريال سعودي";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('السعي وضريبة التصرف')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "أدخل المبلغ",
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "من فضلك ادخل المبلغ",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculatePercentages,
              child: const Text("احسب"),
            ),
            const SizedBox(height: 20),
            Text(
              _resultAmount1,
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
            Text(
              _resultAmount2,
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
