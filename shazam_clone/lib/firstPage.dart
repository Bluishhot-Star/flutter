import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirstTab extends StatelessWidget {
  const FirstTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const songs = [
      {
        'imageUrl': 'https://i.ytimg.com/vi/jAO0KXRdz_4/hqdefault.jpg',
        'title': '가을밤에 든 생각',
        'artist': '잔나비',
      },
      {
        'imageUrl':
            'https://lh3.googleusercontent.com/VW6EYPO-1un9MIKN9EPmfoW8UTPvJHRdHMzL6b46EIcn-affxdrd15E9OhQCSdGsLWxNZO7Z81wZAceW=w544-h544-l90-rj',
        'title': '너에게',
        'artist': 'Halsoon(feat. 현서)',
      },
      {
        'imageUrl':
            'https://lh3.googleusercontent.com/yg7U52lN4NMHddFXE1de6d99puDNeC-1U6q5PnLjXPatrexqW9AOoWC8a5EJBULlXraaEWU8OvKrFYrp1A=w544-h544-l90-rj',
        'title': 'Hype Boy',
        'artist': 'NewJeans',
      },
      {
        'imageUrl':
            'https://lh3.googleusercontent.com/YX1gHUcocnIstBVwMKRWC_s9Bgtyu9D5Ug0n_qbGOGfiIij_KAYS1SXglUYVgDEwQaew1WviUi5k87Kf=w544-h544-l90-rj',
        'title': 'Summer',
        'artist': 'The Volunteers',
      },
      {
        'imageUrl':
            'https://lh3.googleusercontent.com/7vAsuVmMb0SBsFYbVcVZiSFoM6sXnsg06F3PQNfEc8u-8qVYYzWFcTpS8J3ZdASVr1ZmmXduRsebLytvzg=w544-h544-l90-rj',
        'title': 'COBALT',
        'artist': '김뜻돌',
      },
      {
        'imageUrl':
            'https://lh3.googleusercontent.com/nkzJPmS91c_YpX77Dlbxl6CPRc3h74ewVJ4Pgs2r7DqCdCsg-p2VmwHY9X06SBIaHAx8dgvb2Sv-YITJ=w544-h544-l90-rj',
        'title': '이뤄야만해',
        'artist': 'JUTO(feat. JAEHA)',
      },
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Icon(Icons.settings),
                ),
                Text(
                  "라이브러리",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(null),
              ],
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  ImageIcon(
                    NetworkImage("https://i.ibb.co/hxNbZ8p/shazam.png"),
                    size: 18,
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Shazam",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 12),
                  Text(
                    "아티스트",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Icon(Icons.music_note),
                  SizedBox(width: 12),
                  Text(
                    "회원님을 위한 재생 목록",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Text(
                    "최근 Shazam",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: songs.length,
                itemBuilder: (BuildContext context, index) {
                  final music = songs[index]["title"];
                  final ImageURl = songs[index]["imageUrl"].toString();
                  final title = songs[index]["title"].toString();
                  final artist = songs[index]["artist"].toString();
                  return Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 1,
                            spreadRadius: 1,
                          )
                        ]
                        // border: Border.all(color: Colors.black26, width: 1),
                        ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8)),
                          child: Image.network(
                            ImageURl,
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.width *
                                0.5 *
                                4.8 /
                                3 *
                                0.55,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                artist,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey[600]),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Icon(Icons.apple),
                                  Text(
                                    "Apple Music",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
