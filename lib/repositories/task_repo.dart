import 'package:cloudocz/data/network/api_services.dart';
import 'package:cloudocz/data/network/api_urls.dart';
import 'package:cloudocz/data/shared_preference/shared_preference.dart';

class TaskRepo {
  final token = SharedPreference.instance.getToken();
  EitherResponse getTasks() {
    const url = '${ApiUrls.baseUrl}/${ApiUrls.getTasks}';
    return ApiService.getApi(url, token);
  }
}