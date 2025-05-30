// ignore_for_file: lines_longer_than_80_chars

class Event {
  final int id;
  final String name;
  final String? notes;
  final DateTime updatedAt;
  final DateTime? startDate;
  final List<int> profiledMinistries;
  final String? presentationQa;
  final String? feedbackSurvey;
  final List<int> pledges;
  final List<int> hosts;

  Event({
    required this.id,
    required this.name,
    required this.updatedAt,
    this.notes,
    this.startDate,
    this.profiledMinistries = const [],
    this.pledges = const [],
    this.hosts = const [],
    this.presentationQa,
    this.feedbackSurvey,
  });

  int? get host => hosts.firstOrNull;
  bool get hasHost => host != null;

  factory Event.fromBeacon(dynamic json) {
    final entity =
        (json as Map<String, dynamic>)['entity'] as Map<String, dynamic>;
    return Event.fromJson(entity);
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as int,
      name: json['name'] as String,
      notes: json['notes'] as String?,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'] as String)
          : null,
      profiledMinistries:
          (json['c_profiled_ministry'] as List).map((e) => e as int).toList(),
      pledges: (json['c_pledges'] as List).map((e) => e as int).toList(),
      hosts: (json['c_host'] as List).map((e) => e as int).toList(),
    );
  }

  @override
  String toString() {
    return 'Event(id: $id, name: $name)';
  }
}

/*
id	Record ID	Integer	The unique record ID automatically assigned by Beacon for this event.
updated_at	Last modified date	Timestamp	When this eventwas last updated.
notes	Notes	Long text	
c_profiled_ministry	Profiled Ministries	Link to another record	(Multiple allowed: Yes)
c_presentation_q_a	Presentation Q&A	URL	
c_feedback_survey	Feedback Survey	URL	
c_pledges	Pledges	Link to another record	(Multiple allowed: Yes)
c_host	Host	Link to another record	(Multiple allowed: Yes)

created_at	Created date	Timestamp	When this event was created.
created_by_id	Created by ID	Integer	The ID of the "actor" who created this event.
created_by_type	Created by type	String	The kind of "actor" that created this event, for example "user" or "app".
updated_by_id	Last modified by ID	Integer	The ID of the "actor" who last updated this event.
updated_by_type	Last modified by type	String	The kind of the "actor" who last updated this event, for example "user" or "app".
is_archived	Is archived?	Boolean	Either "true" or "false", to indicate if this event has been archived.
avatar	Avatar URL	String	If an avatar has been uploaded to the event, then this will be a short-lived URL to the square image.
is_locked	Locked?	Boolean	Whether this event record has been locked, preventing further changes. (Only supported on payments)
locked_by_type	Locked by type	String	The kind of the "actor" who locked this event, for example "user" or "app".
locked_by_id	Locked by	Integer	The ID of the "actor" who locked this event.
locked_at	Locked date	Timestamp	When this event was locked.

website	Website	URL	
attachments	Attachments	File upload	
start_date	Start date	Date	
end_date	End date	Date	
location	Location	Location	
type	Type	Drop-down list	
Allowed options: Run, Walk, Conference, Festival, Cycle, Other
campaign	Campaign	Link to another record	
previous_database_id	Previous database ID	Short text	
external_id	External ID	Short text	
total_donations	Total donations	Currency	
total_tickets	Total tickets	Currency	
number_of_attendees	Total attendees	Number	
number_of_ticketed_attendees	Ticketed attendees	Number
*/
