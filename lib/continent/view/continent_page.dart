import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/continent_bloc.dart';

class ContinentPage extends StatefulWidget {
  const ContinentPage({Key key}) : super(key: key);

  @override
  _ContinentPageState createState() => _ContinentPageState();
}

class _ContinentPageState extends State<ContinentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter GraphQL'),
      ),
      body: Container(
        child: BlocBuilder<ContinentBloc, ContinentState>(
          builder: (_, state) {
            if (state is ContinentLoading) {
              return Center(
                child: const CircularProgressIndicator(),
              );
            } else if (state is ContinentLoaded) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.continents.length,
                itemBuilder: (_, index) {
                  var continent = state.continents[index];
                  return Text(
                    continent.name,
                    style: TextStyle(height: 1.5),
                  );
                },
              );
            } else if (state is ContinentError) {
              return Center(
                child: Text(state.errorMessage),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
