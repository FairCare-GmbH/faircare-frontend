import 'package:faircare/blocs/progress/register_progress_cubit.dart';
import 'package:faircare/views/register/register_page_1.dart';
import 'package:faircare/views/register/register_page_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPages extends StatelessWidget {
  const RegisterPages(this.controller, {Key? key}) : super(key: key);

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: PageView(
        controller: controller,
        children: const [
          RegisterFirstPage(),
          RegisterSecondPage(),
        ],
        onPageChanged: (v) {
          BlocProvider.of<RegisterProgressCubit>(context).setPage(v);
        },
      ),
    );
  }
}
