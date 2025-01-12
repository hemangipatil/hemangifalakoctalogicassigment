import 'package:flutter/material.dart';
import '../API Services/api_services.dart';
import '../Database/database.dart';
import '../Model/vehical_model.dart';

class VehicleTypeScreen extends StatefulWidget {
  @override
  _VehicleTypeScreenState createState() => _VehicleTypeScreenState();
}

class _VehicleTypeScreenState extends State<VehicleTypeScreen> {
  List<VehicleType> _vehicleTypes = [];
  bool _isLoading = true;
  String _errorMessage = '';
  VehicleType? _selectedVehicleType; // To track selected vehicle type

  @override
  void initState() {
    super.initState();
    _fetchVehicleTypes();
  }

  void _fetchVehicleTypes() async {
    try {
      ApiService apiService = ApiService();
      List<VehicleType> vehicleTypes = await apiService.fetchVehicleTypes();
      setState(() {
        _vehicleTypes = vehicleTypes;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load vehicle types: $e';
      });
    }
  }

  void _saveToLocalDatabase(VehicleType vehicleType) async {
    try {
      await DBHelper.instance.insertVehicleType(vehicleType);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${vehicleType.name} saved successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vehicle Types')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
          ? Center(child: Text(_errorMessage))
          : ListView.builder(
        itemCount: _vehicleTypes.length,
        itemBuilder: (context, index) {
          final vehicleType = _vehicleTypes[index];
          return RadioListTile<VehicleType>(
            value: vehicleType,
            groupValue: _selectedVehicleType,
            title: Text('${vehicleType.wheels} Wheels'),
            subtitle: Text(vehicleType.name),
            onChanged: (value) {
              setState(() {
                _selectedVehicleType = value;
                if (_selectedVehicleType != null) {
                  _saveToLocalDatabase(_selectedVehicleType!);
                }
              });
            },
          );
        },
      ),
    );
  }
}
