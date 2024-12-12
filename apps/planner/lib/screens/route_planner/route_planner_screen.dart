import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:planner/app/app_router.dart';
import 'package:planner/l10n/global.dart';
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
            SnackBar(content: Text(context.l10n.routingError(state.message))),
          );
        }
      },
      builder: (context, state) => Scaffold(
          appBar: AppBar(title: Text(context.l10n.planRoute)),
          body: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    key: const Key('fromTextField'),
                    controller: _fromController,
                    decoration: InputDecoration(labelText: context.l10n.from),
                  ),
                  TextField(
                    key: const Key('toTextField'),
                    controller: _toController,
                    decoration: InputDecoration(labelText: context.l10n.to),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<RouteScreenBloc>().add(GetRoutesEvent(
                            from: _fromController.text,
                            to: _toController.text,
                          ));
                    },
                    child: Text(context.l10n.submit),
                  ),
                  SizedBox(height: 16),
                  if (state is Loading) CircularProgressIndicator()
                ],
              ))),
    );
  }
}
