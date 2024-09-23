import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/utils/constants/string_const.dart';
import '../../../../data/models/noticemodel.dart';

class NoticeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final int batchSize = 10;
  DocumentSnapshot? _lastDocument;
  var notices = <Notice>[].obs;
  var isLoading = false.obs;
  var hasMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    setupNoticeListener();
  }

  void setupNoticeListener() {
    Query initialQuery = _firestore
        .collection(StringConst.notice)
        .orderBy('id', descending: true)
        .limit(batchSize);

    initialQuery.snapshots().listen((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        _lastDocument = querySnapshot.docs.last;

        List<Notice> newNotices = querySnapshot.docs.map((doc) {
          return Notice.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        notices.assignAll(newNotices);

        if (newNotices.length < batchSize) {
          hasMore.value = false;
        } else {
          hasMore.value = true;
        }
      } else {
        notices.clear();
        hasMore.value = false;
      }

      isLoading.value = false;
    }, onError: (error) {
      isLoading.value = false;
      hasMore.value = false;
      Get.snackbar("Error", "Something went wrong $error");
    });
  }

  Future<void> fetchMoreNotices() async {
    if (isLoading.value || !hasMore.value) return;
    isLoading.value = true;

    Query nextQuery = _firestore
        .collection(StringConst.notice)
        .orderBy('id', descending: true)
        .limit(batchSize);

    if (_lastDocument != null) {
      nextQuery = nextQuery.startAfterDocument(_lastDocument!);
    }

    final querySnapshot = await nextQuery.get();

    if (querySnapshot.docs.isNotEmpty) {
      _lastDocument = querySnapshot.docs.last;

      List<Notice> newNotices = querySnapshot.docs.map((doc) {
        return Notice.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      notices.addAll(newNotices);

      if (newNotices.length < batchSize) {
        hasMore.value = false;
      }
    } else {
      hasMore.value = false;
    }

    isLoading.value = false;
  }

  Notice? get latestNotice {
    if (notices.isNotEmpty) {
      return notices.first;
    } else {
      return null;
    }
  }
}