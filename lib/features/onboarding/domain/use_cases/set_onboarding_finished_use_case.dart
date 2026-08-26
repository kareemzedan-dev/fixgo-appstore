import 'package:injectable/injectable.dart';
import 'package:fixgo/features/onboarding/data/data_sources/onboarding_local_data_source.dart';

@injectable
class SetOnboardingFinishedUseCase {
  final OnboardingLocalDataSource localDataSource;

  SetOnboardingFinishedUseCase(this.localDataSource);

  Future<void> call([bool value = true]) {
    return localDataSource.setFinishedOnboarding(value);
  }
}
