import 'package:flutter/material.dart';
import 'package:planner/generated/l10n.dart';

extension LocalizedBuildContext on BuildContext {
  L10n get l10n => L10n.of(this)!;
}
