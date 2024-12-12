import 'package:core_api/api.dart';
import 'package:flutter/material.dart';

class StepCarouselCard extends StatelessWidget {
  final StepsDTO step;
  final int index;
  final Map<String, dynamic>? weather;

  const StepCarouselCard(
      {Key? key, required this.step, required this.index, this.weather})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Step ${index + 1}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Direction: ${step.direction}'),
            const SizedBox(height: 8),
            if (weather != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Temperature: ${weather?['temperature'].toStringAsFixed(1)}°C'),
                  Text('Description: ${weather?['description']}'),
                ],
              )
            else
              const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
