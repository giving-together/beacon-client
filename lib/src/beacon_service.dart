import 'dart:convert';

import 'package:beacon_client/src/network_service.dart';

import 'models/event.dart';
import 'models/task.dart';

class BeaconService {
  final String accountId;
  final String apiKey;
  BeaconService({required this.accountId, required this.apiKey}) {
    networkService = NetworkService();
  }

  static const baseUrl = 'https://api.beaconcrm.org/v1/';

  late final NetworkService networkService;

  String get authority => '$baseUrl/account/$accountId';

  Future<List<Task>> getTasks(Map<String, dynamic> filter) async {
    const path = '/entities/task/filter';
    final results = await _getList(path, filter: filter);
    final tasks = results
        .map<Task>(Task.fromBeacon)
        .where((t) => t.isTemplate)
        .toList();

    if (tasks.isEmpty) {
      throw BeaconException('No template tasks found');
    }

    return tasks;
  }

  Future<Event> getInitEvent(int id) async {
    final response = await networkService.get(
      '$authority/entity/event/$id',
      headers: _signedHeaders,
    );

    final event = Event.fromBeacon(response);

    if (event.startDate == null) {
      throw BeaconException('Event ${event.name} has no start date');
    }

    if (event.startDate!.isBefore(DateTime.now())) {
      throw BeaconException('Event ${event.name} is closed');
    }

    if (!event.hasHost) {
      throw BeaconException('Event ${event.name} has no host');
    }

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

class BeaconException implements Exception {
  final String message;
  BeaconException(this.message);

  @override
  String toString() {
    return 'BeaconException: $message';
  }
}
