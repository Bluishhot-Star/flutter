import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThirdTab extends StatelessWidget {
  const ThirdTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const chartData = {
      'korea': [
        {
          'imageUrl':
              'https://lh3.googleusercontent.com/UWM-x77xhcEEAK8tKICtlDSxsYedoFxQhdiDPzW-Ww59DWs7rDQpD_idJQ6h5YEJruURgpEr1O-0oq5Y=w544-h544-l90-rj',
          'name': 'Ditto',
          'artist': 'NewJeans',
        },
        {
          'imageUrl':
              'https://lh3.googleusercontent.com/UWM-x77xhcEEAK8tKICtlDSxsYedoFxQhdiDPzW-Ww59DWs7rDQpD_idJQ6h5YEJruURgpEr1O-0oq5Y=w544-h544-l90-rj',
          'name': 'OMG',
          'artist': 'NewJeans',
        },
        {
          'imageUrl':
              'https://lh3.googleusercontent.com/yg7U52lN4NMHddFXE1de6d99puDNeC-1U6q5PnLjXPatrexqW9AOoWC8a5EJBULlXraaEWU8OvKrFYrp1A=w544-h544-l90-rj',
          'name': 'Hype Boy',
          'artist': 'NewJeans',
        },
      ],
      'global': [
        {
          'imageUrl':
              'https://lh3.googleusercontent.com/LvHSTzb8gw7hlPMsDQAPsAXfTUqxIWyAVYS8wIwNly6D8q2vfE7s1LymiywyjmQr2Ns9Yt9NJ7k7nLU=w544-h544-l90-rj',
          'name': 'Shakira: Bzrp Music Sessions, Vol. 53',
          'artist': 'Bizarrap & Shakira',
        },
        {
          'imageUrl':
              'https://lh3.googleusercontent.com/umJNTu_qH_THEHP4XsOb4bMCjKn1nka4c8iz8Vs791pB5aroCWwq4aHC9ds5kCnONrgNUPgPadWnecak=w544-h544-l90-rj',
          'name': 'Flowers',
          'artist': 'Miley Cyrus',
        },
        {
          'imageUrl':
              'https://lh3.googleusercontent.com/D7r1lKjo87IDgF2Xtd8zslFbNra3-lTmpVan1V4Bv3oeeRHZSjd8a1mMS196giIATN4BF4h2vB9vzyxM=w544-h544-l90-rj',
          'name': 'Calm Down',
          'artist': 'Rema & Selena Gomez'
        },
      ],
      'newyork': [
        {
          'imageUrl':
              'https://lh3.googleusercontent.com/umJNTu_qH_THEHP4XsOb4bMCjKn1nka4c8iz8Vs791pB5aroCWwq4aHC9ds5kCnONrgNUPgPadWnecak=w544-h544-l90-rj',
          'name': 'Flowers',
          'artist': 'Miley Cyrus',
        },
        {
          'imageUrl':
              'https://lh3.googleusercontent.com/ii_8E4zawhW8ARpz0GAzFkLGzg9dUOmlmz4Z3skCudi_0IZ6pSKggTj_6iAtPsey7ZaCVHNLfYswhfNr=w544-h544-l90-rj',
          'name': 'Creepin\'',
          'artist': 'Metro Boomin, The Weeknd & 21 Savage',
        },
        {
          'imageUrl':
              'https://lh3.googleusercontent.com/eo8uvebF6IDxFyjHla9I4F91xMUwTmGzT1D4oZL8Z7YVxiVTXDMnn39981gsGmK7bBFe-DO_R9BZfiN6=w544-h544-l90-rj',
          'name': 'The Astronaut',
          'artist': '진 (Jin)',
        },
      ],
    };

    return SafeArea(
      child: Column(
        children: [
          Text(
            "차트",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: ListView(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.25,
                      color: Colors.purple[800],
                    ),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            child: Text(
                              "국가 및 도시별 차트",
                              style: TextStyle(
                                color: Colors.purple[800],
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "전 세계",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 8,
                  color: Colors.grey,
                ),

                // 대한민국 차트 컨테이너
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Text(
                            "대한민국 차트",
                            style: TextStyle(fontSize: 18),
                          ),
                          Spacer(),
                          Text(
                            '모두 보기',
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        ...chartData['korea']!.map(
                          ((song) {
                            String imageUrl = song['imageUrl']!;
                            String name = song['name']!;
                            String artist = song['artist']!;
                            return Padding(
                              padding: EdgeInsets.all(8),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.29,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      imageUrl,
                                      width: MediaQuery.of(context).size.width *
                                          0.29,
                                    ),
                                    Text(
                                      name,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      artist,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 8,
                  color: Colors.grey,
                ),
                // 글로벌 차트 컨테이너
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Text(
                            "글로벌 차트",
                            style: TextStyle(fontSize: 18),
                          ),
                          Spacer(),
                          Text(
                            '모두 보기',
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        ...chartData['global']!.map(
                          ((song) {
                            String imageUrl = song['imageUrl']!;
                            String name = song['name']!;
                            String artist = song['artist']!;
                            return Padding(
                              padding: EdgeInsets.all(8),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.29,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      imageUrl,
                                      width: MediaQuery.of(context).size.width *
                                          0.29,
                                    ),
                                    Text(
                                      name,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      artist,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 8,
                  color: Colors.grey,
                ),

                // 뉴욕 차트 컨테이너
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Text(
                            "뉴욕 차트",
                            style: TextStyle(fontSize: 18),
                          ),
                          Spacer(),
                          Text(
                            '모두 보기',
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        // 스프레드 연산자: 리스트 등의 이터러블 안의 요소를 분해
                        ...chartData['newyork']!.map(
                          ((song) {
                            String imageUrl = song['imageUrl']!;
                            String name = song['name']!;
                            String artist = song['artist']!;
                            return Padding(
                              padding: EdgeInsets.all(8),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.29,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      imageUrl,
                                      width: MediaQuery.of(context).size.width *
                                          0.29,
                                    ),
                                    Text(
                                      name,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      artist,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
