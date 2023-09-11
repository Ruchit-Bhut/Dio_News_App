import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getApi();
  }

  bool isLoad = false;
  late List<dynamic> datas;

  Future<String> getApi() async {
    setState(() {
      isLoad = true;
    });
    final dio = Dio();
    var res = await dio.get(
        "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=49c755a7a4694e05bc7b88713a4acc26");

    setState(() {
      datas = res.data['articles'];
      isLoad = false;
    });
    return "success";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Dio News Data"),
          centerTitle: true,
        ),
        body: isLoad
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: datas.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Column(
                            children: [
                              Image.network(datas[index]['urlToImage']),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  datas[index]['title'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
