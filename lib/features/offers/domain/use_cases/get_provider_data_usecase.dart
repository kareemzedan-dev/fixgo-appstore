import 'package:injectable/injectable.dart';
import 'package:fixgo/features/offers/domain/repos/offers_repo.dart';

@injectable
class GetProviderDataUseCase {
  final OffersRepo repository;

  GetProviderDataUseCase(this.repository);

  Future<Map<String, dynamic>> call(String userId) async {
    return await repository.getUserData(userId);
  }
}
