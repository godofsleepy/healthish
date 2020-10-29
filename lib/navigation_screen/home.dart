import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/contract/event_contract.dart';
import 'package:healthish/presenter/event_presenter.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> implements EventContractView {
  EventPresenter eventPresenter;
  int carouselIndex = 0;
  List<DocumentSnapshot> listEvent = List<DocumentSnapshot>();
  bool loadingEvent = true;
  LatLng currentPosition = LatLng(0.0, 0.0);


  HomeState() {
    eventPresenter = EventPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    eventPresenter.loadEventData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              child: Stack(
                children: [
                  carouselEvent(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            loadingEvent
                                ? "lorem ipsum"
                                : listEvent[carouselIndex].data["title"],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            loadingEvent
                                ? "lorem ipsum"
                                : listEvent[carouselIndex].data["description"],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: dotWidget(),
                              ),
                              RaisedButton(
                                color: Constants.blueColor,
                                textColor: Constants.whiteColor,
                                child: Text("Read"),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                onPressed: () {},
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Temui Kami",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Container(
                    child: GoogleMap(initialCameraPosition: CameraPosition(
                      target: currentPosition,
                      zoom: 14.0,
                    ),),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  carouselEvent() {
    return CarouselSlider.builder(
      itemCount: listEvent.length,
      itemBuilder: itemBuilderCarouselEvent,
      options: CarouselOptions(
        autoPlay: true,
        pageSnapping: true,
        reverse: true,
        onPageChanged: carouselChanged,
        height: 600,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
      ),
    );
  }

  @override
  onErrorEventData(error) {
    print(error.toString());
  }

  @override
  onSuccessEventData(List<DocumentSnapshot> value) {
    setState(() {
      listEvent = value;
      loadingEvent = false;
    });
  }

  Widget itemBuilderCarouselEvent(BuildContext context, int index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.blue,
      child: loadingEvent
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Constants.blueColor,
              ),
            )
          : SafeArea(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: SizedBox.expand(
                      child: FittedBox(
                        child: Image.network(
                          listEvent[index].data["image"],
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  carouselChanged(int index, CarouselPageChangedReason reason) {
    setState(() {
      carouselIndex = index;
    });
  }

  List<Widget> dotWidget() {
    List<Widget> list = List<Widget>();
    for (int i = 0; i < listEvent.length; i++) {
      list.add(Container(
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color:
                i == carouselIndex ? Constants.blueColor : Constants.whiteColor,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        width: i == carouselIndex ? 25 : 12,
        height: 12,
      ));
    }
    return list;
  }
}
