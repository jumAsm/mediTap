import 'package:equatable/equatable.dart';
import '../ Models/MedicineModel.dart';


abstract class MedicineState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MedicineInitial extends MedicineState {}

class MedicineLoaded extends MedicineState {
  final List<Medicine> medicines;
  MedicineLoaded(this.medicines);

  @override
  List<Object?> get props => [medicines];
}