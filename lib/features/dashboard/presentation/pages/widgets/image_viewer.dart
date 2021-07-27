import 'dart:io';

import 'package:barahi/features/dashboard/domain/entities/image_details.dart';
import 'package:barahi/features/dashboard/presentation/bloc/dashboard.dart';
import 'package:barahi/features/registration_or_login/presentation/bloc/registration_or_login.dart';
import 'package:barahi/features/registration_or_login/presentation/pages/register_or_login_page_wrapper.dart';
import 'package:barahi/features/utils/constants/strings.dart';
import 'package:barahi/features/utils/validators.dart';
import 'package:barahi/features/utils/widgets/my_app_button_full_width.dart';
import 'package:barahi/features/utils/widgets/my_app_form_builder_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewerInput {
  final ImageDetails imageDetail;
  final String localImage;

  ImageViewerInput({this.imageDetail, this.localImage});
}

class ImageViewer extends StatefulWidget {
  final ImageViewerInput imageViewerInput;

  const ImageViewer({Key key, this.imageViewerInput}) : super(key: key);

  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  TextEditingController fileNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  FocusNode fileNameFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    if (widget.imageViewerInput.imageDetail != null) {
      fileNameController.text = widget.imageViewerInput.imageDetail.fileName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                "widget.imageViewerInput.imageDetail.fileNam",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: Theme.of(context).disabledColor,
                  fontSize: 14,
                ),
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: ClipRect(
                child: widget.imageViewerInput.localImage != null
                    ? PhotoView(
                        imageProvider: AssetImage(
                          widget.imageViewerInput.localImage,
                        ),
                        minScale: PhotoViewComputedScale.contained * 0.8,
                        maxScale: PhotoViewComputedScale.covered * 2,
                        enableRotation: true,
                        backgroundDecoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Theme.of(context).canvasColor,
                        ),
                        loadingBuilder: (context, event) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : PhotoView(
                        imageProvider: NetworkImage(
                          widget.imageViewerInput.imageDetail.url,
                        ),
                        minScale: PhotoViewComputedScale.contained * 0.8,
                        maxScale: PhotoViewComputedScale.covered * 2,
                        enableRotation: true,
                        backgroundDecoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Theme.of(context).canvasColor,
                        ),
                        loadingBuilder: (context, event) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: MyAppFormBuilderTextField(
                    attribute: fileName,
                    controller: fileNameController,
                    enableSuggestions: false,
                    autoCorrect: false,
                    validators: [Validators.required()],
                    label: fileName,
                    keyboardType: TextInputType.text,
                    focusNode: fileNameFocusNode,
                    onChanged: (val) {
                      setState(() {
                        _formKey.currentState.fields[emailText].currentState
                            .validate();
                      });
                    },
                    onFieldSubmitted: (_) {
                      fieldFocusChange(
                          context, fileNameFocusNode, descriptionFocusNode);
                    },
                  ),
                ),
                Container(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: MyAppFormBuilderTextField(
                    attribute: description,
                    controller: descriptionController,
                    enableSuggestions: false,
                    autoCorrect: false,
                    validators: [Validators.required()],
                    label: description,
                    focusNode: descriptionFocusNode,
                    onChanged: (val) {
                      setState(() {
                        _formKey.currentState.fields[description].currentState
                            .validate();
                      });
                    },
                    onFieldSubmitted: (_) {
                      fieldFocusChange(
                          context, fileNameFocusNode, descriptionFocusNode);
                    },
                  ),
                ),
                widget.imageViewerInput.imageDetail != null
                    ? Text(widget.imageViewerInput.imageDetail.uploadedAt)
                    : Container(),
                Container(
                  height: 16,
                ),
                Container(
                  height: 16,
                ),
                BlocBuilder<RegistrationOrLoginBloc, RegistrationOrLoginState>(
                  builder: (context, state) {
                    return MyAppButtonFullWidth(
                        text: signInButtonText,
                        showCircularProgressIndicator:
                            (state is RegistrationOrLoginProcessingState)
                                ? true
                                : false,
                        onPressed: () {
                          print("I am tapped");
                          print(widget.imageViewerInput.localImage != null);

                          if (widget.imageViewerInput.localImage != null) {
                            BlocProvider.of<DashboardBloc>(context).add(
                                UploadImage(
                                    imageDetails: ImageDetails(

                                      fileName: fileNameController.text,
                                    ),
                                    uploadImageTo: UPLOAD_IN));
                          } else {
                            BlocProvider.of<DashboardBloc>(context).add(
                                DeleteAndUploadNew(
                                    imageDetails:widget.imageViewerInput.imageDetail,
                                    uploadImageTo: UPLOAD_IN));
                          }
                        });
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
