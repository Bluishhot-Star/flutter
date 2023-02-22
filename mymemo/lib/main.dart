import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'memo_service.dart';

// 언해 코드 어디서든 SharedPreferences 객체를 사용할 수 있도록 전역변수 선언
late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 인스턴스 생성
  prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MemoService()),
      ],
      child: const MyApp(),
    ),
  );
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
  @override
  Widget build(BuildContext context) {
    return Consumer<MemoService>(
      builder: (context, memoService, child) {
        List<Memo> memoList = memoService.memoList;

        return Scaffold(
          backgroundColor: Colors.grey[250],
          appBar: AppBar(
            backgroundColor: Colors.blue[400],
            title: Text(
              "MEMO 냥이🐱",
              style: TextStyle(color: Colors.black87),
            ),
          ),
          body: memoList.isEmpty
              ? Center(child: Text("메모를 작성해 주세요"))
              : ListView.builder(
                  itemCount: memoList.length,
                  itemBuilder: (context, index) {
                    Memo memo = memoList[index];
                    return Card(
                      child: ListTile(
                        leading: SizedBox(
                          width: 20,
                          height: 20,
                          child: memoList[index].pinned
                              ? IconButton(
                                  icon: Icon(
                                    CupertinoIcons.paw,
                                    size: 20,
                                    color: Colors.blue[300],
                                  ),
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    memoService.updatePin(index: index);
                                  },
                                )
                              : IconButton(
                                  icon: Icon(CupertinoIcons.circle, size: 20),
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    memoService.updatePin(index: index);
                                  },
                                ),
                        ),
                        title: Text(
                          memo.content,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Text(memo.updatedAt == null
                            ? ""
                            : memo.updatedAt.toString().substring(0, 19)),
                        onTap: () async{
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailPage(
                                index: index,
                              ),
                            ),
                          );
                          if (memo.content.isEmpty) {
                            memoService.deleteMemo(index: index);
                          }
                        },
                      ),
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue[300],
            child: Icon(Icons.add),
            onPressed: () async{
              // + 버튼 클릭시 메모 생성 및 수정 페이지로 이동
              memoService.createMemo(content: '');
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailPage(
                    // 방금 생성한 마지막 요소에 접근
                    index: memoService.memoList.length - 1,
                  ),
                ),
              );
              if (memoList[memoService.memoList.length - 1].content.isEmpty) {
                memoService.deleteMemo(index: memoList.length - 1);
              }
            },
          ),
        );
      },
    );
  }
}

class DetailPage extends StatelessWidget {
  DetailPage({super.key, required this.index});
  final int index;

  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MemoService memoService = context.read<MemoService>();
    Memo memo = memoService.memoList[index];

    contentController.text = memo.content;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        leading: BackButton(color: Colors.black54),
        actions: [
          IconButton(
            // 삭제 버튼 클릭시
            onPressed: () {
              showDeleteDialog(context, memoService);
            },
            icon: Icon(Icons.delete, color: Colors.black54),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: contentController,
          decoration: InputDecoration(
            hintText: "메모를 입력하세요",
            border: InputBorder.none,
          ),
          autofocus: true,
          maxLines: null,
          expands: true,
          keyboardType: TextInputType.multiline,
          onChanged: (value) {
            //텍스트 필드의 값이 변할 때
            memoService.updateMemo(index: index, content: value);
          },
        ),
      ),
    );
  }

// Extracted Method --> Refactoring
  void showDeleteDialog(BuildContext context, MemoService memoService) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("정말 삭제할고양?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "취소",
              ),
            ),
            Column(
              children: [
                TextButton.icon(
                  onPressed: () {
                    memoService.deleteMemo(index: index);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    CupertinoIcons.paw,
                    color: Colors.pink[300],
                    size: 24.0,
                  ),
                  label: Text(
                    '냥',
                    style: TextStyle(
                      color: Colors.pink[300],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
