import 'package:equatable/equatable.dart';
import 'package:meditap/models/MedicineModel.dart';
import '../models/MedicineModel.dart';


abstract class MedicineState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MedicineInitial extends MedicineState {}

class MedicineLoaded extends MedicineState {
  final List<MedicineModel> medicines;
  MedicineLoaded(this.medicines);

  @override
  List<Object?> get props => [medicines];
}