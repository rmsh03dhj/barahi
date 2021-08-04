import 'package:dartz/dartz.dart';
import 'package:barahi/core/error/failure.dart';

abstract class BaseUseCase<TResult, TParams> {
  Future<Either<Failure, TResult>> execute(TParams params);
}
