import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/auth/presentation/controller/auth_controller.dart';
import '../features/auth/presentation/controller/auth_state.dart';

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);
