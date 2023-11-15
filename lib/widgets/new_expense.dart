import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart'; // as expense;

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectDate;

  final List<String> internalCategories = <String>['bob', 'joe', 'sue'];
  final myTitle = Category.food.name.toString();
  String dropdownValue = '';

  @override
  void initState() {
    dropdownValue = internalCategories.first;
    // TODO: implement initState
    super.initState();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$ ',
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectDate == null
                          ? 'No date selected'
                          : formatter.format(_selectDate!),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    )
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              // Course method:
              DropdownButton(
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        child: Text(
                          category.name.toString(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  print(value);
                },
              ),
              //
              // Alternate method:
              // DropdownButton(
              //     items: internalCategories
              //         .map<DropdownMenuItem<String>>((String value) {
              //       return DropdownMenuItem(value: value, child: Text(value));
              //     }).toList(),
              //     onChanged: (value) {
              //       print(value);
              //     }),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  print(_titleController.text);
                  print(_amountController.text);
                },
                child: const Text('Save Expense'),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
