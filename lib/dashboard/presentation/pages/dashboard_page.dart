import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barahi/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:barahi/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:barahi/utils/gimme_now_scaffold_with_drawer.dart';

class DashBoardPageWrapper extends StatelessWidget {
  final String email;

  const DashBoardPageWrapper(this.email);
  @override
  Widget build(BuildContext context) {
    return GimmeNowScaffoldWithDrawer(
      body: DashBoardPage(email),
    );
  }
}

class DashBoardPage extends StatefulWidget {
  final String email;
  DashBoardPage(this.email);

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashBoardBloc, DashboardState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 16,
              ),
              Text(
                "Welcome to the app ${widget.email}",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      },
    );
  }

  void dispose() {
    super.dispose();
  }
}
