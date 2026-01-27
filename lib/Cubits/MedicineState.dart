import 'package:equatable/equatable.dart';
import '../models/medicine_model.dart'; // تأكدي من مسار ملف الـ Model

abstract class MedicineState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MedicineInitial extends MedicineState {}

// الحالة عند عرض قائمة الأدوية
class MedicineLoaded extends MedicineState {
  final List<Medicine> medicines;
  MedicineLoaded(this.medicines);

  @override
  List<Object?> get props => [medicines];
}