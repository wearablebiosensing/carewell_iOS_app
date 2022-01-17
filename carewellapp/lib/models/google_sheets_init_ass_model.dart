/*
* Init assessment mode to save data to google sheets.
*/
class InitAssessmentModelGS {
  static final PatientID = "PatientID";
  static final Timestamp = "Timestamp";
  static final Init_Question = "Init_Question";
  static final Response = "Response";

  static List<String> get_fields() =>
      [PatientID, Timestamp, Init_Question, Response];
}
