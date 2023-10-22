import 'package:http_interceptor/http_interceptor.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor implements InterceptorContract {
  Logger logger = Logger(printer: PrettyPrinter(methodCount: 0));

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    logger.t(
        "REQUEST: ${data.url}\n\n");
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    switch (data.statusCode ~/ 100) {
      case 2:
        logger.i(
            "RESPONSE: ${data.url}\nSTATUS: ${data.statusCode}\nBODY: ${data.body}");
        break;
      case 4:
        logger.e(
            "RESPONSE: ${data.url}\nSTATUS: ${data.statusCode}\nBODY: ${data.body}");
        break;
      default:
        logger.t(
            "RESPONSE: ${data.url}\nSTATUS: ${data.statusCode}\nBODY: ${data.body}");
    }
    return data;
  }
}
