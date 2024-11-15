import 'package:faircare/api/api.dart';
import 'package:faircare/features/users/ratings_bloc.dart';
import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/loading_indicator.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDataWidget extends StatelessWidget {
  const UserDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RatingsBloc, RatingsState>(
      builder: (context, state) {
        if (Api.getUser() != null) {
          final data = Api.getUser()!;
          return Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: const Icon(Icons.person, size: 48),
                    // child: CachedNetworkImage(
                    //   imageUrl: 'https://thispersondoesnotexist.com/',
                    //   width: 48,
                    // ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: -4,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: FCColors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color: FCColors.black.withOpacity(0.1),
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.photo_camera,
                        size: 14,
                      ),
                    ),
                  )
                ],
              ),
              const HorizontalSpacer(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.firstName} ${data.lastName}',
                      style: style(
                        fontSize: 18,
                        color: FCColors.black,
                      ),
                    ),
                    Text(
                      data.email,
                      style: style(
                        color: FCColors.darkGrey,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }
        return const LoadingIndicator();
      },
    );
  }
}
