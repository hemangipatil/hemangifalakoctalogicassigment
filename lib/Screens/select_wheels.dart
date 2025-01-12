// import 'package:flutter/material.dart';
// import 'package:hemangifalakoctalogictest/Screens/vehical_type.dart';
// import '../API Services/api_services.dart';
// import '../Database/database.dart';
//
// class NumberOfWheelsScreen extends StatefulWidget {
//   @override
//   _NumberOfWheelsScreenState createState() => _NumberOfWheelsScreenState();
// }
//
// class _NumberOfWheelsScreenState extends State<NumberOfWheelsScreen> {
//   List<String> _wheelOptions = [];
//   String? _selectedWheels;
//   bool _isLoading = true;  // To show loading indicator while fetching data
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchWheelOptions();
//   }
//
//   // Fetch wheel options from the API
//   void _fetchWheelOptions() async {
//     try {
//       final apiService = ApiService();
//       final response = await apiService.fetchVehicleTypes();
//
//       // Assuming the response is a list of vehicle types, directly process the list
//       if (response is List<dynamic>) {
//         setState(() {
//           // Map the list of data to extract wheel names
//           _wheelOptions = response.map((e) => e['name'] as String).toList();
//           _isLoading = false;  // Data fetched, hide loading indicator
//         });
//       } else {
//         throw Exception('Invalid response format');
//       }
//     } catch (e) {
//       print('Error fetching vehicle types: $e');
//       setState(() {
//         _isLoading = false;
//         _wheelOptions = ['Failed to fetch data'];
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Step 2: Number of Wheels')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Show loading indicator while fetching data
//             if (_isLoading)
//               Center(child: CircularProgressIndicator()),
//
//             // Show wheel options when they are available
//             if (!_isLoading && _wheelOptions.isNotEmpty)
//               Column(
//                 children: _wheelOptions.map((wheel) {
//                   return RadioListTile<String>(
//                     value: wheel,
//                     groupValue: _selectedWheels,
//                     title: Text(wheel),
//                     onChanged: (value) {
//                       setState(() {
//                         _selectedWheels = value;
//                       });
//                     },
//                   );
//                 }).toList(),
//               ),
//
//             // Show a validation message if no wheel options are fetched or selected
//             ElevatedButton(
//               onPressed: () {
//                 if (_selectedWheels != null && _selectedWheels != 'Failed to fetch data') {
//                   // Save selected wheel option to the database
//                   DBHelper.instance.saveData('wheels', _selectedWheels!);
//
//                   // Navigate to the next screen (VehicleTypeScreen)
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => VehicleTypeScreen()),
//                   );
//                 } else {
//                   // Show validation error if no option is selected or fetched
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Please select a number of wheels')),
//                   );
//                 }
//               },
//               child: Text('Next'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
