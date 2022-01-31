/*
* Init assessment mode to save data to google sheets.
*/
class UsageDataModelGS {
  static final PatientID = "PatientID";
  static final StartTimestamp = "startTimestamp";
  static final StopTimestamp = "stopTimestamp";
  static final Section = "AppSection";

  static List<String> get_fields() =>
      [PatientID, StartTimestamp, StopTimestamp, Section];
}
