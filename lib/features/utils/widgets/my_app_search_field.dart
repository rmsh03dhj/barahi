import 'package:barahi/features/dashboard/presentation/bloc/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyAppSearchField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged onChanged;
  final FocusNode focusNode;
  final String hintText;
  final ValueChanged<String> onFieldSubmitted;
  final GestureTapCallback onTap;

  MyAppSearchField({
    this.controller,
    this.onChanged,
    this.focusNode,
    this.onFieldSubmitted,
    this.hintText,
    this.onTap,
  });

  @override
  _MyAppSearchFieldState createState() => _MyAppSearchFieldState();
}

class _MyAppSearchFieldState extends State<MyAppSearchField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      autocorrect: false,
      decoration: InputDecoration(
        filled: true,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        prefixIcon: Icon(Icons.search, size: 24, color: Colors.tealAccent),
        suffixIcon: widget.controller.text.isNotEmpty
            ? IconButton(
                icon: Icon(FontAwesomeIcons.timesCircle, color: Colors.tealAccent),
                onPressed: () {
                  setState(() {
                    BlocProvider.of<DashboardBloc>(context).add(ListImages());
                    widget.controller.clear();
                  });
                },
              )
            : null,
        hintText: widget.hintText,
      ),
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      onTap: widget.onTap,
    );
  }
}
