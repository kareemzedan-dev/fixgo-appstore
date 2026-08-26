/// domain/use_cases/add_service_use_case.dart
library;

import 'package:injectable/injectable.dart';

import '../entities/add_service_entity.dart';
import '../repos/offers_repo.dart';
@injectable
class AddServiceUseCase {
  final OffersRepo repo;

  AddServiceUseCase(this.repo);

  Future<void> call({
    required AddServiceEntity service,
  }) async {
    await repo.addService(
      service: service,
    );
  }
}