import 'package:dartz/dartz.dart';

import '../errors/failures.dart';

/// For UseCase implementation
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

// NoParam used when parameter not needed in UseCase
class NoParams {}
