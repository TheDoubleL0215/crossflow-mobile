import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SvgPicture.asset("lib/img/welcome_page_banner.svg", height: 400, width: 100,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Üdv!", 
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                "Szinkronizáld a vágólapod a mobilod és a számítógéped között!", 
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20, 
                  color: Theme.of(context).colorScheme.tertiary,
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}

