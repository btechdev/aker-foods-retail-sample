import 'package:aker_foods_retail/domain/entities/society_entity.dart';
import 'package:meta/meta.dart';

abstract class SelectSocietyState {}

class EmptyState extends SelectSocietyState {}

class FetchingSocietiesState extends SelectSocietyState {}

class SocietiesLoadedState extends SelectSocietyState {
  final List<SocietyEntity> societies;

  SocietiesLoadedState({@required this.societies});
}
