// lib/models/dashboard_metrics.dart
class DashboardMetrics {
  final int totalAccounts;
  final int activeAccounts;
  final int inactiveAccounts;
  final double totalBalance;
  final Map<String, int> accountsByStatus;

  DashboardMetrics({
    required this.totalAccounts,
    required this.activeAccounts,
    required this.inactiveAccounts,
    required this.totalBalance,
    required this.accountsByStatus,
  });

  factory DashboardMetrics.fromJson(Map<String, dynamic> json) {
    return DashboardMetrics(
      totalAccounts: json['totalAccounts'] ?? 0,
      activeAccounts: json['activeAccounts'] ?? 0,
      inactiveAccounts: json['inactiveAccounts'] ?? 0,
      totalBalance: (json['totalBalance'] ?? 0).toDouble(),
      accountsByStatus: Map<String, int>.from(json['accountsByStatus'] ?? {}),
    );
  }
}