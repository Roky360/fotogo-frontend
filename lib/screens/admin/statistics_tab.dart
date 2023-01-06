import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/admin/admin_service.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:fotogo/widgets/section.dart';

import '../../admin/admin_data_types.dart';
import '../../admin/bloc/admin_bloc.dart';

class StatisticsTab extends StatelessWidget {
  final AdminService _adminService = AdminService();

  StatisticsTab({Key? key}) : super(key: key);

  Widget statisticItem(BuildContext context, String title, final value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontWeight: FontWeight.normal)),
          const Spacer(),
          Text(value.toString(), style: Theme.of(context).textTheme.headline6),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminBloc, AdminState>(
      builder: (context, state) {
        if ((state is StatisticsFetched || state is UsersFetched) &&
            _adminService.appStatistics != null) {
          final AppStatistics appStatistics = _adminService.appStatistics!;

          return FotogoSection(
              title: "General statistics",
              body: Column(
                children: [
                  statisticItem(
                      context, "Total users", appStatistics.usersCount),
                  statisticItem(
                      context, "Total albums", appStatistics.albumsCount),
                  statisticItem(
                      context, "Total photos", appStatistics.imagesCount),
                  statisticItem(
                      context,
                      "Average albums per user",
                      (appStatistics.albumsCount / appStatistics.usersCount)
                          .round()),
                  statisticItem(
                      context,
                      "Average photos per album",
                      (appStatistics.imagesCount / appStatistics.albumsCount)
                          .round()),
                  const SizedBox(height: 75),
                ],
              ));
        } else {
          // loading
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppWidgets.fotogoCircularLoadingAnimation(),
              const SizedBox(height: 20),
              Text(
                "Generating statistics...",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontWeight: FontWeight.normal),
              )
            ],
          );
        }
      },
    );
  }
}
