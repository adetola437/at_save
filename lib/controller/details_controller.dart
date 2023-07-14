import 'package:at_save/bloc/goals/goals_bloc.dart';
import 'package:at_save/controller/add_money_controller.dart';
import 'package:at_save/model/savings_goal.dart';
import 'package:at_save/view/screens/details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../theme/text.dart';
import '../view/widgets/button.dart';
import '../view/widgets/height.dart';
import '../view/widgets/outline_button.dart';

class DetailsScreen extends StatefulWidget {
  String goalId;
  DetailsScreen({required this.goalId, super.key});

  @override
  DetailsController createState() => DetailsController();
}

class DetailsController extends State<DetailsScreen> {
  ///Pops up the alert dialog to confirm the users action
  showConfirmationDialog(
    BuildContext context,
    String text,    //text to display in the alert dialog
    double amount,
    Function(bool) onConfirmed,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm Action',
            style: MyText.bodyBold(),
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              height: 170.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 60.h,
                      width: 60.h,
                      decoration: BoxDecoration(
                        color: Colors.yellow[100],
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: const Icon(
                        Icons.question_mark,
                        color: Color.fromARGB(255, 244, 220, 4),
                      ),
                    ),
                  ),
                  Height(30.h),
                  SizedBox(
                    child: Text(
                      text,
                      style: MyText.bodySm(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).pop(false);
              },
              child: SizedBox(
                width: 140.w,
                child: const OutlineButton(text: 'No'),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop(true);
                onConfirmed(true);   // action to perform when true
              },
              child: SizedBox(
                width: 140.w,
                child: Button(text: 'Yes'),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // context.read<GoalsBloc>().add(GetGoalsEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DetailsView(this);

  bool isLoading = false;

  void loading() {
    setState(() {
      isLoading = true;
    });
  }

  void notLoading() {
    setState(() {
      isLoading = false;
    });
  }

  ///This is the method that is triggered when a goal has been successfully deletred
  success() {
    context.go('/success', extra: 'You have successfully deleted the goal');
    // Navigator.of(context).pushReplacement(MaterialPageRoute(
    //   builder: (context) =>
    //       const SuccessScreen(text: 'You have successfully deleted the goal'),
    // ));
  }

  ///This action is triggered when the user want to add money to savings by clickin the add money button
  void pushToAddPage(String status, SavingsGoal goal) {
    if (status == 'Terminated') {
      Fluttertoast.showToast(
          msg:
              'This savings has been broken, Kindly create another savings plan');
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return AddMoneyScreen(
          id: widget.goalId,
        );
      }));
    }
  }

//The break savings action is triggered when the user wants to stop his savings
  void breakSavings(double amount, String status) async {
    if (status == 'Terminated') {
      Fluttertoast.showToast(
          msg:
              'This savings has been broken, Kindly create another savings plan');
    } else {
      showConfirmationDialog(
        context,
        'Are you sure you want to break this goal?',
        amount,
        (confirmed) {
          if (confirmed) {
            // Perform the action (delete/break goal)
            context
                .read<GoalsBloc>()
                .add(BreakSavingsEvent(amount: amount, id: widget.goalId,status: 'Terminated'));
            // Additional logic for breaking goal if needed
          }
        },
      );
    }
  }

  ///When the goal has been successfully broken, this method is called
  breakSuccess() {
    context.go('/success', extra: 'You have successfully broken the goal');
    // Navigator.of(context).pushReplacement(MaterialPageRoute(
    //   builder: (context) => const SuccessScreen(
    //       text: 'You have successfully broken your savings'),
    // ));
  }

  ///This is the action button used to delete a goal
  void deleteGoal(double amount) async {
    showConfirmationDialog(     //calls the alert dialog and pass the confirmation action
      context,
      'Are you sure you want to delete this goal?',
      amount,
      (confirmed) {
        if (confirmed) {
          // Perform the action (delete/break goal)
          context
              .read<GoalsBloc>()
              .add(DeleteEvent(amount: amount, id: widget.goalId));
          // Additional logic for breaking goal if needed
        }
      },
    );
  }

  ///When a user wants to edit his goals details, the edit button is clicked and this action is executed
  goToUpdate(SavingsGoal goal) {
    print(goal.id);
    context.push('/edit_screen', extra: goal);
    // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
    //   return EditScreen(
    //     goal: goal,
    //   );
    // }));
  }

  String formatDateToString(DateTime dateTime) {
    DateFormat dateFormat = DateFormat("dd MMMM yyyy");
    return dateFormat.format(dateTime);
  }

  ///Go to history screen
  viewHistory() {
    context.push('/history', extra: widget.goalId);
    // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
    //   return HistoryScreen(
    //     id: widget.goalId,
    //   );
    // }));
  }

  deleteError() {
    context.go('/error', extra: 'Error deleting goal');
  }
  
}
