import 'package:flutter/material.dart';

class TicTacToe extends StatefulWidget {
  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<String> board = List.filled(9, ''); // 3x3 = 9 cells
  bool xTurn = true; // X starts first

  void handleTap(int index) {
    if (board[index] == '') {
      setState(() {
        board[index] = xTurn ? 'X' : 'O';
        xTurn = !xTurn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Tic Tac Toe', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => handleTap(index),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: Color.fromARGB(255, 42, 42, 42),
                      borderRadius: BorderRadius.all(Radius.elliptical(15, 15)),
                    ),
                    child: Center(
                      child: Text(
                        board[index],
                        style: TextStyle(fontSize: 48, color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(padding: EdgeInsets.all(20)),
          FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                board = List.filled(9, '');
                xTurn = true;
              });
            },
            label: Text("Reset"),
            icon: Icon(Icons.restore),
          ),
        ],
      ),
    );
  }
}
