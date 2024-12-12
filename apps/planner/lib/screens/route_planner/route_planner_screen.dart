import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:planner/app/app_router.dart';
import 'package:planner/screens/route_planner/route_screen_bloc.dart';

class RoutePlannerScreen extends StatelessWidget {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RouteScreenBloc, RouteScreenState>(
      listener: (context, state) {
        if (state is Success) {
          _router.navigateTo(Routes.results, arguments: state.response);
        } else if (state is Error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Plan a Route')),
          body: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    key: const Key('fromTextField'),
                    controller: _fromController,
                    decoration: InputDecoration(labelText: 'From'),
                  ),
                  TextField(
                    key: const Key('toTextField'),
                    controller: _toController,
                    decoration: InputDecoration(labelText: 'To'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<RouteScreenBloc>().add(GetRoutesEvent(
                            from: _fromController.text,
                            to: _toController.text,
                          ));
                    },
                    child: Text('Get Route'),
                  ),
                  SizedBox(height: 16),
                  if (state is Loading)
                    CircularProgressIndicator()
                  else if (state is Success)
                    Text('Route Distance: ${state.response.distance}')
                ],
              ))),
    );
  }
}
