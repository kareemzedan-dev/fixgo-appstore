import 'package:injectable/injectable.dart';
import 'package:fixgo/features/verification/domain/repos/verification_repo.dart';

@injectable
class GetVerificationStatusUseCase {
  final VerificationRepo repo;

  GetVerificationStatusUseCase(this.repo);

  Future<String> call() => repo.getVerificationStatus();
}
