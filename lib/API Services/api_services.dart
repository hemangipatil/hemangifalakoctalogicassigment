import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/vehical_model.dart';


class ApiService {
  static const String vehicleTypesUrl = 'https://octalogic-test-frontend.vercel.app/api/v1/vehicleTypes';

  // Fetch Vehicle Types and return a List of VehicleType objects
  Future<List<VehicleType>> fetchVehicleTypes() async {
    final response = await http.get(Uri.parse(vehicleTypesUrl));

    if (response.statusCode == 200) {
      // Print the raw response body to inspect its structure
      print('Response body: ${response.body}');

      try {
        // Parse the response body into JSON
        var jsonData = json.decode(response.body);

        // Check if the response is a Map and contains the 'data' key
        if (jsonData is Map && jsonData['data'] != null) {
          List<dynamic> data = jsonData['data'];

          // Safely map the data and handle any null values
          return data.map((e) {
            // Ensure all fields are not null or have default values
            String name = e['name'] ?? 'Unknown Name'; // Provide default value
            String imageUrl = e['imageUrl'] ?? ''; // Provide default empty string
            int wheels = e['wheels'] ?? 0; // Provide default value for wheels

            return VehicleType(name: name, imageUrl: imageUrl, wheels: wheels);
          }).toList();
        } else {
          throw Exception('Expected "data" key not found or empty');
        }
      } catch (e) {
        print('Error parsing the response: $e');
        throw Exception('Failed to parse vehicle types');
      }
    } else {
      print('Failed to load vehicle types. Status code: ${response.statusCode}');
      throw Exception('Failed to load vehicle types');
    }
  }
}
