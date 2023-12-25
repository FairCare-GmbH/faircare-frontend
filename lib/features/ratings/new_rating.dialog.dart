import 'package:dio/dio.dart';
import 'package:faircare/features/ratings/new_rating_bloc.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/widgets/loading_indicator.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../api/api.dart';
import '../../api/api_exception.dart';
import '../../global/fc_colors.dart';
import '../../widgets/button.dart';
import '../../widgets/dropdown.dart';
import '../../widgets/snack_bar.dart';

class NewRatingDialog extends StatelessWidget {
  NewRatingDialog({Key? key, required this.forPatientId}) : super(key: key);

  final int forPatientId;

  final commentsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewRatingBloc>(
        create: (_) =>
            NewRatingBloc()..add(GetNursesForPatient(patientId: forPatientId)),
        child: BlocBuilder<NewRatingBloc, NewRatingState>(
          builder: (context, state) {
            if (state is NewRatingDataLoaded) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyDropdown(
                      label: 'Pfleger:in',
                      value: state.selectedIndex == -1
                          ? 'Alle (${state.nurses.length} Pfleger:innen)'
                          : '${state.nurses[state.selectedIndex].lastName}, ${state.nurses[state.selectedIndex].firstName} (${state.nurses[state.selectedIndex].metric ?? 0} Einsätze)',
                      items: [
                        'Alle (${state.nurses.length} Pfleger:innen)',
                        ...state.nurses.map((e) =>
                            '${e.lastName}, ${e.firstName} (${e.metric ?? 0} Einsätze)')
                      ],
                      onChanged: (v) {
                        if (v == null) return;
                        BlocProvider.of<NewRatingBloc>(context).add(UpdateState(
                            newState: NewRatingDataLoaded(
                                nurses: state.nurses,
                                rating: state.rating,
                                isPatientFeedback: state.isPatientFeedback,
                                selectedIndex: v ==
                                        'Alle (${state.nurses.length} Pfleger:innen)'
                                    ? -1
                                    : state.nurses.indexWhere((e) =>
                                        '${e.lastName}, ${e.firstName} (${e.metric ?? 0} Einsätze)' ==
                                        v))));
                      },
                    ),
                    const VerticalSpacer(16),
                    RatingBar.builder(
                      initialRating: 0,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return const Icon(
                              Icons.sentiment_very_dissatisfied,
                              color: Colors.red,
                            );
                          case 1:
                            return const Icon(
                              Icons.sentiment_dissatisfied,
                              color: Colors.redAccent,
                            );
                          case 2:
                            return const Icon(
                              Icons.sentiment_neutral,
                              color: Colors.amber,
                            );
                          case 3:
                            return const Icon(
                              Icons.sentiment_satisfied,
                              color: Colors.lightGreen,
                            );
                          case 4:
                            return const Icon(
                              Icons.sentiment_very_satisfied,
                              color: Colors.green,
                            );
                          default:
                            throw Exception('shouldn\'t happen');
                        }
                      },
                      onRatingUpdate: (rating) {
                        BlocProvider.of<NewRatingBloc>(context).add(UpdateState(
                            newState: NewRatingDataLoaded(
                                nurses: state.nurses,
                                rating: rating.toInt(),
                                selectedIndex: state.selectedIndex,
                                isPatientFeedback: state.isPatientFeedback)));
                      },
                    ),
                    const VerticalSpacer(16),
                    SizedBox(
                      height: 80,
                      child: TextField(
                        decoration: const InputDecoration(
                            hintText: 'Kommentar (Optional)'),
                        maxLines: null,
                        expands: true,
                        keyboardType: TextInputType.multiline,
                        controller: commentsController,
                      ),
                    ),
                    const VerticalSpacer(16),
                    CheckboxListTile(
                      value: state.isPatientFeedback,
                      onChanged: (bool? v) {
                        BlocProvider.of<NewRatingBloc>(context).add(UpdateState(
                            newState: NewRatingDataLoaded(
                                nurses: state.nurses,
                                rating: state.rating,
                                selectedIndex: state.selectedIndex,
                                isPatientFeedback: v ?? !state.isPatientFeedback)));
                      },
                      title: const Text('Nur Patienten-Feedback'),
                    ),
                    const VerticalSpacer(16),
                    Button(
                      'Bewertung Abgeben',
                      buttonColor: FCColors.green,
                      onPressed: () {
                        Api.request('/nurses/rate/',
                            options: Options(method: 'POST'),
                            data: {
                              "rating": state.rating,
                              "ratingPatientId": forPatientId,
                              "ratedNurseIds": state.selectedIndex == -1
                                  ? state.nurses.map((e) => e.nurseId).toList()
                                  : [state.nurses[state.selectedIndex].nurseId],
                              "isPatientFeedback": state.isPatientFeedback,
                              "comments": commentsController.value.text
                            }).then((value) {
                          showSnackBar(
                            context,
                            'Bewertung abgegeben.',
                            icon: Icons.save,
                          );
                          pop(context, true);
                        }).onError((error, stackTrace) {
                          if (error is ApiException) {
                            error.showDialog(context);
                          } else if (kDebugMode) {
                            print(error);
                            print(stackTrace);
                          }
                        });
                      },
                    ),
                  ],
                ),
              );
            }
            return const LoadingIndicator();
          },
        ));
  }
}

void showNewRatingDialog(BuildContext context, int forPatient) {
  showDialog(
    context: context,
    builder: (_) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: NewRatingDialog(forPatientId: forPatient),
      );
    },
  );
}
