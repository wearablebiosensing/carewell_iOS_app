/*
* Init assessment mode to save data to google sheets.
*/

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class CarewellChatModelGS {
  static final PatientID = "Patient ID";
  static final UserID = "UserID";
  static final Timestamp = "Timestamp";
  static final Channel = "Channel";
  static final Message = "Message";

  static List<String> get_fields() =>
      [PatientID, UserID, Timestamp, Channel, Message];
}

class ChatForm {
  String PatientID;
  String UserID;
  String Timestamp;
  String Channel;
  String Message;

  ChatForm(
      this.PatientID, this.UserID, this.Timestamp, this.Channel, this.Message);

  factory ChatForm.fromJson(dynamic json) {
    return ChatForm("${json['PatientID']}", "${json['UserID']}",
        "${json['Timestamp']}", "${json['Channel']}", "${json['Message']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
        'PatientID': PatientID,
        'UserID': UserID,
        'Timestamp': Timestamp,
        'Channel': Channel,
        'Message': Message
      };
}

/// FormController is a class which does work of saving FeedbackForm in Google Sheets using
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
class ChatController {
  // Google App Script Web URL.
  Uri URL = Uri.parse(
      "https://script.google.com/macros/s/AKfycbzfMFl2IKR4lgdiHeUmyLb0nVYP0DdHghXhgb-zsQseQXafeus/exec");

  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  /// Async function which saves feedback, parses [feedbackForm] parameters
  /// and sends HTTP GET request on [URL]. On successful response, [callback] is called.
  void submitForm(ChatForm feedbackForm, void Function(String) callback) async {
    try {
      await http.post(URL, body: feedbackForm.toJson()).then((response) async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          await http.get(Uri.parse(url!)).then((response) {
            callback(convert.jsonDecode(response.body)['status']);
          });
        } else {
          callback(convert.jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}

class SignUpModelGS {
  static final DeviceID = "DeviceID";
  static final Email = "Email";
  static final HashPassword = "HashPassword";
  static final Timestamp = "Timestamp";

  static List<String> get_fields() =>
      [DeviceID, Email, HashPassword, Timestamp];
}
