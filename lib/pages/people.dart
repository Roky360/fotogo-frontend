import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'create_album/create_album_view.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PeoplePage extends StatefulWidget {
  const PeoplePage({Key? key}) : super(key: key);

  @override
  _PeoplePageState createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  @override
  Widget build(BuildContext context) {
    // return Container(color: Colors.pinkAccent,);


    // return SfDateRangePicker(
    //   // backgroundColor: Colors.white,
    //   showActionButtons: true,
    // );

    return Center(
      child: TextButton(
          onPressed: () {
            // showDialog(
            //     context: context,
            //     builder: (context) {
            //       return DatePickerDialog(initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now());
            //     },
            //     barrierDismissible: true,
            //     useSafeArea: true,
            //     barrierColor: Colors.transparent
            // );

            // showDialog(
            //     context: context,
            //     builder: (context) {
            //       return SfDateRangePicker(
            //         backgroundColor: Colors.white,
            //         showActionButtons: true,
            //       );
            //     },
            //     barrierDismissible: true,
            //     useSafeArea: true,
            //     barrierColor: Colors.transparent
            // );

            showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime(2022, 12, 31), initialDate: DateTime.now());
          },
          child: Text('otekptea')),
    );

    // return DateRangePickerDialog(
    //   firstDate: DateTime.now(),
    //   lastDate: DateTime.now(),
    // );
  }
}
