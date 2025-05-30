/*
{
"id": 628,
"created_at": "2025-05-28T06:33:26.938Z",
"created_by_id": 31545,
"created_by_type": "user",
"updated_at": "2025-05-28T06:33:26.938Z",
"updated_by_id": 31545,
"updated_by_type": "user",
"is_archived": false,
"archived_at": null,
"archived_by_id": null,
"archived_by_type": null,
"is_locked": false,
"locked_at": null,
"locked_by_id": null,
"locked_by_type": null,
"avatar": null,
"entity_type_id": 231191,
"name": "Eventbrite",
"due_date": null,
"notes": "Create Eventbrite ticketing - consider key questions to ask attendees\nEmail for new attendees: https://www.dropbox.com/scl/fi/r4iccssnirkdko56rqdcn/1.-Collab-giving-invite.docx?rlkey=9khg3ypnl6iksh4f9t4p21czy&dl=0\nEmail for previous attendees https://www.dropbox.com/scl/fi/rtf2ao9m86klvlsx0e3pk/1a.-Collab-giving-re-invitation-for-previous-pledgers.docx?rlkey=t0abxkrxmkqp7zpfoirpqy964&dl=0",
"completed": false,
"assignee_ids": [],
"related_entity_ids": [],
"previous_database_id": null,
"c_is_template": true,
"c_timing": "-6m",
"c_event": [],
"attachments": [
  {
    "id": "310cb6d2-2f50-433f-b32a-76c53055eb21",
    "name": "Collab Giving Invite.docx",
    "size": 14346,
    "type": "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    "source": "upload",
    "url": "https://beacon-user-uploads-production.s3.eu-west-2.amazonaws.com/account/29101/files/310cb6d2-2f50-433f-b32a-76c53055eb21/Collab%20Giving%20Invite.docx?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIAQZMQ5GC2FMIACKI4%2F20250528%2Feu-west-2%2Fs3%2Faws4_request&X-Amz-Date=20250528T072921Z&X-Amz-Expires=86400&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEKf%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCWV1LXdlc3QtMiJIMEYCIQDKQ7qgmQpzwFLnhbEbcnUal9aknbpj4LMU2%2FX9TAc8QAIhAKBxybeRK%2BGpopg2r%2BSZvrDbokwhqP8HXf3MxVO49bKzKosDCHAQBBoMMDU0NTI3ODY1MDEyIgz0Am4YWMH8onXAc5Eq6ALg7Gfzf8KMvA4c4nrdvuxZDYNLot6Lt%2FSWcYRFuAxwZNi%2Fn5Tjm5DDj1Qzcg8Yvg0r8hqrXNjbM%2B6aIC4ZI17iBZe%2Fq8lCgTdSqhrk4%2FZXD8C%2FUkaQOOH3EJO6kjpBE4LineUxylYX%2F6kWLlRjtfwTpB5Si7mgp%2Fw2TEbnFvpW7BwieYv4HCkMcKA4Z5B%2BggRFk0WSZnMpLHW3zKCjMXWuyOJrrLK5dD5KfiijXIitaykys14z3ym1Y41jBSxYZV7%2FtJA1rNqpMeyRmlDJR4hAAyrvWn0Bfe9EXhrH%2Fe%2FlYrXVyD7Kra%2FpEZxwBSiao6YDFf1UHNCdXA09jwd1vWvx8Tv9WSrQ0TaCpD9W3CXxM61v6Yuo30blm6X0qP1bVEMwH8V3fuOsnevcdmKGtXMTwyA6if%2FEOuKTPJNWVJOo%2BycpTgVD7UWbNqdqxvxQ%2F%2F1RYmJcosmi%2FZR2jgoUdLB%2BpLGWgqEfs3UwhuHawQY6nAEaA7WruvjvXz%2FW8AlZEnFRhodx4AeJ2Hw2IWngV5nuB7GIPQYNVN6YJIf%2BOI83L09B5uFFhBVd3Vu7PpAzpaV4%2Fx7MNmhs8Q%2BMAKwge7BcsUK9FsMLsHZxEHNfV8FIbkpkLgJTvKpvRwPAmmlAam6MvLGzK%2FaaTDh%2ByoffyHOhLN1yQr5qE659KTwsGSvBsilvLtgBJ2m3tOECi1Y%3D&X-Amz-Signature=c144f94e075f8fd2bd9c99fda9dac02347c6ca7a70967d7900c94e1da1f29d71&X-Amz-SignedHeaders=host",
    "infected": "clean"
  }
]
}
*/

import 'attachment.dart';

class Task {
  final int id;
  final String name;
  final DateTime updatedAt;
  final String? notes;
  final DateTime? dueDate;
  final bool isCompleted;
  final bool isArchived;
  final List<int> assignees;
  final bool isTemplate;
  final String? timing;
  final List<int> events;
  final List<Attachment> attachments;

  Task({
    required this.id,
    required this.name,
    required this.updatedAt,
    this.notes,
    this.dueDate,
    this.isCompleted = false,
    this.isArchived = false,
    this.assignees = const <int>[],
    this.isTemplate = false,
    this.timing,
    this.events = const <int>[],
    this.attachments = const <Attachment>[],
  });

  Map<String, dynamic> toCreateBody() {
    return {
      'name': name,
      'due_date': dueDate?.toIso8601String(),
      'completed': false,
      'c_is_template': false,
      'notes': notes,
      'c_event': events,
    };
  }

  factory Task.fromBeacon(dynamic json) {
    final entity =
        (json as Map<String, dynamic>)['entity'] as Map<String, dynamic>;
    return Task.fromJson(entity);
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int,
      name: json['name'] as String,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      notes: json['notes'] as String?,
      dueDate: json['due_date'] != null
          ? DateTime.parse(json['due_date'] as String)
          : null,
      isCompleted: json['completed'] as bool,
      isArchived: json['is_archived'] as bool,
      assignees: (json['assignee_ids'] as List).map((e) => e as int).toList(),
      isTemplate: json['c_is_template'] as bool,
      timing: json['c_timing'] as String?,
      events: (json['c_event'] as List).map((e) => e as int).toList(),
      attachments: (json['attachments'] as List)
          .map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  // copy with
  Task copyWith({
    DateTime? dueDate,
    bool? isCompleted,
    bool? isArchived,
    List<int>? assignees,
    bool? isTemplate,
    String? timing,
    List<int>? events,
    List<Attachment>? attachments,
  }) {
    return Task(
      id: id,
      name: name,
      updatedAt: updatedAt,
      notes: notes,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      isArchived: isArchived ?? this.isArchived,
      assignees: assignees ?? this.assignees,
      isTemplate: isTemplate ?? this.isTemplate,
      timing: timing ?? this.timing,
      events: events ?? this.events,
      attachments: attachments ?? this.attachments,
    );
  }

  @override
  String toString() {
    return 'Task(id: $id, name: $name)';
  }
}
