import 'package:flutter/material.dart';
import 'package:hemangifalakoctalogictest/Screens/select_wheels.dart';
import 'package:hemangifalakoctalogictest/Screens/vehical_type.dart';

import '../API Services/api_services.dart';
import '../Database/database.dart';


class NameScreen extends StatefulWidget {
  @override
  _NameScreenState createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  void _saveName() async {
    if (_formKey.currentState?.validate() ?? false) {
      String firstName = _firstNameController.text;
      String lastName = _lastNameController.text;

      // Save data to SQLite
      await DBHelper.instance.saveData('first_name', firstName);
      await DBHelper.instance.saveData('last_name', lastName);

      // Navigate to next screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VehicleTypeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Name')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              Spacer(),
              ElevatedButton(
                onPressed: _saveName,
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
