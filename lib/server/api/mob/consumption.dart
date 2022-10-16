import 'dart:io';

import 'package:climathon_admin/server/server.dart';

class ConsumptionApi {
  Future<void> checkHealth() async {
    await Server.get('health', HttpStatus.ok);
  }
}
