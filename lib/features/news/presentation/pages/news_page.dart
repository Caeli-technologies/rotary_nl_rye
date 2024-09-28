// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/domain/news.dart';
import 'package:rotary_nl_rye/features/news/presentation/pages/non_pdf_news.dart';
import 'package:rotary_nl_rye/features/news/presentation/widgets/news_card.dart';
import 'package:rotary_nl_rye/features/news/presentation/widgets/pdf_viewer.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';
import '../../../../core/domain/entities/news.dart';
import '../../../../core/prop.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final NewsBloc _newsBloc = NewsBloc();

  @override
  void initState() {
    super.initState();
    _newsBloc.getNewsData();
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
        title: Text(
          'News',
          textScaler: TextScaler.linear(1.2),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            _buildLocalHeader(),
            const SizedBox(height: 10),
            const Divider(thickness: 2),
            _buildNewsStreamBuilder(),
          ],
        ),
      ),
    );
  }

  // Updated method for loading the header as a local asset
  Widget _buildLocalHeader() {
    return Container(
      height: 170,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(
              'assets/image/homepage/Informatiedag_14_september_2024.jpg'), // Local asset path
          fit: BoxFit.cover,
        ),
      ),
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
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => _handleNewsTap(context, snapshot.data![index]),
                child: NewsCard(news: snapshot.data![index]),
              ),
              separatorBuilder: (context, index) => SizedBox(height: 10),
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
