import 'package:dartz/dartz.dart';
import 'package:barahi/failure.dart';
import 'package:barahi/continent/model/continent.dart';
import 'package:barahi/service/graphql_service.dart';
import 'package:barahi/service_locator.dart';
import 'package:gql/language.dart';
import 'package:graphql/client.dart';

import '../query/continent_query.dart' as query;
import 'base_use_case.dart';

abstract class GetContinentsUseCase
    implements BaseUseCase<List<Continent>, NoParams> {}

class GetContinentsUseCaseImpl implements GetContinentsUseCase {
  final graphQLService = sl<GraphQLService>();
  @override
  Future<Either<Failure, List<Continent>>> execute(NoParams noParams) async {
    try {
      final _options = WatchQueryOptions(
        documentNode: parseString(query.continentQuery),
        fetchResults: true,
      );
      final result = await graphQLService.graphQLClient().query(_options);
      return Right(Continents.fromJson(result.data).continents);
    } catch (e) {
      print(e);
      throw e;
    }
  }
}

class NoParams {}
