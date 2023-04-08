import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdsPage extends StatefulWidget {
  const AdsPage({super.key});

  @override
  State<AdsPage> createState() => _AdsPageState();
}

class _AdsPageState extends State<AdsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AdWidget(),
          AdWidget(),
        ],
      ),
    );
  }
}

class AdWidget extends StatelessWidget {
  const AdWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Run',
              style: TextStyle(color: Colors.white, fontSize: 26),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'قث هخ ثقبتهخ قثبتخهثتب عهصنثسب تهعصثا بهعصثايث هخيص هثصعري ثصيثتني ثصنت يي نتثصي ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ),
        Container(
          color: Colors.black,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 0.6,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.6), shape: BoxShape.circle),
              child: Icon(
                Icons.play_arrow,
                size: 40,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              SvgPicture.asset('assets/images/website.svg'),
              Container(
                width: 20,
              ),
              SvgPicture.asset('assets/images/marker.svg'),
              Spacer(),
              Text(
                'تس،ق بآمان',
                style: TextStyle(color: Colors.white, fontSize: 26),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
