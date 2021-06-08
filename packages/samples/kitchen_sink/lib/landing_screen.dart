import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFB),
      body: DefaultTextStyle(
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: Color(0xFF121826),
          fontSize: 44,
        ),
        child: Center(
          child: SizedBox(
            width: 1280,
            child: ListView(
              children: [
                const SizedBox(height: 48),
                Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Color(0xFFEDEEF0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 24,
                              horizontal: 48,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 64),
                                Text("On ne joue pas,"),
                                const SizedBox(height: 2),
                                Text(
                                  "on gagne !",
                                  style: TextStyle(color: Color(0xFF4E47DD)),
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  "Rejoignez-nous pour profiter de nos pronostics et conseils sportifs\net optimisez vos chances de gagner vos paris sportifs.",
                                  style: TextStyle(
                                    color: Color(0xFF6D727F),
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(height: 36),
                                Row(
                                  children: [
                                    Container(
                                      width: 180,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF4E47DD),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Nous rejoindre',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Container(
                                      width: 180,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFE1E7FD),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'En savoir plus',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFF4139C3),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 44),
                              ],
                            ),
                          ),
                          const SizedBox(width: 32),
                          Expanded(
                            child: Container(
                              width: 480,
                              color: Color(0xFF4139C3).withOpacity(0.25),
                              child: Center(
                                child: FlutterLogo(
                                  size: 200,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 56),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Notre offre"),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Nos experts analysent les matchs des sports les plus populaires et vous proposent de les jouer sur le site du bookmaker de votre choix. Nous suivons la plupart des grands évènements sportifs, et répondons à la demande si besoin. Nous pronostiquons des paris SAFE qui ont une fiabilité élevée, ainsi que des paris FUN pour vibrer sur de belles cotes. À vous de décider quoi suivre comme pronostic.",
                    style: TextStyle(
                      color: Color(0xFF6D727F),
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Sport('Football'),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Sport('Tennis'),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Sport('Basketball'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Et bien plus encore...',
                    style: TextStyle(
                      color: Color(0xFF6D727F),
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 400,
                  child: PageView(
                    controller: PageController(
                      viewportFraction: 0.2,
                    ),
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Sport('Foot'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Sport('Tennis'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Sport('Basket'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 88),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Sport extends StatelessWidget {
  final String name;

  const Sport(this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: Color(0xFFEDEEF0),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              color: Colors.blueGrey.withOpacity(0.25),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: Text(
                name,
                style: TextStyle(fontSize: 28),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
