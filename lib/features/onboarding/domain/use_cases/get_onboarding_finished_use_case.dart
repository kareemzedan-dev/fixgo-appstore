import 'package:injectable/injectable.dart';
import 'package:fixgo/features/onboarding/data/data_sources/onboarding_local_data_source.dart';

@injectable
class GetOnboardingFinishedUseCase {
  final OnboardingLocalDataSource localDataSource;

  GetOnboardingFinishedUseCase(this.localDataSource);

  Future<bool> call() => localDataSource.hasFinishedOnboarding();
}
