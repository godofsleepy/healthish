import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthish/contract/patient_contract.dart';
import 'package:healthish/detail_screen/booking_status.dart';
import 'package:healthish/presenter/patient_presenter.dart';
import 'package:intl/intl.dart';
import 'package:healthish/detail_screen/change_pasient/change_patient.dart';
import '../constants.dart';

class DetailBooking extends StatefulWidget {
  final String image;
  final String name;
  final String specialist;
  final String idDoctor;
  final String idUser;

  DetailBooking(
      {this.image, this.name, this.specialist, this.idDoctor, this.idUser});

  @override
  DetailBookingState createState() => DetailBookingState();
}

class DetailBookingState extends State<DetailBooking>
    implements PatientContractView {
  String date = DateFormat('EEEE dd-MM-yyyy').format(DateTime.now());
  String time = DateFormat('HH:mm').format(DateTime.now());
  PatientPresenter patientPresenter;
  bool loadingPatient = true;
  List<DocumentSnapshot> listPatient = List<DocumentSnapshot>();
  int selectedPatient = 0;

  TextEditingController messageController = TextEditingController();

  DetailBookingState() {
    patientPresenter = PatientPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    patientPresenter.loadPatientData(widget.idUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: Container(
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 28,
                icon: Icon(
                  Icons.arrow_back,
                  color: Constants.blackColor,
                ),
                onPressed: () {
                  return Navigator.pop(context);
                },
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Konfirmasi Booking",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Constants.blackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(18),
                child: ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000),
                      color: Constants.greyColor,
                    ),
                    width: 100,
                    height: 100,
                    child: SizedBox.expand(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Image.network(widget.image),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    widget.name,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  subtitle: Text(
                    widget.specialist,
                    style: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.grey),
                  ),
                ),
              ),
              Divider(
                thickness: 6,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Booking Detail",
                  style: TextStyle(
                      color: Constants.blueColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
              listPatient.isEmpty
                  ? Container(
                      alignment: Alignment.center,
                      color: const Color(0xfff4f4f4),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: FlatButton(
                          textColor: Constants.blueColor,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangePatient(
                                  selectedPatient: selectedPatient,
                                  userId: widget.idUser,
                                ),
                              ),
                            ).then((value) {
                              setState(() {
                                loadingPatient = true;
                                selectedPatient = value;
                              });
                              patientPresenter.loadPatientData(widget.idUser);
                            });
                          },
                          child: Text("Tambah Pasien"),
                        ),
                      ),
                    )
                  : loadingPatient
                      ? Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Constants.blueColor,
                          ),
                        )
                      : Container(
                          color: const Color(0xfff4f4f4),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Booking Untuk",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                    FlatButton(
                                      textColor: Constants.blueColor,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ChangePatient(
                                              selectedPatient: selectedPatient,
                                              userId: widget.idUser,
                                            ),
                                          ),
                                        ).then((value) {
                                          setState(() {
                                            loadingPatient = true;
                                            selectedPatient = value;
                                          });
                                          patientPresenter
                                              .loadPatientData(widget.idUser);
                                        });
                                      },
                                      child: Text("Ganti Pasien"),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Nama : ${listPatient[selectedPatient].data['name']}",
                                  style: TextStyle(color: Color(0xff8B8B8B)),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                    "Jenis Kelamin : ${listPatient[selectedPatient].data['gender']}",
                                    style: TextStyle(color: Color(0xff8B8B8B))),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                    "Status : ${listPatient[selectedPatient].data['status']}",
                                    style: TextStyle(color: Color(0xff8B8B8B)))
                              ],
                            ),
                          ),
                        ),
              Padding(
                padding: EdgeInsets.only(top: 8, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Booking Tanggal",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        Row(
                          children: [
                            Text(
                              date,
                              style: TextStyle(color: Color(0xffEE7421)),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.calendar_today_outlined,
                                color: Constants.blueColor,
                              ),
                              onPressed: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2050),
                                ).then((valueDate) {
                                  print(valueDate);
                                  showTimePicker(
                                    initialTime: TimeOfDay.now(),
                                    context: context,
                                  ).then((valueTime) {
                                    print(valueTime);
                                    setState(() {
                                      date = DateFormat('EEEE dd-MM-yyyy')
                                          .format(valueDate);
                                      time = valueTime.format(context);
                                    });
                                  });
                                });
                              },
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Pesan",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: messageController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Constants.whiteColor,
        child: Padding(
          padding: EdgeInsets.only(
            top: 18,
            left: 14,
            bottom: 14,
            right: 14,
          ),
          child: RaisedButton(
            padding: EdgeInsets.all(12),
            textColor: Constants.whiteColor,
            color: Constants.blueColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingStatus(),
                ),
              );
            },
            child: Text(
              'Konfirmasi',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  onErrorPatientData(error) {
    // TODO: implement onErrorPatientData
    throw UnimplementedError();
  }

  @override
  onSuccessPatientData(List<DocumentSnapshot> value) {
    setState(() {
      listPatient = value;
      loadingPatient = false;
    });
  }
}
