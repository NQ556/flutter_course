import 'package:fpdart/fpdart.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<Exception, SuccessType>> call(Params params);
}

class NoParams {}
