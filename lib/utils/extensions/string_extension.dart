extension StringExtension on String {
  String get formatCep {
    return '${substring(0, 5)}-${substring(5, 8)}';
  }
}
