import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:go_router/go_router.dart';

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
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          SliverAppBar(
            expandedHeight: 30,
            pinned: false,
            floating: false,
            backgroundColor: Color(0xFF00ADFF),
            automaticallyImplyLeading: false,
            actions: [],
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
                    child: Text(
                      'Home',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 26,
                      ),
                    ),
                  ),
                ],
              ),
              centerTitle: false,
              expandedTitleScale: 1.0,
            ),
            elevation: 2,
          )
        ],
        body: Builder(
          builder: (context) {
            return SafeArea(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Align(
                              alignment: AlignmentDirectional(-0.9, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12, 10, 0, 10),
                                child: Text(
                                  'Popular',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 20, 0),
                              child: InkWell(
                                onTap: () {
                                  // context.pushNamed('HomePage');
                                },
                                child: const Text(
                                  'See all',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 80),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(7, 0, 7, 0),
                                child: InkWell(
                                  onTap: () {
                                    context.go('/gamedetails');
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      'https://picsum.photos/seed/133/600',
                                      width: 100,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(7, 0, 7, 0),
                                child: Image.network(
                                  'https://picsum.photos/seed/925/600',
                                  width: 100,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(7, 0, 7, 0),
                                child: Image.network(
                                  'https://picsum.photos/seed/710/600',
                                  width: 100,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 7, 0),
                                child: Image.network(
                                  'https://picsum.photos/seed/716/600',
                                  width: 100,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              //-----
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Align(
                              alignment: AlignmentDirectional(-0.9, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12, 10, 0, 10),
                                child: Text(
                                  'Game Categories',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 20, 0),
                              child: InkWell(
                                onTap: () async {},
                                child: const Text(
                                  'See all',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 80),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(7, 0, 7, 0),
                                child: InkWell(
                                  child: Container(
                                    width: 100,
                                    height: 200,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 20, 0, 0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
                                                topLeft: Radius.circular(0),
                                                topRight: Radius.circular(0),
                                              ),
                                              child: Image.network(
                                                'https://picsum.photos/seed/350/600',
                                                width: 100,
                                                height: 190,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0, -1),
                                          child: InkWell(
                                            child: Container(
                                              width: 100,
                                              height: 20,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFF00ADFF),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(0),
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                ),
                                                shape: BoxShape.rectangle,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Align(
                                          alignment:
                                              AlignmentDirectional(0, -0.98),
                                          child: SelectionArea(
                                              child: Text(
                                            'Action',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(7, 0, 7, 0),
                                child: Container(
                                  width: 100,
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 20, 0, 0),
                                          child: Image.network(
                                            'https://picsum.photos/seed/350/600',
                                            width: 100,
                                            height: 190,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0, -1),
                                        child: Container(
                                          width: 100,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF00ADFF),
                                            shape: BoxShape.rectangle,
                                          ),
                                        ),
                                      ),
                                      const Align(
                                        alignment:
                                            AlignmentDirectional(0, -0.98),
                                        child: SelectionArea(
                                            child: Text(
                                          'Horror',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(7, 0, 7, 0),
                                child: Container(
                                  width: 100,
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 20, 0, 0),
                                          child: Image.network(
                                            'https://picsum.photos/seed/350/600',
                                            width: 100,
                                            height: 190,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0, -1),
                                        child: Container(
                                          width: 100,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF00ADFF),
                                            shape: BoxShape.rectangle,
                                          ),
                                        ),
                                      ),
                                      const Align(
                                        alignment:
                                            AlignmentDirectional(0, -0.98),
                                        child: SelectionArea(
                                            child: Text(
                                          'Arcade',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(7, 0, 7, 0),
                                child: Container(
                                  width: 100,
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 20, 0, 0),
                                          child: Image.network(
                                            'https://picsum.photos/seed/350/600',
                                            width: 100,
                                            height: 190,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0, -1),
                                        child: Container(
                                          width: 100,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF00ADFF),
                                            shape: BoxShape.rectangle,
                                          ),
                                        ),
                                      ),
                                      const Align(
                                        alignment:
                                            AlignmentDirectional(0, -0.98),
                                        child: SelectionArea(
                                            child: Text(
                                          'Strategy',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(7, 0, 7, 0),
                                child: Container(
                                  width: 100,
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 20, 0, 0),
                                          child: Image.network(
                                            'https://picsum.photos/seed/350/600',
                                            width: 100,
                                            height: 190,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0, -1),
                                        child: Container(
                                          width: 100,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF00ADFF),
                                            shape: BoxShape.rectangle,
                                          ),
                                        ),
                                      ),
                                      const Align(
                                        alignment:
                                            AlignmentDirectional(0, -0.98),
                                        child: SelectionArea(
                                            child: Text(
                                          'MMO',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(7, 0, 7, 0),
                                child: Container(
                                  width: 100,
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 20, 0, 0),
                                          child: Image.network(
                                            'https://picsum.photos/seed/350/600',
                                            width: 100,
                                            height: 190,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0, -1),
                                        child: Container(
                                          width: 100,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF00ADFF),
                                            shape: BoxShape.rectangle,
                                          ),
                                        ),
                                      ),
                                      const Align(
                                        alignment:
                                            AlignmentDirectional(0, -0.98),
                                        child: SelectionArea(
                                            child: Text(
                                          'Fighter 2D',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(7, 0, 7, 0),
                                child: Container(
                                  width: 100,
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 20, 0, 0),
                                          child: Image.network(
                                            'https://picsum.photos/seed/350/600',
                                            width: 100,
                                            height: 190,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0, -1),
                                        child: Container(
                                          width: 100,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF00ADFF),
                                            shape: BoxShape.rectangle,
                                          ),
                                        ),
                                      ),
                                      const Align(
                                        alignment:
                                            AlignmentDirectional(0, -0.98),
                                        child: SelectionArea(
                                            child: Text(
                                          'FPS',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(7, 0, 7, 0),
                                child: Container(
                                  width: 100,
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 20, 0, 0),
                                          child: Image.network(
                                            'https://picsum.photos/seed/350/600',
                                            width: 100,
                                            height: 190,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0, -1),
                                        child: Container(
                                          width: 100,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF00ADFF),
                                            shape: BoxShape.rectangle,
                                          ),
                                        ),
                                      ),
                                      const Align(
                                        alignment:
                                            AlignmentDirectional(0, -0.98),
                                        child: SelectionArea(
                                            child: Text(
                                          'Puzzles',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Align(
                        alignment: AlignmentDirectional(-0.9, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: Text(
                            'Upcoming ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 80),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(7, 0, 7, 0),
                                child: InkWell(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      'https://picsum.photos/seed/133/600',
                                      width: 100,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(7, 0, 7, 0),
                                child: Image.network(
                                  'https://picsum.photos/seed/925/600',
                                  width: 100,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(7, 0, 7, 0),
                                child: Image.network(
                                  'https://picsum.photos/seed/710/600',
                                  width: 100,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 7, 0),
                                child: Image.network(
                                  'https://picsum.photos/seed/716/600',
                                  width: 100,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ), //---
                            ],
                          ),
                        ),
                      ),
                      const Align(
                        alignment: AlignmentDirectional(-0.9, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text(
                            'Lists',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 22,
                            ),
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
                            borderRadius: BorderRadius.circular(5),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Color(0xFF3D3B3B),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Top rated games',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    height: 30,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: const Text(
                                        'Check out',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color(0x004B39EF)),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ))),
                                    ),
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
                            borderRadius: BorderRadius.circular(5),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Color(0xFF3D3B3B),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    const Text(
                                      'Most anticipated games',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    // ignore: sort_child_properties_last
                                    child: const Text(
                                      'Check out',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color(0x004B39EF)),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ))),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Align(
                              alignment: AlignmentDirectional(-0.9, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 0, 10),
                                child: Text(
                                  'Follow Us On',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                        child: Container(
                          width: 400,
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                /* borderColor: Colors.transparent,
                                borderRadius: 30,
                                borderWidth: 1,
                                buttonSize: 60, */
                                icon: FaIcon(
                                  FontAwesomeIcons.youtube,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              ),
                              IconButton(
                                icon: FaIcon(
                                  FontAwesomeIcons.instagram,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              ),
                              IconButton(
                                icon: FaIcon(
                                  FontAwesomeIcons.twitter,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
