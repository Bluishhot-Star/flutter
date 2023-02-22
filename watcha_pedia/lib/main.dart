import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'book.dart';
import 'book_service.dart';

import 'package:webview_flutter/webview_flutter.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  // Provider 사용을 통해 데이터 전역에서 접근 가능하도록
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => BookService()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var bottomNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        SearchPage(),
        LikedBookPage(),
      ].elementAt(bottomNavIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        iconSize: 22,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            bottomNavIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '검색',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: '좋아요',
          ),
        ],
        currentIndex: bottomNavIndex,
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookService>(
      builder: (context, bookService, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 80,
            title: TextField(
              onSubmitted: (value) {
                bookService.search(value);
              },
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                hintText: "작품, 감독, 배우, 컬렉션, 유저 명",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: ListView.separated(
              itemCount: bookService.bookList.length,
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemBuilder: (context, index) {
                // 비어있으면 그냥 빈 상자
                if (bookService.bookList.isEmpty) return SizedBox();
                Book book = bookService.bookList.elementAt(index);
                return BookTile(book: book);
              },
            ),
          ),
        );
      },
    );
  }
}

class BookTile extends StatelessWidget {
  const BookTile({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  Widget build(BuildContext context) {
    // BookTile 의 상위요소인 SearchPage가 Consumer로 묶여 때문에 context.read()를 사용해도 전체가 새로고침 된다!
    BookService bookService = context.read<BookService>();

    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewPage(
              url: book.previewLink.replaceFirst('http', 'https'),
            ),
          ),
        );
      },
      title: Text(
        book.title,
        style: TextStyle(
          fontSize: 16,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      leading: Image.network(
        book.thumbnail,
        fit: BoxFit.fitHeight,
      ),
      subtitle: Text(
        //
        "${book.authors.join(', ')}\n${book.publishedDate}",
      ),
      trailing: IconButton(
        icon: bookService.likedBookList.map((book) => book.id).contains(book.id)
            ? Icon(
                Icons.star,
                color: Colors.amber,
              )
            : Icon(
                Icons.star_border,
                color: Colors.grey,
              ),
        onPressed: () {
          bookService.toggleLikeBook(book: book);
        },
      ),
    );
  }
}

class LikedBookPage extends StatelessWidget {
  const LikedBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookService>(
      builder: (context, bookService, child) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: ListView.separated(
              itemCount: bookService.likedBookList.length,
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemBuilder: (context, index) {
                // 비어있으면 그냥 빈 상자
                if (bookService.likedBookList.isEmpty) return SizedBox();
                Book book = bookService.likedBookList.elementAt(index);
                return BookTile(book: book);
              },
            ),
          ),
        );
      },
    );
  }
}

class WebViewPage extends StatelessWidget {
  WebViewPage({super.key, required this.url});

  String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(url),
      ),
      body: WebView(initialUrl: url),
    );
  }
}
