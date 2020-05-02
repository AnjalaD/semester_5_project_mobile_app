import 'package:flutter/material.dart';
import 'package:semester_5_project_mobile_app/util/validators/empty_validator.dart';
import 'package:semester_5_project_mobile_app/util/validators/form_validator.dart';
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
  LatLng markerPosition = LatLng(51.5, -0.09);

  void _setMarker(LatLng point) {
    print(point.toString());
    setState(() {
      markerPosition = point;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              CustomTextField(
                labelText: 'Type',
                validator: Validator.validator([
                  EmptyValidator(),
                ]),
              ),
              CustomTextField(
                labelText: 'Details',
                lines: 3,
              ),
            ],
          ),
        ),
        Step(
          isActive: _step == 1,
          title: Text('Location'),
          subtitle: Text('Location of the incident'),
          content: MapContainer(
            markerPosition: markerPosition,
            onTap: _setMarker,
          ),
        ),
        Step(
          isActive: _step == 2,
          title: Text('Image'),
          subtitle: Text('Image of the incident (optional)'),
          content: Image.asset('image.jpg'),
        ),
        Step(
          state: StepState.complete,
          isActive: _step == 3,
          title: Text('Send'),
          subtitle: Text('Send Report'),
          content: Text('Send report'),
        )
      ],
    );
  }
}
