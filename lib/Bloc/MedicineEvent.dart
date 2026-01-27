import 'package:equatable/equatable.dart';
import '../models/MedicineModel.dart';


abstract class MedicineEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// حدث إضافة دواء جديد للسجل
class AddMedicineEvent extends MedicineEvent {
  final MedicineModel medicine;
  AddMedicineEvent(this.medicine);

  @override
  List<Object?> get props => [medicine];
}