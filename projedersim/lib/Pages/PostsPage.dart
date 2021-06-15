import 'package:flutter/material.dart';
import 'package:projedersim/Models/Posts.dart';
import 'package:projedersim/Models/Users.dart';
import 'package:projedersim/Services/FirestoreService.dart';
import 'package:projedersim/Widgets/PostCard.dart';

class TekliGonderi extends StatefulWidget {
  final String gonderiId;
  final String gonderiSahibiId;

  const TekliGonderi({Key key, this.gonderiId, this.gonderiSahibiId}) : super(key: key);

  @override
  _TekliGonderiState createState() => _TekliGonderiState();
}

class _TekliGonderiState extends State<TekliGonderi> {
  Gonderi _gonderi;
  Kullanici _gonderiSahibi;
  bool _yukleniyor = true;

  @override
  void initState() {
    super.initState();
    gonderiGetir();
  }

  gonderiGetir() async {
    Gonderi gonderi = await FireStoreServisi().tekliGonderiGetir(widget.gonderiId, widget.gonderiSahibiId);
    if(gonderi != null){
      Kullanici gonderiSahibi = await FireStoreServisi().kullaniciGetir(gonderi.yayinlayanId);

      setState(() {
        _gonderi = gonderi;
        _gonderiSahibi = gonderiSahibi;
        _yukleniyor = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          title: Text("Gönderi", style: TextStyle(color: Colors.black),),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: !_yukleniyor ? GonderiKarti(gonderi: _gonderi, yayinlayan: _gonderiSahibi,) : Center(child: CircularProgressIndicator())
    );
  }
}
