import 'package:courses_app/models/course.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey,
                  image: DecorationImage(
                      image: NetworkImage(course.image), fit: BoxFit.fill)),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.category,
                        style: const TextStyle(color: Color(0xff9D9D9D)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Row(
                                  children: List.generate(
                                      5,
                                      (index) => returnStar(
                                          double.tryParse(course.rating.rate) ??
                                              0.0,
                                          index))),
                              Text(
                                "(${course.rating.rate})",
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                "(${course.rating.count})",
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          Text(
                            "\$${course.price}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  returnStar(double rating, int index) {
    Icon icon;
    if (index >= rating) {
      icon = const Icon(
        Icons.star_border,
        color: Color(0xffF6E6A5),
        size: 20,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = const Icon(
        Icons.star_half,
        color: Color(0xffF6E6A5),
        size: 20,
      );
    } else {
      icon = const Icon(
        Icons.star,
        color: Color(0xffF6E6A5),
        size: 20,
      );
    }
    return icon;
  }
}
