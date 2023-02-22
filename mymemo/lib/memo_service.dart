import 'dart:convert';
import 'package:flutter/material.dart';
import 'main.dart';

class Memo {
  Memo({
    required this.content,
    required this.pinned,
    this.updatedAt,
  });
  String content;
  bool pinned;
  DateTime? updatedAt;

  Map toJson() {
    return {
      'content': content,
      'pinned': pinned,
      'updatedAt': updatedAt?.toIso8601String(), //String타입으로
    };
  }

  factory Memo.fromJson(json) {
    return Memo(
      content: json['content'],
      pinned: json['pinned'] ?? false, //null일 경우 false를 할당
      updatedAt:
          json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt']),
    );
  }
}

class MemoService extends ChangeNotifier {
  MemoService() {
    loadMemoList();
  }

  // dummy Data 앱 첫 시작시에만 유효할 것! / 이유는 loadMemoList()에 의해 보여지지 않음
  List<Memo> memoList = [
    Memo(
        content: "장보기 목록 : 사과, 수박, 참외, 젤리!!!, 깡냥이(품절)",
        pinned: false,
        updatedAt: DateTime.now()),
    Memo(content: "새 메모", pinned: false, updatedAt: DateTime.now()),
  ];

  //메소드 정의
  createMemo({required String content}) {
    Memo memo =
        Memo(content: content, pinned: false, updatedAt: DateTime.now());
    memoList.add(memo);
    notifyListeners(); // Consumer<MemoService>의 builder 부분을 호출해서 화면 새로고침
    saveMemoList();
  }

  updateMemo({required int index, required String content}) {
    Memo memo = memoList[index];
    memo.content = content;
    memo.updatedAt = DateTime.now();
    notifyListeners();
    saveMemoList();
  }

  deleteMemo({required int index}) {
    memoList.removeAt(index);
    notifyListeners();
    saveMemoList();
  }

  saveMemoList() {
    List memoJsonList =
        memoList.map((memo) => memo.toJson()).toList(); //map으로 바꾸고 리스트로 바꿈
    // [{"content": "1"}, {"content": "2"}]
    String jsonString = jsonEncode(memoJsonList);
    // '[{"content": "1"}, {"content": "2"}]'
    prefs.setString('memoList', jsonString);
  }

  loadMemoList() {
    String? jsonString = prefs.getString('memoList');
    // '[{"content": "1"}, {"content": "2"}]'
    if (jsonString == null) return;

    List memoJsonList = jsonDecode(jsonString);
    // [{"content": "1"}, {"content": "2"}]
    memoList = memoJsonList.map((json) => Memo.fromJson(json)).toList();
  }

  updatePin({required int index}) {
    Memo memo = memoList[index];
    memo.pinned = !memo.pinned;
    memoList = [
      ...memoList.where((element) => element.pinned),
      ...memoList.where((element) => !element.pinned)
    ];
    notifyListeners();
    saveMemoList();
  }
}
