import 'package:demo_app/features/auth/bloc/auth_bloc.dart';
import 'package:demo_app/features/check_in/bloc/check_in_bloc.dart';
import 'package:demo_app/utils/app_strings.dart';
import 'package:demo_app/views/widgets/switch_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  _CheckInScreenState createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  bool gambledToday = false;
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CheckInBloc>().add(LoadCheckInHistory());
  }

  void _showCheckInBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets, // Handle keyboard overlay
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Gambled Today'),
                  SwitchWidget(
                    initialValue: gambledToday,
                    onChanged: (value) {
                      gambledToday = value;
                    },
                  ),
                ],
              ),
              TextField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Notes'),
              ),
              const SizedBox(height: 16.0),
              BlocConsumer<CheckInBloc, CheckInState>(
                listener: (context, state) {
                  if (state is CheckInSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Check-in submitted successfully!')),
                    );
                    _notesController.clear();
                    setState(() {
                      gambledToday = false;
                    });
                    Navigator.pop(context); // Close the bottom sheet
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
                  return ElevatedButton(
                    onPressed: () {
                      final notes = _notesController.text;
                      context.read<CheckInBloc>().add(
                            SubmitCheckIn(
                              gambledToday: gambledToday,
                              notes: notes,
                            ),
                          );
                    },
                    child: const Text('Submit'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.dailyChkIn),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(SignOutRequested());
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                      checkIn['gambledToday']
                          ? AppStrings.gamble
                          : AppStrings.notGambled,
                    ),
                    subtitle: Text(checkIn['notes']),
                    trailing: Text(
                      '${checkIn['date'].day}/${checkIn['date'].month}/${checkIn['date'].year}',
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
        tooltip: 'Add Check-In',
        child: const Icon(Icons.add),
      ),
    );
  }
}
