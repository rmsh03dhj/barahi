import 'dart:io';

import 'package:barahi/core/routes/my_app_routes.dart';
import 'package:barahi/core/services/navigation_service.dart';
import 'package:barahi/core/services/service_locator.dart';
import 'package:barahi/features/utils/widgets/my_app_button.dart';
import 'package:intl/intl.dart';
import 'package:barahi/features/dashboard/domain/entities/image_details.dart';
import 'package:barahi/features/dashboard/presentation/bloc/dashboard.dart';
import 'package:barahi/features/utils/constants/strings.dart';
import 'package:barahi/features/utils/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewerInput {
  final ImageDetails? imageDetail;
  final String? localImage;

  ImageViewerInput({this.imageDetail, this.localImage});
}

class ImageViewer extends StatefulWidget {
  final ImageViewerInput? imageViewerInput;

  const ImageViewer({this.imageViewerInput});

  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  TextEditingController fileNameController = TextEditingController();
  FocusNode fileNameFocusNode = FocusNode();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final _navigateService = sl<NavigationService>();

  @override
  void initState() {
    super.initState();
    if (widget.imageViewerInput!.imageDetail != null) {
      fileNameController.text = widget.imageViewerInput!.imageDetail!.fileName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(listener: (context, state) {
      if (state is DashboardError) {
        Scaffold.of(context)
          ..showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 5),
            ),
          );
      }
      if (state is ImageUploadedState || state is ImageDetailsUpdatedState) {
        BlocProvider.of<DashboardBloc>(context)..add(ListImages());
        _navigateService.navigateToAndRemoveUntil(MyAppRoutes.dashboard);
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
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
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: ClipRect(
                  child: widget.imageViewerInput!.localImage != null
                      ? PhotoView(
                          imageProvider: AssetImage(
                            widget.imageViewerInput!.localImage!,
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
                            widget.imageViewerInput!.imageDetail!.url,
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
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).orientation == Orientation.landscape
                              ? MediaQuery.of(context).size.width * 0.75
                              : MediaQuery.of(context).size.width * 0.6,
                          child: FormBuilderTextField(
                            name: fileName,
                            controller: fileNameController,
                            enableSuggestions: false,
                            autocorrect: false,
                            // validators: [Validators.required()],
                            keyboardType: TextInputType.text,
                            focusNode: fileNameFocusNode,
                            onChanged: (val) {
                              setState(() {
                                _formKey.currentState?.fields[emailText]?.validate();
                              });
                            },
                            onSubmitted: (_) {
                              submit();
                            },
                          ),
                        ),
                      ),
                      BlocBuilder<DashboardBloc, DashboardState>(
                        builder: (context, state) {
                          return SizedBox(
                            width: MediaQuery.of(context).orientation == Orientation.landscape
                                ? MediaQuery.of(context).size.width * 0.2
                                : MediaQuery.of(context).size.width * 0.3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MyAppButton(
                                  text: saveButtonText,
                                  showCircularProgressIndicator:
                                      (state is DashboardLoading) ? true : false,
                                  onPressed: submit),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  void submit() {
    if (widget.imageViewerInput!.localImage != null) {
      BlocProvider.of<DashboardBloc>(context).add(
        UploadImage(
          fileName: fileNameController.text,
          file: File(widget.imageViewerInput!.localImage!),
        ),
      );
    } else {
      BlocProvider.of<DashboardBloc>(context).add(UpdateImageDetails(
          imageDetails:
              widget.imageViewerInput!.imageDetail!.copyWith(fileName: fileNameController.text)));
    }
  }
}
