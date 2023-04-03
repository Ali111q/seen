import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AdPage extends StatelessWidget {
  const AdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(33),
            color: Color(0xff789FA0),
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/chart.png',
                      ),
                      fit: BoxFit.fill)),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.width * 0.6,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.width * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                  ],
                ),
              ),
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(33),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: Text(
                  'اتصل بنا',
                  style: TextStyle(color: Colors.white, fontSize: 26),
                ),
              ),
              Container(
                height: 20,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    color: Color(0xff0A3249),
                    borderRadius: BorderRadius.circular(33),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [Text('data'), Text('data')],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [Text('data'), Text('data')],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [Text('data'), Text('data')],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Material(
          borderRadius: BorderRadius.circular(33),
          elevation: 3,
          color: Color(0xff0A3249),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.width * 0.2,
            child: Center(
              child: Text(
                'seen.A.D@gmail.com',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
