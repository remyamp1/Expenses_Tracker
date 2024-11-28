import 'package:expenses/Appwrite_model.dart';
import 'package:expenses/Appwrite_service.dart';
import 'package:flutter/material.dart';

class ExpensesApp extends StatefulWidget {
  const ExpensesApp({super.key});

  @override
  State<ExpensesApp> createState() => _ExpensesState();
}

class _ExpensesState extends State<ExpensesApp> {
  late AppwriteService _appwriteService;
  late List<Expenses> _task;

  TextEditingController itemController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _appwriteService = AppwriteService();
    _task = [];
    _loadtask();
  }

  Future<void> _loadtask() async {
    try {
      final tasks = await _appwriteService.getTasks();
      setState(() {
        _task = tasks.map((e) => Expenses.fromDocument(e)).toList();
      });
    } catch (e) {
      print("Error loading task");
    }
  }

  Future<void> _addEmployee() async {
    final item = itemController.text;
    final amount = amountController.text;
    final date = dateController.text;

    if (item.isNotEmpty && amount.isNotEmpty && date.isNotEmpty) {
      try {
        await _appwriteService.addExpenses(item, amount, date);
        itemController.clear();
        amountController.clear();
        dateController.clear();
        _loadtask();
      } catch (e) {
        print("Error adding task:$e");
      }
    }
  }

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
        dateController.text =
            '${SelectedDate!.day.toString()}/${SelectedDate!.month.toString()}/${SelectedDate!.year.toString()}';
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
      body: ListView.separated(
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 15,
            );
          },
          itemCount: _task.length,
          itemBuilder: (context, index) {
            final expenses = _task[index];
            return Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 214, 194, 250)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(expenses.Items),
                    Text(expenses.Amount),
                    Text(expenses.Date),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext content) {
                return Container(
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: itemController,
                            decoration: InputDecoration(
                                label: Text('Items',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold))),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextField(
                            controller: amountController,
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
                            controller: dateController,
                            onTap: () => _selectDate(context),
                            decoration: InputDecoration(
                                label: Text(
                              'Date',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                          SizedBox(height: 70),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  onPressed: _addEmployee,
                                  child: Text(
                                    'Add',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ));
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
