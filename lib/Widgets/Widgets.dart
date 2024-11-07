import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../Constants/Constants.dart';
import '../Controllers/GenericController.getx.dart';

// Widget for the row with two columns
class RowWithColumns extends StatefulWidget {
  const RowWithColumns({super.key});

  @override
  _RowWithColumnsState createState() => _RowWithColumnsState();
}

class _RowWithColumnsState extends State<RowWithColumns> {
  bool _isDropdownOpen = false;
  bool _isDateChecked = false;
  bool _isNameChecked = false;

  @override
  Widget build(BuildContext context) {
    final String currentDay = DateFormat('EEEE').format(DateTime.now());
    final String currentDate = DateFormat('MMMM dd, yyyy').format(DateTime.now());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left column with day and date
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentDay,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: primary),
                ),
                Text(
                  currentDate,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
            // Right column with styled button or dropdown title
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: _isDropdownOpen
                  ? Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Sort by date',
                            style: TextStyle(fontSize: 13, color: Colors.black),
                          ),
                        ),
                        const SizedBox(width: 8),
                        SvgPicture.asset("assets/bars.svg"),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            setState(() {
                              _isDropdownOpen = false;
                            });
                          },
                        ),
                      ],
                    )
                  : IconButton(
                      icon: SvgPicture.asset("assets/bars.svg"),
                      onPressed: () {
                        setState(() {
                          _isDropdownOpen = true;
                        });
                      },
                    ),
            ),
          ],
        ),
        if (_isDropdownOpen) _buildDropdown(),
      ],
    );
  }

  Widget _buildDropdown() {
    return Container(
      margin: const EdgeInsets.only(left: 230.0),
      padding: const EdgeInsets.all(8.0),
      width: 160, // Fixed width to keep it aligned with title
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDropdownItem("Date", _isDateChecked, (value) {
            setState(() {
              _isDateChecked = value;
            });
          }),
          _buildDropdownItem("Name", _isNameChecked, (value) {
            setState(() {
              _isNameChecked = value;
            });
          }),
        ],
      ),
    );
  }

  Widget _buildDropdownItem(String title, bool isChecked, Function(bool) onChanged) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 12),
          ),
          Checkbox(
            value: isChecked,
            onChanged: (value) {
              if (value != null) onChanged(value);
            },
          ),
        ],
      ),
    );
  }
}

// Widget for the search bar
class MySearchBar extends StatelessWidget {
  const MySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: primary),
          const SizedBox(width: 10),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Search Task.....',
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget for the title
class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'My Task',
      style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: primary),
    );
  }
}

// Widget for add new task button

class GradientButton extends StatelessWidget {
  const GradientButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(100, 50), // Set width and height
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          shadowColor: Colors.transparent, // Remove shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide.none,
        ),
        onPressed: () {
          // Show the popup when the button is pressed
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const CustomDialog();
            },
          );
        },
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 71, 146, 207),
                Color.fromARGB(0, 116, 115, 115),
                Color(0xFFA886DA),
              ], // Gradient from rgba(168, 134, 218, 1) to blue
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            alignment: Alignment.center,
            child: const Text(
              '+ Add New Task',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Dailogue

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    GenericController controller = Get.find(); // Access the controller

    // Controllers for the TextFields
    TextEditingController taskNameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController numberController = TextEditingController();

    return Dialog(
      backgroundColor: Colors.transparent, // Transparent background
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Apply blur effect
        child: Center(
          child: Container(
            width: double.infinity, // Container takes full available width
            decoration: BoxDecoration(
              color: scaffoldBgColor, // White background for the popup
              borderRadius: BorderRadius.circular(10), // Border radius for the popup
            ),
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min, // Use minimal space for the popup content
                crossAxisAlignment: CrossAxisAlignment.center, // Center-align the content
                children: [
                  Text(
                    'Upload New Task',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primary),
                  ),
                  const SizedBox(height: 20),

                  // Task Name TextField
                  TextField(
                    controller: taskNameController,
                    decoration: InputDecoration(
                      hintText: 'Enter Task Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Description TextField
                  TextField(
                    controller: descriptionController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Enter Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Number TextField
                  TextField(
                    controller: numberController,
                    decoration: InputDecoration(
                      hintText: 'Enter Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    keyboardType: TextInputType.number, // Ensures the input is a number
                  ),
                  const SizedBox(height: 20),

                  // Upload Photo Container
                  Container(
                    width: double.infinity, // Make the container take all available width
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Upload Photo',
                          style: TextStyle(fontSize: 13),
                        ),
                        const SizedBox(height: 10),
                        Icon(
                          Icons.upload_file,
                          size: 50,
                          color: primary,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Upload JPG/PNG',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Row of Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center the buttons
                    children: [
                      // Cancel Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Cancel',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900)),
                      ),
                      const SizedBox(width: 10), // Add some space between buttons
                      // Save Button
                      ElevatedButton(
                        onPressed: () {
                          // Get the values from the text controllers
                          String taskName = taskNameController.text;
                          String description = descriptionController.text;
                          String number = numberController.text;

                          // Call storeData method with the inputs
                          if (taskName.isNotEmpty && description.isNotEmpty && number.isNotEmpty) {
                            controller.storeData(
                                'username', number, 'image_placeholder', taskName, description);

                            // Add the new task to the list after saving
                            controller.tasksList.add({
                              'task_name': taskName,
                              'description': description,
                              'number': number,
                              'date': DateTime.now().toString(), // Example date
                              'is_complete': '0', // Example status
                            });

                            // Show success message
                            Get.snackbar(
                              "Success",
                              "Task saved successfully",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                            );

                            // Close the dialog
                            Navigator.of(context).pop();
                          } else {
                            // Show error message if fields are empty
                            Get.snackbar(
                              "Error",
                              "Please fill in all fields",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 168, 134, 218),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
