import 'package:flutter/material.dart';

import '../Database/database.dart';

class DateRangeScreen extends StatefulWidget {
  @override
  _DateRangeScreenState createState() => _DateRangeScreenState();
}

class _DateRangeScreenState extends State<DateRangeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  void _saveDates() async {
    if (_formKey.currentState?.validate() ?? false) {
      String startDate = _startDateController.text;
      String endDate = _endDateController.text;

      // Save rental dates to SQLite
      await DBHelper.instance.saveData('rental_start_date', startDate);
      await DBHelper.instance.saveData('rental_end_date', endDate);

      // Confirmation and proceed
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Booking Saved')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Rental Date')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _startDateController,
                decoration: InputDecoration(labelText: 'Start Date (YYYY-MM-DD)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a start date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _endDateController,
                decoration: InputDecoration(labelText: 'End Date (YYYY-MM-DD)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an end date';
                  }
                  return null;
                },
              ),
              Spacer(),
              ElevatedButton(
                onPressed: _saveDates,
                child: Text('Finish'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
