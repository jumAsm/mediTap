class Medicine {
  final String name;
  final String dosage;
  final String instruction;
  final int dailyLimit;
  final String iconPath;

  Medicine({
    required this.name,
    required this.dosage,
    required this.instruction,
    required this.dailyLimit,
    this.iconPath = '',
  });
}