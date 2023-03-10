import 'package:currency_converter_app/responsive.dart';
import 'package:currency_converter_app/widget/converter_widget.dart';
import 'package:currency_converter_app/widget/footer_widget.dart';
import 'package:currency_converter_app/widget/menu_drawer.dart';
import 'package:currency_converter_app/widget/top_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  double _opacity = 0;
  double _screenPosition = 0;

  _scrollListener() {
    setState(() {
      _screenPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    _opacity = _screenPosition < _screenSize.height * 0.50 ? _screenPosition / (_screenSize.height * 0.50) : 1;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Responsive.isSmallScreen(context)
          ? AppBar(
              backgroundColor: Color(0xFF59C6C3).withOpacity(_opacity),
              elevation: 30,
              title: Text(
                'Sese Exchange',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 3,
                ),
              ),
            )
          : PreferredSize(
              preferredSize: Size(_screenSize.width, 1000),
              child: TopBar(opacity: _opacity),
            ),
      drawer: MenuDrawer(),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  child: SizedBox(
                    height: _screenSize.height * 0.31,
                    width: _screenSize.width,
                    child: Image.asset(
                      'assets/images/newlogo.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  color: Colors.black12,
                  padding: EdgeInsets.only(top: _screenSize.height * 0.20, left: _screenSize.width /50, right: _screenSize.width / 50),
                  child: Column(
                    children: [

                      ConverterWidget(
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}
