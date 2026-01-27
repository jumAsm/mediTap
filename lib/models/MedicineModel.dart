class MedicineModel { // تأكدي من توحيد الاسم هنا
  final String name;
  final String instruction;
  final int dailyLimit;

  MedicineModel({
    required this.name,
    required this.instruction,
    required this.dailyLimit,
  });
}