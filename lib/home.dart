import 'package:calculator/history.dart';
import 'package:calculator/histroybox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _lengthcontroller = TextEditingController();
  late double _input = 0;
  var _from = 'meter';
  var _to = 'meter';
  late double _result = 0;
  final List<String> _dropdown = [
    'millimeter',
    'centimeter',
    'meter',
    'kilometer',
    'inches',
    'feet'
  ];

  double _convert(double length) {
    Map<String, double> conversionRates = {
      'meter': 1,
      'centimeter': 100,
      'millimeter': 1000,
      'kilometer': 0.001,
      'inches': 39.3701,
      'feet': 3.28084,
    };
    double lengthInMeters = length / conversionRates[_from]!;
    return lengthInMeters * conversionRates[_to]!;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black,
          backgroundColor: const Color.fromARGB(255, 134, 195, 246),
          title: const Text(
            'Length Converter',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return const History();
                  }));
                },
                icon: const Icon(
                  Icons.history_sharp,
                  size: 35,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextFormField(
                controller: _lengthcontroller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter the length',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black)),
                    child: DropdownButton(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 2,
                      dropdownColor: const Color.fromARGB(255, 246, 241, 241),
                      value: _from,
                      onChanged: (newValue) {
                        setState(() {
                          _from = newValue!;
                        });
                      },
                      items: _dropdown.map(
                        (e) {
                          return DropdownMenuItem(value: e, child: Text(e));
                        },
                      ).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black)),
                    child: DropdownButton(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 2,
                      dropdownColor: const Color.fromARGB(255, 246, 241, 241),
                      value: _to,
                      onChanged: (newValue) {
                        setState(() {
                          _to = newValue!;
                        });
                      },
                      items: _dropdown.map(
                        (e) {
                          return DropdownMenuItem(value: e, child: Text(e));
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 134, 195, 246)),
                onPressed: () {
                  setState(() {
                    _input = double.tryParse(_lengthcontroller.text) ?? 0;
                    _result = _convert(_input);
                    addhistory(
                      Histroybox(double.parse(_lengthcontroller.text), _from,
                          _to, TimeOfDay.now(), _result),
                    );
                  });
                },
                child: const Text(
                  'Convert',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              Text(
                'Result: $_result $_to',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
