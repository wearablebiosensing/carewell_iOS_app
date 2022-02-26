import 'package:carewellapp/cloud_models/google_sheets_carewell_chat.dart';
import 'package:carewellapp/cloud_models/google_sheets_usage_data.dart';
import 'package:carewellapp/cloud_models/google_sheets_weekly_assessment.dart';
import 'package:gsheets/gsheets.dart';

import 'google_sheets_init_ass_model.dart';

class googleSheetsAPI {
  static const credentials_google_sheets = r''' 
  {
    "type": "service_account",
    "project_id": "carewellflutter",
    "private_key_id": "1d26479729815941c48e667fa73b95a6da38bc67",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCwgPTdcFKOCxrl\nPQdNrmZPw+D72Z4prj31sGEs5hNldpF+Kc8vBieBW59H1AdbF87EKr3Zmax/i4uS\no/71uSvQnmmtPs5HMqr74v9VyAo8DynU5cksLW9hi4BVRVUBEfVh04p6db9qQE1e\nWp79skQDJf5Bwq1XlexX3wzDGOjYK6mOvoMlvIIXHPN+AglosO8DyTf4RpcbmYDv\nKpy9VxirATkxnIqjM39gfdt2gFWMFu5/kPqfsJW10FavPS7ne3AbODoxDnOR9jb7\nfuOcogGy1W2qgQxPCGqNcTelASc5p+yTFK1UUFwzn34voJikzSppu4mjTfaZ/Pyu\nX2HaIx+jAgMBAAECggEADWqlXQEWaruyCK4x6ZgR04sKhWUOXma4nlNmSkPBl7CC\nm2TRiJE0MY4QYSUJ22/HhNEm60KA1+p4lTtSvG+d7Va3+7ZOzHSv20PEWvXraT38\nf7VpLFWBJkNfYZv1O9vsm3S5YwOjpY+hEe9bhIynb4HU05TZGP5JdTMm74briXrv\n1faklwz0lYnsPoqbtk3+ONKqA9wPN1TPooLbiIIQLRjHD2fnzQnpIU/knZClJObP\nn3/YwIYR9AM+G8/GLzqiPYWXDkZm402xZrjlUbD20QhAI128s27KL1UrP+sXUs+5\nKraibZgoc9pi7775YAk+tPCYCIIfTv7A4VTQnQ+iKQKBgQDcVH7O7bMoyT0ac2u8\nMv9XjM1ieuD9X62/5ZHLxHXW4xiNpaQiSwMvu/BTLIBv1THF8RnYbxRk7nTm9EWM\nWWc1jRHCgGmv85Ql75AAmv/AuHyWpnPbyWjBiPUdh4yisi/i5vVwRbLIGTc0Qc5k\nbefScAjmKV6iHYAZ0Gk8MN7cNwKBgQDNFBgSeyOO/zCXFg3nWGEBMoXn5Oxwmm5v\nwjo1OrZLmuC7KM9AgRMP+mv2W03Z8+DdwNYNW8kYveilRjgGXketvjUIPEbVuPjw\n6FKljMdzOAbd2mHFfP/co7PCj9QJTgOk5PNhOQhCLBxDCT//Z1uIef/O6VHio0QK\nNYajFu8Z9QKBgHhtYqZd+/gGDnTfs3o5caF732K9gS5cVo61vvveVP5wQCJj8BOi\nZop3sgL0Jvt5Tuw/PP40sLP+Nj1qNH1i/GujwJpML/gxLb+ScmYyUioXbFm3f0oZ\niz2FS1ypky/2LwBZdru4DOEcDzVr5pC0FerKu8J5yDTZ5QO3C14P5C//AoGARewI\n/RwhFptprMnnOa7HfEoGn/dMqmPtLYuynv2CtCp9XzLd3ydjIXqHnvqog5yEWfdq\nxCk8WoQ9s0RKy9kPZWzJ1iH/INWtgy4jJ7DlPCKpLLFNzrD85/Sk0LyLVhTUZz9s\nwARbDXzOsgiQWnuaGOFH1/tzYOu7wiNX4XlrUpUCgYEAgMIVqK2TaAIosgBa7u/c\nzJjZ06xOZCq/OSNks28jcQJTTQxmWRs65oPWvc+gvIVnXM0DAI5ARwEtvpDTGQ8n\ndt/j1S9KSqC6mXqLKDayoUottv7XdBCmmQjKXNVXiCCowu/LYlkdAaMjbg7mTgII\nXVhqMr72qrzTwLXW4HM1yeY=\n-----END PRIVATE KEY-----\n",
    "client_email": "carewellapp@carewellflutter.iam.gserviceaccount.com",
    "client_id": "114437201436808149423",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/carewellapp%40carewellflutter.iam.gserviceaccount.com"
  }
  ''';
  static const google_sheet_id = "1yVeplaUTfh1F_CGDEJkGaL3EyNy7NiXN7J29Gl2kSNg";
  static final _gsheets = GSheets(credentials_google_sheets);
  static Worksheet? _initAssSheet;
  static Worksheet? _weeklyAssSheet;
  static Worksheet? _UsagedataSheet;
  static Worksheet? _ChatSheet;
  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(google_sheet_id);

      _ChatSheet = await _getWorkSheet(spreadsheet, title: 'CareWellChat');
      _initAssSheet = await _getWorkSheet(spreadsheet,
          title:
              'InitialAssessment'); //Multiple sheets in one excel file.This is the InitialAssessment
      _weeklyAssSheet =
          await _getWorkSheet(spreadsheet, title: 'WeeklyAssessment');
      _UsagedataSheet = await _getWorkSheet(spreadsheet, title: 'UsageData');

      final firstRow = InitAssessmentModelGS.get_fields();
      // takes in row number, and values.
      final firstRowWA = WeeklyAssessmentModelGS.get_fields();
      final firstRowUD = UsageDataModelGS.get_fields();
      final firstRowCS = CarewellChatModelGS.get_fields();
      _initAssSheet!.values.insertRow(1, firstRow);
      _weeklyAssSheet!.values.insertRow(1, firstRowWA);
      _UsagedataSheet!.values.insertRow(1, firstRowUD);
      _ChatSheet!.values.insertRow(1, firstRowCS);
    } catch (e) {
      print("Init error $e");
    }
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet
          .addWorksheet(title); // Create a worksheet if it does not exist.
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }
  /*
  * Inserts each anser row wise.
  */

  static Future insert(List<Map<String, dynamic>> rowList) async {
    _initAssSheet!.values.map.appendRows(rowList);
  }

  static Future insertWA(List<Map<String, dynamic>> rowList) async {
    _weeklyAssSheet!.values.map.appendRows(rowList);
  }

  static Future insertUD(List<Map<String, dynamic>> rowList) async {
    _UsagedataSheet!.values.map.appendRows(rowList);
  }

  static Future insertCS(List<Map<String, dynamic>> rowList) async {
    _ChatSheet!.values.map.appendRows(rowList);
  }
}
