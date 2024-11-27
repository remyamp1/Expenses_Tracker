import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  TextEditingController item = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController date = TextEditingController();

  String? selesctedOption = 'Option 1';
  DateTime? SelectedDate;
  Future<void> _selectDate(BuildContext content) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (picked != null && picked != SelectedDate) {
      setState(() {
        SelectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'EXPENSES TRACKER',
            style: TextStyle(color: const Color.fromARGB(255, 105, 80, 248)),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext content) {
                      return Container(
                        height: 350,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  TextField(
                                    controller: item,
                                    decoration: InputDecoration(
                                        label: Text('Items',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold))),
                                  ),
                                  ListTile(
                                    title: Text("Food"),
                                    leading: Radio<String>(
                                        value: 'Option 1',
                                        groupValue: selesctedOption,
                                        onChanged: (String? value) {
                                          setState(() {
                                            selesctedOption = value;
                                          });
                                        }),
                                  ),
                                  ListTile(
                                    title: Text("Movie"),
                                    leading: Radio<String>(
                                        value: 'Option 2',
                                        groupValue: selesctedOption,
                                        onChanged: (String? value) {
                                          setState(() {
                                            selesctedOption = value;
                                          });
                                        }),
                                  ),
                                  ListTile(
                                    title: Text("Expenses"),
                                    leading: Radio<String>(
                                        value: 'Option 3',
                                        groupValue: selesctedOption,
                                        onChanged: (String? value) {
                                          setState(() {
                                            selesctedOption = value;
                                          });
                                        }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Selected:$selesctedOption",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextField(
                                controller: amount,
                                decoration: InputDecoration(
                                    label: Text(
                                  'Amount',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextField(
                                controller: date,
                                decoration: InputDecoration(
                                    label: Text(
                                  'Date',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Icon(Icons.add),
            )
          ],
        ));
  }
}
