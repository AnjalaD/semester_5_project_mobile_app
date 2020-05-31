class AlertMessage {
  final String title;
  final String description;
  final DateTime receivedOn;
  final List<int> contactNumbers;

  AlertMessage(
      this.title, this.description, this.receivedOn, this.contactNumbers);

  AlertMessage.fromJson(Map<String, dynamic> json)
      : this.title = json["title"],
        this.description = json["description"],
        this.receivedOn = json['received_on'] ?? new DateTime.now(),
        this.contactNumbers = [json['contact_numbers']];
}
