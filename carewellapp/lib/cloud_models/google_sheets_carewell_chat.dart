/*
* Init assessment mode to save data to google sheets.
*/
class CarewellChatModelGS {
  static final PatientID = "Patient ID";
  static final UserID = "UserID";
  static final Timestamp = "Timestamp";
  static final Channel = "Channel";
  static final Message = "Message";

  static List<String> get_fields() =>
      [PatientID, UserID, Timestamp, Channel, Message];
}
