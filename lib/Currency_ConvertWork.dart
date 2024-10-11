import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  _CurrencyConverterScreenState createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  String? result;
  final TextEditingController textEditingController = TextEditingController();

  String fromCurrency = 'USD'; 
  String toCurrency = 'INR'; 

  List<String> currencyList = []; 

  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadCurrencyList(); 
  }

  Future<void> _loadCurrencyList() async {
    try {
      String apiKey = 'YOUR_API_KEY'; 
      String apiUrl =
          'https://v6.exchangerate-api.com/v6/$apiKey/latest/USD';

      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        Map<String, dynamic> rates = data['conversion_rates'];
        setState(() {
          currencyList = rates.keys.toList();
        });
      } else {
        setState(() {
          errorMessage = 'Error loading currency list';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
      });
    }
  }

  Future<void> convert() async {
    if (fromCurrency.isEmpty || toCurrency.isEmpty) {
      setState(() {
        errorMessage = 'Please select both currencies';
      });
      return;
    }

    try {
      double amount = double.parse(textEditingController.text);

      String apiKey = 'YOUR_API_KEY'; 
      String apiUrl =
          'https://v6.exchangerate-api.com/v6/$apiKey/latest/$fromCurrency';

      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        Map<String, dynamic> rates = data['conversion_rates'];

        if (rates.containsKey(toCurrency)) {
          double conversionRate = rates[toCurrency];

          setState(() {
            result = (amount * conversionRate).toStringAsFixed(2);
            errorMessage = ''; 
          });
        } else {
          setState(() {
            errorMessage = 'Currency not found in the response';
          });
        }
      } else {
        setState(() {
          errorMessage = 'Error fetching conversion rate';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e'; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: currencyList.isEmpty
            ? const Center(
                child:
                    CircularProgressIndicator()) 
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('From: ', style: TextStyle(fontSize: 20)),
                      DropdownButton<String>(
                        value: fromCurrency,
                        hint: const Text('Select Currency'),
                        items: currencyList.map((String currency) {
                          return DropdownMenuItem<String>(
                            value: currency,
                            child: Text(currency),
                          );
                        }).toList(),
                        onChanged: (String? selectedCurrency) {
                          setState(() {
                            fromCurrency = selectedCurrency!;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: textEditingController,
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true, signed: false),
                      decoration: const InputDecoration(
                        border:  OutlineInputBorder(),
                        enabledBorder:  OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2,
                          ),
                        ),
                        hintText: 'Enter Amount',
                        prefixIcon: Icon(Icons.attach_money_sharp),
                        hintStyle:  TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('To: ', style: TextStyle(fontSize: 20)),
                      DropdownButton<String>(
                        value: toCurrency,
                        hint: const Text('Select Currency'),
                        items: currencyList.map((String currency) {
                          return DropdownMenuItem<String>(
                            value: currency,
                            child: Text(currency),
                          );
                        }).toList(),
                        onChanged: (String? selectedCurrency) {
                          setState(() {
                            toCurrency = selectedCurrency!;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: convert,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blueGrey),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      child: const Text('Convert'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    errorMessage.isEmpty
                        ? 'Amount in $toCurrency: ${result ?? '0'}'
                        : 'Error: $errorMessage',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
      ),
    );
  }
}
