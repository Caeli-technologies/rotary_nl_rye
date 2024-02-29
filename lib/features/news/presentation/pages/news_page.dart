// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/domain/news.dart';
import 'package:rotary_nl_rye/features/news/presentation/pages/non_pdf_news.dart';
import 'package:rotary_nl_rye/features/news/presentation/widgets/pdf_viewer.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';
import '../../../../core/domain/entities/news.dart';
import '../../../../core/prop.dart';

class NewsPage extends StatefulWidget {
  // final News news;

// NewsPage({required this.news});

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final NewsBloc _newsBloc = NewsBloc();
  //_NewsPageState({required News news}) : _news = news;
  //final News _news;
  // List _stories = [];
  // bool _isLoading = true;

  //Fetch content from the json file
  // Future readJson(String url) async {
  //   final response = await data.getDataNews(url);
  //   //await rootBundle.loadString('assets/test/news.json');
  //   final info = await json.decode(response);
  //   setState(() {
  //     _stories = info["news"];
  //     _isLoading = false;
  //   });
  // }
  //
  // _updateNews(News news) {
  //   readJson(news.jsonUrl);
  // }

  // late List data;
  // late List<String> imageList = [];

  // Future<String> fetchDataFromApi() async {
  //   var jsonData = await http.get(Uri.parse(
  //       "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/news/new-header.json"));
  //   var fetchData = jsonDecode(jsonData.body);

  //   setState(() {
  //     data = fetchData;
  //     data.forEach((element) {
  //       imageList.add(element);
  //     });
  //   });
  //   // print(imageList);
  //   return "Success";
  // }

  @override
  void initState() {
    super.initState();
    _newsBloc.getNewsData();
    _removeBadge();
  }

  Future<void> _removeBadge() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('newsBadge', 0);
  }

  @override
  void dispose() {
    _newsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
            MediaQuery.of(context).platformBrightness == Brightness.light
                ? SystemUiOverlayStyle.dark
                : SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: UniformBackButton(),
        title: Text('News',
            textScaler: TextScaler.linear(1.2),
            style:
                TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            _buildHeaderStreamBuilder(),
            const SizedBox(height: 10),
            const Divider(thickness: 2),
            _buildNewsStreamBuilder(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderStreamBuilder() {
    return StreamBuilder<String>(
      stream: _newsBloc.header,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CachedNetworkImage(
            height: 170,
            width: double.infinity,
            imageUrl: snapshot.data!,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildNewsStreamBuilder() {
    return StreamBuilder<List<News>>(
      stream: _newsBloc.news,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.64,
            child: ListView.separated(
              // Use ListView.separated for easy spacing
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => _handleNewsTap(context, snapshot.data![index]),
                child: NewsCard(news: snapshot.data![index]),
              ),
              separatorBuilder: (context, index) =>
                  SizedBox(height: 10), // Spacing between items
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  void _handleNewsTap(BuildContext context, News news) {
    if (news.isPdf) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PDFPage(pdfUrl: news.pdf!, data: news)));
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => NonPDFPage(data: news)));
    }
  }
}

class NewsCard extends StatelessWidget {
  final News news;

  const NewsCard({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.themeShadeColor,
        borderRadius: const BorderRadius.all(Radius.circular(14)),
      ),
      child: Row(
        children: <Widget>[
          CachedNetworkImage(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 120,
            imageUrl: news.images,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                image:
                    DecorationImage(image: imageProvider, fit: BoxFit.contain),
              ),
            ),
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    news.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Palette.indigo, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    news.description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Palette.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
