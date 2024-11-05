import 'package:demo_app/features/auth/bloc/auth_bloc.dart';
import 'package:demo_app/features/check_in/bloc/check_in_bloc.dart';
import 'package:demo_app/utils/app_utils.dart';
import 'package:demo_app/utils/res/app_strings.dart';
import 'package:demo_app/views/widgets/primary_btn_widget.dart';
import 'package:demo_app/views/widgets/switch_widget.dart';
import 'package:demo_app/views/widgets/text_ff_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  late TextEditingController _notesC;

  @override
  void initState() {
    super.initState();
    _notesC = TextEditingController();
    context.read<CheckInBloc>().add(LoadCheckInHistory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.dailyChkIn),
        actions: [
          IconButton(
              onPressed: () async {
                final res = await AppUtils.showConfirmDilogue(
                  AppStrings.logout,
                  AppStrings.logoutDesc,
                  confirmLabel: AppStrings.yes,
                  cancelLabel: AppStrings.no,
                );
                if (res == null) return;
                if (res) context.read<AuthBloc>().add(SignOutRequested());
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: AppUtils.hrPadding,
        child: BlocBuilder<CheckInBloc, CheckInState>(
          builder: (context, state) {
            if (state is CheckInHistoryLoaded) {
              if (state.checkIns.isEmpty) {
                return const Center(child: Text(AppStrings.notChkIn));
              }
              return ListView.builder(
                itemCount: state.checkIns.length,
                itemBuilder: (context, index) {
                  final checkIn = state.checkIns[index];
                  return ListTile(
                    title: Text(
                      checkIn.gambledToday
                          ? AppStrings.gamble
                          : AppStrings.notGambled,
                    ),
                    subtitle: Text(checkIn.notes),
                    trailing: Text(
                      '${checkIn.date.day}/${checkIn.date.month}/${checkIn.date.year}',
                    ),
                  );
                },
              );
            } else if (state is CheckInLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return const Center(child: Text(AppStrings.errHistory));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCheckInBottomSheet,
        tooltip: AppStrings.addCheckin,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showCheckInBottomSheet() {
    bool gambledToday = false;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: AppUtils.hrPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(AppStrings.gambledToday),
                  SwitchWidget(
                    initialValue: gambledToday,
                    onChanged: (value) {
                      gambledToday = value;
                    },
                  ),
                ],
              ),
              TextFormFieldWidget(
                controller: _notesC,
                label: AppStrings.notes,
              ),
              const SizedBox(height: 16.0),
              BlocConsumer<CheckInBloc, CheckInState>(
                listener: (context, state) {
                  if (state is CheckInSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Check-in submitted successfully!')),
                    );
                    _notesC.clear();
                    gambledToday = false;
                    Navigator.pop(context);
                    context.read<CheckInBloc>().add(LoadCheckInHistory());
                  } else if (state is CheckInError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${state.error}')),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is CheckInLoading) {
                    return const CircularProgressIndicator();
                  }
                  return PrimaryButtonWidget(
                    onPressed: () {
                      context.read<CheckInBloc>().add(
                            SubmitCheckIn(
                              gambledToday: gambledToday,
                              notes: _notesC.text,
                            ),
                          );
                    },
                    label: AppStrings.submit,
                  );
                },
              ),
              const SizedBox(height: 25)
            ],
          ),
        ),
      ),
    );
  }
}
