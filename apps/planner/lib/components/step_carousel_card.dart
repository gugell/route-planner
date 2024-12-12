import 'package:core_api/api.dart';
import 'package:flutter/material.dart';
import 'package:planner/l10n/global.dart';

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
          child: Row(children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.l10n.step(index + 1),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                if (weather != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(context.l10n.formattedWeather(
                          weather?['temperature'].toStringAsFixed(1),
                          weather?['description'])),
                    ],
                  )
                else
                  const Center(child: CircularProgressIndicator()),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_formattedDirection(step),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 64)),
              ],
            ),
          ])),
    );
  }

  _formattedDirection(StepsDTO step) {
    switch (step.direction) {
      case 'turn-right':
        return '->';
      case 'turn-left':
        return '<-';
      default:
        return '<>';
    }
  }
}
