import 'dart:async';

import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  List<String> containerValues = ['', '', '', '', '', '', '', '', ''];
  bool isPlayer1Turn = true;
  bool isGameOver = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back'),
      ),
      body: Container(
        color: const Color.fromRGBO(0, 37, 166, 1),
        child: Column(
          children: [
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Left container
                buildContainer(0),
                // Middle container
                buildContainer(1),
                // Right container
                buildContainer(2),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Left container
                buildContainer(3),
                // Middle container
                buildContainer(4),
                // Right container
                buildContainer(5),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Left container
                buildContainer(6),
                // Middle container
                buildContainer(7),
                // Right container
                buildContainer(8),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContainer(int index) {
    return GestureDetector(
      onTap: () {
        if (!isGameOver && containerValues[index] == '') {
          setState(() {
            if (isPlayer1Turn) {
              containerValues[index] = 'X';
            } else {
              containerValues[index] = 'O';
            }
            isPlayer1Turn = !isPlayer1Turn;
            checkGameOver();
          });
        }
      },


      
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            containerValues[index],
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
            ),
          ),
        ),
      ),
    );
  }

  void checkGameOver() {
    // Define winning combinations
    List<List<int>> winCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    // Check for winning combinations
    for (var combination in winCombinations) {
      if (containerValues[combination[0]] == containerValues[combination[1]] &&
          containerValues[combination[1]] == containerValues[combination[2]] &&
          containerValues[combination[0]] != '') {
        // A player has won
        setState(() {
          isGameOver = true;
        });
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Game Over'),
              content: Text(
                '${containerValues[combination[0]]} has won!',
              ),
              actions: [
                TextButton(
                  child: Text('Play Again'),
                  onPressed: () {
                    resetGame();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        return;
      }
    }

    // Check for a draw
    if (!containerValues.contains('')) {
      setState(() {
        isGameOver = true;
      });
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Game Over'),
            content: Text('It\'s a draw!'),
            actions: [
              TextButton(
                child: Text('Play Again'),
                onPressed: () {
                  resetGame();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void resetGame() {
    setState(() {
      containerValues = ['', '', '', '', '', '', '', '', ''];
      isPlayer1Turn = true;
      isGameOver = false;
    });
  }
}
