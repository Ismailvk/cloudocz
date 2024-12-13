import 'package:cloudocz/data/network/api_services.dart';
import 'package:cloudocz/data/network/api_urls.dart';
import 'package:cloudocz/data/shared_preference/shared_preference.dart';

class TaskRepo {
  final token = SharedPreference.instance.getToken();

  EitherResponse getTasks() {
    const url = '${ApiUrls.baseUrl}/${ApiUrls.getTasks}';
    return ApiService.getApi(url, token);
  }

  EitherResponse addTask(Map<String, String> taskData) {
    const url = '${ApiUrls.baseUrl}/${ApiUrls.addTask}';
    return ApiService.postApi(taskData, url);
  }

  EitherResponse destroyTask(String id) {
    String url = '${ApiUrls.baseUrl}/${ApiUrls.destroyTask}/$id';
    return ApiService.postApi({}, url, token);
  }
}
