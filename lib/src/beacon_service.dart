import 'dart:convert';

import 'models/event.dart';
import 'models/task.dart';
import 'network_service.dart';

class BeaconService {
  final String accountId;
  final String apiKey;
  BeaconService({required this.accountId, required this.apiKey}) {
    networkService = NetworkService();
  }

  static const baseUrl = 'https://api.beaconcrm.org/v1';

  late final NetworkService networkService;

  String get authority => '$baseUrl/account/$accountId';

  Future<List<Task>> getTasks({Map<String, dynamic> filter = const {}}) async {
    const path = '/entities/task/filter';
    final results = await _getList(path, filter: filter);
    final tasks = results.map<Task>(Task.fromBeacon).toList();

    return tasks;
  }

  Future<Event> getEvent(int id) async {
    final response = await networkService.get(
      '$authority/entity/event/$id',
      headers: _signedHeaders,
    );
    final event = Event.fromBeacon(response);

    return event;
  }

  Future<void> createTask(Task task) async {
    final body = task.toCreateBody();
    await networkService.post(
      '$authority/entity/task',
      headers: _signedHeaders,
      body: jsonEncode(body),
    );
  }

  Future<List<Map<String, dynamic>>> _getList(
    String path, {
    Map<String, dynamic>? filter,
  }) async {
    final body = jsonEncode(filter);
    final response = await networkService.post(
      '$authority$path',
      headers: _signedHeaders,
      body: body,
    );

    final results = (response['results'] as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    return results;
  }

  Map<String, String> get _signedHeaders {
    return {
      'Authorization': 'Bearer $apiKey',
      'Beacon-Application': 'developer_api',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }
}
