import 'package:faircare/blocs/auth/register_cubit/register_cubit.dart';
import 'package:faircare/global/constants.dart';
import 'package:faircare/models/register_model.dart';
import 'package:faircare/widgets/dropdown.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterFirstPageWidget extends StatefulWidget {
  const RegisterFirstPageWidget({Key? key}) : super(key: key);

  @override
  State<RegisterFirstPageWidget> createState() => _RegisterFirstPageWidgetState();
}

class _RegisterFirstPageWidgetState extends State<RegisterFirstPageWidget> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterModel>(
      builder: (context, state) {
        final cubit = BlocProvider.of<RegisterCubit>(context);

        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            // name
            MyTextField(
              label: 'Vollständiger Name',
              hint: 'Vollständiger Name',
              controller: nameController,
              onChanged: (name){
                cubit.setName(name);
              },
            ),
            const VerticalSpacer(24),

            // email
            MyTextField(
              label: 'E-Mail',
              hint: 'E-Mail',
              controller: emailController,
              onChanged: (email){
                cubit.setEmail(email);
              },
            ),
            const VerticalSpacer(24),

            // phone
            MyTextField(
              label: 'Telefonnummer',
              hint: 'Telefonnummer',
              controller: phoneController,
              onChanged: (phone){
                cubit.setPhone(phone);
              },
            ),
            const VerticalSpacer(24),

            // address
            MyTextField(
              label: 'Anschrift',
              hint: 'Anschrift',
              controller: addressController,
              onChanged: (address){
                cubit.setAddress(address);
              },
            ),
            const VerticalSpacer(24),

            // qualification
            MyDropdown(
              label: 'Qualifikation',
              value: state.qualification,
              items: qualifications,
              onChanged: (v) {
                if (v == null) return;
                cubit.setQualification(v);
              },
            ),
            const VerticalSpacer(24),

            // driver license
            MyDropdown(
              label: 'Führerschein',
              value: driverLicenseAvailable[state.hasDriversLicense ? 0 : 1],
              items: driverLicenseAvailable,
              onChanged: (v) {
                if (v == null) return;
                cubit.setDriversLicense(v == driverLicenseAvailable[0]);
              },
            ),
          ],
        );
      },
    );
  }
}
