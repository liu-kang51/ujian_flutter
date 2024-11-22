import 'package:get/get.dart';
import '../models/post_model.dart';
import '../services/api_service.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  var posts = <PostModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  void fetchPosts() async {
    var fetchedPosts = await ApiService.fetchPosts();
    posts.assignAll(fetchedPosts);
  }

  void changePage(int index) {
    currentIndex.value = index;
  }
}
