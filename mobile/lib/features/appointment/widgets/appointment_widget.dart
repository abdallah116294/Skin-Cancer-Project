import 'package:flutter/material.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/helper/date_converter.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/features/clinic/data/model/selected_clinic_model.dart';

class AppointmentWidget extends StatefulWidget {
  List<SelectedClinicModel> clincs;
   AppointmentWidget(
      {super.key,
      required this.clincs});

  @override
  State<AppointmentWidget> createState() => _AppointmentWidgetState();
}

class _AppointmentWidgetState extends State<AppointmentWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) {
            DateTime dateTime = DateTime.parse(widget.clincs[index].date.toString());
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  context.pushNamed(Routes.aIHistoryScreen,
                      arguments:widget.clincs[index].userId);
                },
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5.0,
                            spreadRadius: 0.0)
                      ]),
                  child: ListTile(
                    title: Text(widget.clincs[index].name.toString()),
                    subtitle:
                        Text(DateConverter.getDateTimeWithMonth(dateTime)),
                    trailing: Text(widget.clincs[index].clinicName.toString()),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: widget.clincs.length),
    );
  }
}
