import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'book.dart';
import 'main.dart';

class BookService extends ChangeNotifier {
  BookService() {
    loadLikedBookList();
  }

  List<Book> bookList = []; // 책 목록
  List<Book> likedBookList = []; // 좋아요 한 책 목록

  void toggleLikeBook({required Book book}) {
    String bookId = book.id;
    // 이미 좋아요를 누른 책이라면 좋아요리스트에서 제거
    if (likedBookList.map((book) => book.id).contains(bookId)) {
      likedBookList.removeWhere((book) => book.id == bookId);
    } else {
      likedBookList.add(book);
    }
    notifyListeners();
    saveLikedBookList();
  }

  void search(String q) async {
    bookList.clear(); // 검색 버튼 누를 때 이전 데이터들 지우기
    if (q.isNotEmpty) {
      Response res = await Dio().get(
        'https://www.googleapis.com/books/v1/volumes?q=$q&startIndex=0&maxResult=40&orderBy=newest',
      );
      List items = res.data['items'];

      for (Map<String, dynamic> item in items) {
        Book book = Book(
          id: item['id'],
          title: item['volumeInfo']['title'] ?? "",
          subtitle: item['volumeInfo']['subtitle'] ?? "",
          authors: item['volumeInfo']['authors'] ?? [],
          publishedDate: item['volumeInfo']['publishedDate'] ?? "",
          thumbnail: item['volumeInfo']['imageLinks']?['thumbnail'] ??
              "https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg",
          previewLink: item['volumeInfo']['previewLink'] ?? "",
          // infoLink: item['volumeInfo']['previewLink'] ?? "",
        );
        bookList.add(book);
      }
    }
    notifyListeners(); //Consumer로 등록된 모든 위젯의 builder 재호출
  }

  saveLikedBookList() {
    List likedBookJsonList =
        likedBookList.map((book) => book.toJson()).toList();
    // [{"content": "1"}, {"content": "2"}]

    String jsonString = jsonEncode(likedBookJsonList);
    // '[{"content": "1"}, {"content": "2"}]'

    prefs.setString('likedBookList', jsonString);
  }

  loadLikedBookList() {
    String? jsonString = prefs.getString('likedBookList');
    // '[{"content": "1"}, {"content": "2"}]'

    if (jsonString == null) return; // null 이면 로드하지 않음

    List likedBookJsonList = jsonDecode(jsonString);
    // [{"content": "1"}, {"content": "2"}]

    likedBookList =
        likedBookJsonList.map((json) => Book.fromJson(json)).toList();
  }
}
