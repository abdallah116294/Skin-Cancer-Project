import 'package:flutter/material.dart';

class DetialsScreen extends StatelessWidget {
  const DetialsScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.content,
      required this.publishAt
      });
  final String image;
  final String title;
  final String content;
  final String publishAt;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 24,
        ),
        child: Column(
          children: [
            SizedBox(
                height: 200,
                width: 600,
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      // borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(image), fit: BoxFit.fitWidth)),
                )),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                publishAt,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle, color: Colors.grey.shade300),
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.black, fontSize: 22),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle, color: Colors.grey.shade200),
                child: Text(
                  content,
                  style: const TextStyle(color: Colors.black, fontSize: 25),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}