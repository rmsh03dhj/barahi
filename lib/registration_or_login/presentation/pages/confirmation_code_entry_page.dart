import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:barahi/core/navigation_service.dart';
import 'package:barahi/core/routes/gimme_now_routes.dart';
import 'package:barahi/core/service_locator.dart';
import 'package:barahi/registration_or_login/data/models/user.dart';
import 'package:barahi/registration_or_login/presentation/bloc/registration_or_login_bloc.dart';
import 'package:barahi/registration_or_login/presentation/bloc/registration_or_login_event.dart';
import 'package:barahi/registration_or_login/presentation/bloc/registration_or_login_state.dart';
import 'package:barahi/utils/gimme_now_button.dart';
import 'package:barahi/utils/gimme_now_text_form_field.dart';
import 'package:barahi/utils/validators.dart';

class ConfirmCodeEntryPageWrapper extends StatelessWidget {
  final User user;

  ConfirmCodeEntryPageWrapper(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConfirmCodeEntryPage(user),
    );
  }
}

class ConfirmCodeEntryPage extends StatefulWidget {
  final User user;

  const ConfirmCodeEntryPage(this.user);

  @override
  _ConfirmCodeEntryPageState createState() => _ConfirmCodeEntryPageState();
}

class _ConfirmCodeEntryPageState extends State<ConfirmCodeEntryPage> {
  TextEditingController _confirmationCodeController = TextEditingController();
  FocusNode _confirmationCodeFocusNode = FocusNode();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final _navigateService = sl<NavigationService>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationOrLoginBloc, RegistrationOrLoginState>(
      listener: (context, state) {
        if (state is SignUpFailedState) {
          Scaffold.of(context)
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 5),
              ),
            );
        }
        if (state is SignUpSuccessState) {
          _navigateService.navigateTo(GimmeNowRoutes.dashboard, arguments: state.email);
        }
      },
      child: SingleChildScrollView(
        child: BlocBuilder<RegistrationOrLoginBloc, RegistrationOrLoginState>(
            builder: (context, state) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: FormBuilder(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Please enter the code you received via email.",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                height: 16,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GimmeNowFormBuilderTextField(
                                  attribute: "confirmationCode",
                                  controller: _confirmationCodeController,
                                  enableSuggestions: false,
                                  label: "Code",
                                  validators: [
                                    Validators.required(),
                                  ],
                                  keyboardType: TextInputType.number,
                                  focusNode: _confirmationCodeFocusNode,
                                  onChanged: (val) {
                                    setState(() {
                                      _formKey.currentState.fields["confirmationCode"].currentState
                                          .validate();
                                    });
                                  },
                                ),
                              ),
                              Container(
                                height: 16,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GimmeNowButton(
                                  text: "Confirm Code",
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      BlocProvider.of<RegistrationOrLoginBloc>(context).add(
                                        ConfirmCodeEntered(
                                          _confirmationCodeController.text,
                                          widget.user.email,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              Container(
                                height: 16,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GimmeNowButton(
                                  text: "Resend code",
                                  textColor: Colors.black,
                                  buttonColor: Colors.white,
                                  borderColor: Theme.of(context).primaryColor,
                                  onPressed: () {
                                    BlocProvider.of<RegistrationOrLoginBloc>(context).add(
                                      ResentButtonPressed(
                                        widget.user.email,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                height: 16,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: _showSignInPage,
                                    child: Text(
                                      "Already have an account?",
                                      style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ]);
        }),
      ),
    );
  }

  void dispose() {
    _confirmationCodeController.dispose();
    _confirmationCodeFocusNode.dispose();
    super.dispose();
  }

  void _showSignInPage() {
    Navigator.of(context).pushNamed(GimmeNowRoutes.signUp);
  }
}
