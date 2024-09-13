import 'package:http/http.dart' as http;

mixin FeedbackExecutor {
  Future<bool> feedback_sendFeedback(String feedback) async {
    try {
      // https://hooks.slack.com/services/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
      await http.post(
          Uri.parse(
              "https://hooks.slack.com/services/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"),
          body: {"text": feedback});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
