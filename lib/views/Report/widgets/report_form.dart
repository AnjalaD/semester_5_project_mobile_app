import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester_5_project_mobile_app/models/incident_report.dart';
import 'package:semester_5_project_mobile_app/services/authentication.dart';
import 'package:semester_5_project_mobile_app/util/classes/report_category.dart';
import 'package:semester_5_project_mobile_app/util/request_handler.dart';
import 'package:semester_5_project_mobile_app/views/Report/widgets/add_image.dart';
import 'package:semester_5_project_mobile_app/widgets/custom_text_field.dart';
import 'package:semester_5_project_mobile_app/widgets/map_container.dart';
import 'package:latlong/latlong.dart';

class ReportForm extends StatefulWidget {
  const ReportForm({
    Key key,
  }) : super(key: key);

  @override
  _ReportFormState createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  int _step = 0;

  final _description = TextEditingController();
  final _title = TextEditingController();
  final _category = ReportCategory();
  File _image;
  LatLng _markerPosition;

  void _setMarker(LatLng point) {
    setState(() {
      _markerPosition = point;
    });
  }

  void _addImageOnChanged(File newImage) {
    _image = newImage;
  }

  Function _sendReport(Authentication auth) => () async {
        print('sendReport');
        IncidentReport report = new IncidentReport(
          categories: _category,
          title: _title.text,
          description: _description.text,
          location: _markerPosition,
          image: _image,
        );

        auth.isLoading = true;
        bool res = await ApiRequestHandler.sendReport(
            incidentReport: report, token: auth.proxyUser.token);
        auth.isLoading = false;
        print('sendReport res: $res');
      };

  @override
  Widget build(BuildContext context) {
    Authentication auth = Provider.of<Authentication>(context);

    return Stepper(
      onStepTapped: (int step) {
        setState(() {
          _step = step;
        });
      },
      currentStep: _step,
      onStepContinue: () {
        if (_step >= 3) return;
        setState(() {
          _step++;
        });
      },
      onStepCancel: () {
        if (_step == 0) return;
        setState(() {
          _step--;
        });
      },
      steps: <Step>[
        Step(
          isActive: _step == 0,
          title: Text('Details'),
          subtitle: Text('Enter details'),
          content: Column(
            children: <Widget>[
              Wrap(
                children: _buildTypes(),
              ),
              CustomTextField(
                labelText: 'Title',
                textEditingController: _title,
              ),
              CustomTextField(
                labelText: 'Details',
                lines: 3,
                textEditingController: _description,
              ),
            ],
          ),
        ),
        Step(
          isActive: _step == 1,
          title: Text('Location'),
          subtitle: Text('Location of the incident'),
          content: Container(
            height: 300,
            child: MapContainer(
              markerPosition: _markerPosition,
              onTap: _setMarker,
              tappable: true,
            ),
          ),
        ),
        Step(
          isActive: _step == 2,
          title: Text('Image'),
          subtitle: Text('Image of the incident (optional)'),
          content: AddImage(
            onChange: _addImageOnChanged,
          ),
        ),
        Step(
          state: StepState.complete,
          isActive: _step == 3,
          title: Text('Send'),
          subtitle: Text('Send Report'),
          content: Container(),
        ),
      ],
      physics: ClampingScrollPhysics(),
      controlsBuilder: (context, {onStepCancel, onStepContinue}) => ButtonBar(
        buttonMinWidth: 100,
        children: <Widget>[
          OutlineButton(
            child: Text('Back'),
            onPressed: onStepCancel,
          ),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            child: Text(_step == 3 ? 'Submit' : 'Next'),
            onPressed: _step == 3 ? _sendReport(auth) : onStepContinue,
          )
        ],
      ),
    );
  }

  List<Widget> _buildTypes() {
    List<Widget> chips = [];
    ReportCategory.types.forEach((name, value) {
      Widget chip = InputChip(
        showCheckmark: false,
        selectedColor: Theme.of(context).primaryColor,
        label: Text(name),
        selected: _category.selected.contains(value),
        onSelected: (selected) {
          setState(() {
            if (selected) {
              _category.add(value);
            } else {
              _category.remove(value);
            }
          });
        },
      );
      chips.add(chip);
    });
    return chips;
  }
}
