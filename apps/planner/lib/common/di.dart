import 'package:common/common.dart';

import 'di.config.dart';

@InjectableInit()
Future<void> configureDependencies() async => sl.init();
