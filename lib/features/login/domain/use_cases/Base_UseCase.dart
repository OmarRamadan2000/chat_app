import 'package:chat_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class BaseUseCase<Type, Param> {
  Future<Either<Failure, Type>> call([Param? param]);
}
