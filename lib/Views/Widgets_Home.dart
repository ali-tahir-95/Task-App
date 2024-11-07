import 'package:flutter/material.dart';

class CustomStackWidget extends StatelessWidget {
  final String title;
  final String time;
  final String titleText;
  final String descriptionText;
  final int showBottomStatusContainer; // Changed to int to accept 0 or 1

  const CustomStackWidget({
    super.key,
    required this.title,
    required this.time,
    required this.titleText,
    required this.descriptionText,
    this.showBottomStatusContainer = 0, // Default set to 0 (do not show)
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/bgImg.png',
              fit: BoxFit.cover,
            ),
          ),
          // Foreground content
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ContentRow(title: title, time: time),
                const SizedBox(height: 20),
                TitleText(text: titleText),
                const SizedBox(height: 7),
                DescriptionText(text: descriptionText),
              ],
            ),
          ),
          // Positioned bottom status container (conditionally displayed)
          if (showBottomStatusContainer == 1)
            const Positioned(
              bottom: 0,
              left: 60,
              right: 60,
              child: BottomStatusContainer(),
            ),
        ],
      ),
    );
  }
}

// First row with title and time
class ContentRow extends StatelessWidget {
  final String title;
  final String time;

  const ContentRow({super.key, required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/titleImg.png',
          width: 70,
          height: 70,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const SizedBox(width: 10),
                const Icon(Icons.calendar_today, size: 12, color: Color.fromARGB(255, 59, 59, 59)),
                const SizedBox(width: 5),
                Text(
                  time,
                  style: const TextStyle(fontSize: 12, color: Color.fromARGB(255, 59, 59, 59)),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// Second row with big title text
class TitleText extends StatelessWidget {
  final String text;

  const TitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }
}

// Third row with description paragraph
class DescriptionText extends StatelessWidget {
  final String text;

  const DescriptionText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 13, color: Colors.black),
    );
  }
}

// Bottom container with "Completed" text and checkbox
class BottomStatusContainer extends StatelessWidget {
  const BottomStatusContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Completed',
            style: TextStyle(fontSize: 13, color: Colors.green, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 5),
          Icon(
            Icons.check_box,
            color: Colors.green,
            size: 13,
          ),
        ],
      ),
    );
  }
}
