import 'package:barahi/core/routes/my_app_routes.dart';
import 'package:barahi/core/services/navigation_service.dart';
import 'package:barahi/core/services/service_locator.dart';
import 'package:barahi/features/dashboard/presentation/bloc/dashboard.dart';
import 'package:barahi/features/registration_or_login/presentation/bloc/registration_or_login.dart';
import 'package:barahi/features/utils/constants/strings.dart';
import 'package:barahi/features/utils/validators.dart';
import 'package:barahi/features/utils/widgets/my_app_button_full_width.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

class RegistrationOrLoginPage extends StatefulWidget {
  RegistrationOrLoginPage();

  @override
  _RegistrationOrLoginPageState createState() =>
      _RegistrationOrLoginPageState();
}

class RegistrationOrLoginPageWrapper extends StatelessWidget {
  const RegistrationOrLoginPageWrapper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegistrationOrLoginPage(),
    );
  }
}

class _RegistrationOrLoginPageState extends State<RegistrationOrLoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _confirmPasswordFocusNode = FocusNode();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool _passwordVisible = true;
  bool _confirmPasswordVisible = true;
  final _navigateService = sl<NavigationService>();
  bool _signIn = true;

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
      if (state is SignInFailedState) {
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
        BlocProvider.of<DashboardBloc>(context)..add(ListImages());
        _navigateService.navigateToAndRemoveUntil(MyAppRoutes.dashboard);
      }
      if (state is SignInSuccessState) {
        BlocProvider.of<DashboardBloc>(context)..add(ListImages());
        _navigateService.navigateToAndRemoveUntil(MyAppRoutes.dashboard);
      }
    }, child: SingleChildScrollView(
      child: BlocBuilder<RegistrationOrLoginBloc, RegistrationOrLoginState>(
          builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                "assets/launcher_icon.jpg",
                scale: 1.5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: FormBuilder(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: FormBuilderTextField(
                              name: emailText,
                              controller: _emailController,
                              enableSuggestions: false,
                              autocorrect: false,
                              validator: FormBuilderValidators.compose([
                                Validators.required(),
                                Validators.emailValidator(),
                              ]),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: emailText,
                                border: new OutlineInputBorder(
                                    borderSide:
                                    new BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).accentColor)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                errorStyle: TextStyle(
                                  color: Colors.red,
                                ),
                                prefixIcon: Icon(Icons.person),
                              ),
                              focusNode: _emailFocusNode,
                              onChanged: (val) {
                                setState(() {
                                  _formKey.currentState?.fields[emailText]
                                      ?.validate();
                                });
                              },
                              onSubmitted: (_) {
                                fieldFocusChange(context, _emailFocusNode,
                                    _passwordFocusNode);
                              },
                            ),
                          ),
                          Container(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: FormBuilderTextField(
                              name: passwordText,
                              decoration: InputDecoration(
                                labelText: passwordText,
                                border: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).accentColor)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                errorStyle: TextStyle(
                                  color: Colors.red,
                                ),
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                              controller: _passwordController,
                              obscureText: _passwordVisible,
                              validator: FormBuilderValidators.compose([
                                Validators.required(),
                                Validators.length(),
                              ]),
                              keyboardType: TextInputType.text,
                              focusNode: _passwordFocusNode,
                              onSubmitted: (_) {
                                if (_signIn) {
                                  FocusScope.of(context).unfocus();
                                  onPressed();
                                } else {
                                  fieldFocusChange(context, _emailFocusNode,
                                      _passwordFocusNode);
                                }
                              },
                              onChanged: (val) {
                                setState(() {
                                  _formKey.currentState?.fields[passwordText]
                                      ?.validate();
                                });
                              },
                            ),
                          ),
                          !_signIn
                              ? Container(
                                  height: 16,
                                )
                              : Container(),
                          !_signIn
                              ? FormBuilderTextField(
                                  name: confirmPasswordText,
                                  decoration: InputDecoration(
                                    labelText: confirmPasswordText,
                                    border: new OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.grey)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        borderSide: BorderSide(
                                            color:
                                                Theme.of(context).accentColor)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    errorStyle: TextStyle(
                                      color: Colors.red,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _confirmPasswordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _confirmPasswordVisible =
                                              !_confirmPasswordVisible;
                                        });
                                      },
                                    ),
                                    prefixIcon: Icon(Icons.lock),
                                  ),
                                  controller: _confirmPasswordController,
                                  obscureText: _confirmPasswordVisible,
                                  validator: FormBuilderValidators.compose([
                                    Validators.required(),
                                    Validators.confirmPasswordMatchWithPassword(
                                        _passwordController.text)
                                  ]),
                                  keyboardType: TextInputType.text,
                                  focusNode: _confirmPasswordFocusNode,
                                  onSubmitted: (_) {
                                    FocusScope.of(context).unfocus();
                                    onPressed();
                                  },
                                  onChanged: (val) {
                                    setState(() {
                                      _formKey.currentState
                                          ?.fields[confirmPasswordText]
                                          ?.validate();
                                    });
                                  },
                                )
                              : Container(),
                          Container(
                            height: 16,
                          ),
                          BlocBuilder<RegistrationOrLoginBloc,
                                  RegistrationOrLoginState>(
                              builder: (context, state) {
                            return MyAppButtonFullWidth(
                              text:
                                  _signIn ? signInButtonText : signUpButtonText,
                              showCircularProgressIndicator:
                                  (state is RegistrationOrLoginProcessingState)
                                      ? true
                                      : false,
                              showTickSymbol: (state is SignInSuccessState ||
                                      state is SignUpSuccessState)
                                  ? true
                                  : false,
                              onPressed: onPressed,
                            );
                          }),
                          Container(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _signIn = !_signIn;
                                  });
                                },
                                child: Text(
                                  _signIn ? signUpButtonText : signInButtonText,
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    ));
  }

  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordController.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void onPressed() {
    if (_formKey.currentState!.validate()) {
      if (_signIn) {
        BlocProvider.of<RegistrationOrLoginBloc>(context).add(SignInPressed(
          _emailController.text,
          _passwordController.text,
        ));
      } else {
        BlocProvider.of<RegistrationOrLoginBloc>(context).add(SignUpPressed(
          _emailController.text,
          _passwordController.text,
        ));
      }
    }
  }
}
