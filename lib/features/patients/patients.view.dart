import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/loading_indicator.dart';
import '../my_tours/patient_visit_list_item.widget.dart';
import 'patients.bloc.dart';
import 'patients_app_bar.widget.dart';

class PatientsView extends StatelessWidget {
  const PatientsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PatientsAppBarWidget(),
        BlocProvider(
          create: (context) => PatientsBloc()..add(GetMyPatients()),
          child: BlocBuilder<PatientsBloc, MyPatientsState>(
            builder: (context, state) {
              if (state is MyPatientsLoaded) {
                return Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    children: [
                      const MyHeading('Meine Patienten'),
                      const VerticalSpacer(12),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (a, b) => const VerticalSpacer(10),
                        itemCount: state.patients.length,
                        itemBuilder: (_, i) {
                          return PatientVisitListItemWidget(
                              patient: state.patients[i]);
                        },
                      ),
                    ],
                  ),
                );
              }
              return const LoadingIndicator();
            },
          ),
        )
      ],
    );
  }
}
