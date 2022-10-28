import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF02B8FF),
        automaticallyImplyLeading: false,
        title: Text(
          'Home',
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: AlignmentDirectional(-0.9, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: Text(
                      'Popular',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.network(
                        'https://picsum.photos/seed/133/600',
                        width: 100,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        'https://picsum.photos/seed/710/600',
                        width: 100,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        'https://picsum.photos/seed/58/600',
                        width: 100,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-0.9, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: Text(
                      'Latest releases',
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.network(
                      'https://picsum.photos/seed/133/600',
                      width: 100,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    Image.network(
                      'https://picsum.photos/seed/710/600',
                      width: 100,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    Image.network(
                      'https://picsum.photos/seed/58/600',
                      width: 100,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                Align(
                  alignment: AlignmentDirectional(-0.9, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: Text(
                      'Upcoming ',
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.network(
                      'https://picsum.photos/seed/133/600',
                      width: 100,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    Image.network(
                      'https://picsum.photos/seed/710/600',
                      width: 100,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    Image.network(
                      'https://picsum.photos/seed/58/600',
                      width: 100,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                Align(
                  alignment: AlignmentDirectional(-0.9, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Text(
                      'Lists',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Container(
                    width: 300,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Color(0xFF506870),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Color(0xFF3D3B3B),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 0, 0),
                                  child: Text(
                                    'Top rated games',
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 0, 0),
                                  child: ElevatedButton(
                                    child: (Text('s')),
                                    onPressed: () {
                                      print('Button pressed ...');
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Container(
                    width: 300,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Color(0xFF506870),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Color(0xFF3D3B3B),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 0, 0),
                                  child: Text(
                                    'Most anticipated',
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 0, 0),
                                  child: ElevatedButton(
                                    child: Text('s'),
                                    onPressed: () {
                                      print('Button pressed ...');
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
