import 'package:graphql/client.dart';

class GraphQLService{
GraphQLClient graphQLClient() {
  final _httpLink = HttpLink(
    uri: 'https://countries.trevorblades.com/',
  );

  return GraphQLClient(
    cache: InMemoryCache(),
    link: _httpLink,
  );
}
}