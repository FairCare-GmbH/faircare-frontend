import 'package:faircare/blocs/auth/progress/register_progress_cubit.dart';
import 'package:faircare/features/register/pages/register_page_1.widget.dart';
import 'package:faircare/features/register/pages/register_page_2.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPagesWidget extends StatelessWidget {
  const RegisterPagesWidget(this.controller, {Key? key}) : super(key: key);

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          RegisterFirstPageWidget(),
          RegisterSecondPageWidget(),
        ],
        onPageChanged: (v) {
          BlocProvider.of<RegisterProgressCubit>(context).setPage(v);
        },
      ),
    );
  }
}
