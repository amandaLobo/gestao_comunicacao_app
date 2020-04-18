import 'package:br/tabs/feed_tab.dart';
import 'package:br/tabs/my_projects_tab.dart';
import 'package:br/tabs/notification_tab.dart';
import 'package:br/tabs/profile_tab.dart';
import 'package:br/widgets/custom_drawer.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {


  final List<Widget> tabs = [
    FeedTab(),
    MyProjectsTab(),
    NotificationTab(),
    ProfileTab(),
  ];

      String title = 'Feed';
      Color _color = Color.fromARGB(255, 30, 54, 76);
      TabController _tabController;

      void changeTitle(int index){
        switch(index){
          case 0:
            setState(() => this.title = 'Feed' );
            break;
          case 1:
            setState(() => this.title = 'Projetos' );
            break;
          case 2:
            setState(() => this.title = 'Notificações' );
            break;
          case 3:
            setState(() => this.title = 'Perfil' );
            break;
        }
      }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title,
            style: GoogleFonts.nunito(
                color: Color.fromARGB(255, 30, 54, 76),
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      drawer: CustomDrawer(_tabController),
      body: TabBarView(
        controller: _tabController,
        children: tabs,
        physics: NeverScrollableScrollPhysics(),

      ),
      bottomNavigationBar: CurvedNavigationBar(

        color: Color.fromARGB(255, 103, 181, 254),
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.white,
        height: 50,
        items: <Widget>[
          Icon(FontAwesomeIcons.envelopeOpen, size:20, color: _color),
          Icon(FontAwesomeIcons.folderOpen, size:20, color: _color),
          Icon(FontAwesomeIcons.bell, size:20, color: _color),
          Icon(FontAwesomeIcons.user, size:20, color: _color)
        ],
        animationDuration: Duration(
            milliseconds: 200
        ),
        index: 0,
        animationCurve: Curves.bounceInOut,
        onTap: (index){
          _tabController.animateTo(index);
          changeTitle(index);
        },
      )
    );
  }
}