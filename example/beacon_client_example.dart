import 'package:beacon_client/beacon_client.dart';

Future<void> main() async {
  final beaconService = BeaconService(accountId: '29101', apiKey: 'redacted');
  final templateFilter = {
    'filter_conditions': [
      {'field': 'c_is_template', 'value': true, 'operator': '=='},
    ],
    'filter_strictness': 'all',
  };

  final tasks = await beaconService.getTasks(templateFilter);
  print(tasks);
}
