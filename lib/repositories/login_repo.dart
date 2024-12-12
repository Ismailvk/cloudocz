import 'package:cloudocz/data/network/api_services.dart';
import 'package:cloudocz/data/network/api_urls.dart';

class LoginRepo {
  EitherResponse loginUser(Map<String, String> data) {
    const url = '${ApiUrls.baseUrl}/${ApiUrls.loginUser}';
    return ApiService.postApi(data, url);
  }
}
