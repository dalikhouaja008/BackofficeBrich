// lib/services/api_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../entities/dashboard_metrics.dart';

class ApiService {
  final String baseUrl = 'YOUR_API_URL'; // Replace with your NestJS API URL

  Future<DashboardMetrics> getDashboardMetrics() async {
    final response = await http.get(Uri.parse('$baseUrl/accounts/dashboard'));
    
    if (response.statusCode == 200) {
      return DashboardMetrics.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load dashboard metrics');
    }
  }

  Future<Map<String, dynamic>> getAccountDetails(String accountId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/accounts/$accountId/details')
    );
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load account details');
    }
  }
}