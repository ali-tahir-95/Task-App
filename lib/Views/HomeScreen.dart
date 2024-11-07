import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/Controllers/GenericController.getx.dart';
import 'package:task_app/Views/Widgets_Home.dart';
import '../Widgets/Widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GenericController controller = Get.put(GenericController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RowWithColumns(),
            const SizedBox(height: 25),
            const MySearchBar(),
            const SizedBox(height: 25),
            const TitleWidget(),

            // Wrap the ListView with Obx to watch the tasksList observable
            Expanded(
              child: Obx(
                () {
                  // Show CircularProgressIndicator when tasksList is empty
                  if (controller.tasksList.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    // Show ListView.builder when tasksList is populated
                    return ListView.builder(
                      itemCount: controller.tasksList.length,
                      itemBuilder: (context, index) {
                        var task = controller.tasksList.reversed
                            .toList()[index]; // Reverse the list before accessing
                        return Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.horizontal,

                            // Background when swiping left
                            background: Container(
                              color: Colors.red,
                              padding: const EdgeInsets.only(left: 16),
                              alignment: Alignment.centerLeft,
                              child: const RotatedBox(
                                quarterTurns: 3,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Delete',
                                      style: TextStyle(
                                          color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(Icons.delete, color: Colors.white),
                                  ],
                                ),
                              ),
                            ),

                            // Secondary background when swiping right
                            secondaryBackground: Container(
                              color: Colors.green,
                              padding: const EdgeInsets.only(right: 16),
                              alignment: Alignment.centerRight,
                              child: const RotatedBox(
                                quarterTurns: 1,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Completed',
                                      style: TextStyle(
                                          color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(Icons.check, color: Colors.white),
                                  ],
                                ),
                              ),
                            ),
                            onDismissed: (direction) {
                              if (direction == DismissDirection.endToStart) {
                                print("Marked as completed");
                              } else if (direction == DismissDirection.startToEnd) {
                                print("Deleted");
                              }
                            },
                            child: CustomStackWidget(
                              title: task['task_name'].toString(),
                              time: task['date'].toString(),
                              titleText: "Description",
                              descriptionText: task['description'].toString(),
                              showBottomStatusContainer: int.parse(
                                task['is_complete'],
                              ),
                            ));
                      },
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: const GradientButton(),
    );
  }
}
