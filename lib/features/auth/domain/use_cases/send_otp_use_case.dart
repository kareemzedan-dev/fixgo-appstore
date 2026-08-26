import 'package:injectable/injectable.dart';

import '../repos/auth_repo.dart';
@injectable
class SendOtpUseCase {
  final AuthRepo authRepo;

  SendOtpUseCase(this.authRepo);

  Future<String> call(String phone) async {
    return await authRepo.sendOtp(phone);
  }
}