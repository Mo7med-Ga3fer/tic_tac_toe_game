import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  int scoreX = 0;
  int scoreO = 0;
  int filledBoxes = 0;
  bool turnOfO = true;

  List<String> xOrOList = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    ''
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[900],
        title: const Text('TIC TAC TOE', style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
        ),),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                reload();
                scoreO = 0;
                scoreX = 0;
                turnOfO = true;
              });
            },
            icon: const Icon(Icons.replay_rounded, size: 32,),
            ),
        ],
      ),
    body: Column(
      children: [
        const SizedBox(height: 30,),
        Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Player O', style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),),
                Text('Player X', style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.white
                ),),
              ],
            ),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(scoreO.toString(), style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.white
                ),),
                Text(scoreX.toString(), style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.white
                ),),
              ],
            )
          ],
        ),
        const SizedBox(height: 25,),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3
              ),
            itemCount: xOrOList.length,
            itemBuilder: (context, index){
              return GestureDetector(
                onTap: (){
                  setState(() {
                    tapped(index);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromRGBO(97, 97, 97, 1), width: 2)
                  ),
                  child: Center(
                    child: Text(xOrOList[index], style: const TextStyle(
                      fontSize: 85,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    ),),
                  ),
                ),
              );
            }
            ),
          ),
        Text(turnOfO ? 'Turn of O' : 'Turn of X', style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: Colors.white
        ),),
        const SizedBox(height: 30,),
      ],
    ),
    );
  }

  void tapped(int index){
    if(turnOfO && xOrOList[index] == ''){
      xOrOList[index] = 'O';
      filledBoxes += 1;
    }
    else if(!turnOfO && xOrOList[index] == ''){
      xOrOList[index] = 'X';
      filledBoxes += 1;
    }

    turnOfO = !turnOfO;
    checkWinner();
  }
  void reload(){
    for(int i = 0; i < 9; i++){
      xOrOList[i] = '';
    }
    filledBoxes = 0;
  }
  void checkWinner(){

       // check first row
    if (xOrOList[0] == xOrOList[1] &&
        xOrOList[0] == xOrOList[2] &&
        xOrOList[0] != '') {
      showResualtDialog('Winner', xOrOList[0]);
      //return;
    }

    // check second row
    if (xOrOList[3] == xOrOList[4] &&
        xOrOList[3] == xOrOList[5] &&
        xOrOList[3] != '') {
      showResualtDialog('Winner', xOrOList[3]);
    }

    // check third row
    if (xOrOList[6] == xOrOList[7] &&
        xOrOList[6] == xOrOList[8] &&
        xOrOList[6] != '') {
      showResualtDialog('Winner', xOrOList[6]);
    }

    // check first column
    if (xOrOList[0] == xOrOList[3] &&
        xOrOList[0] == xOrOList[6] &&
        xOrOList[0] != '') {
      showResualtDialog('Winner', xOrOList[0]);
    }

    // check second column
    if (xOrOList[1] == xOrOList[4] &&
        xOrOList[1] == xOrOList[7] &&
        xOrOList[1] != '') {
      showResualtDialog('Winner', xOrOList[1]);
    }

    // check third column
    if (xOrOList[2] == xOrOList[5] &&
        xOrOList[2] == xOrOList[8] &&
        xOrOList[2] != '') {
      showResualtDialog('Winner', xOrOList[2]);
    }

    // check diagonal
    if (xOrOList[0] == xOrOList[4] &&
        xOrOList[0] == xOrOList[8] &&
        xOrOList[0] != '') {
      showResualtDialog('Winner', xOrOList[0]);
    }

    // check diagonal
    if (xOrOList[2] == xOrOList[4] &&
        xOrOList[2] == xOrOList[6] &&
        xOrOList[2] != '') {
      showResualtDialog('Winner', xOrOList[2]);
    }

    if (filledBoxes == 9) {
      showResualtDialog('Draw', 'Play again');
    }
  }


  void showResualtDialog(String title, String winner){

  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
      title: Text(title),
      content: winner == '' ? Text('The match ended in a draw') : Text('The winner is ${winner.toUpperCase()}'),
      actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    reload();
                  });
                  Navigator.of(context).pop();
                  
                },
                child: Text('OK', style: TextStyle(color: Colors.black),),
              ),]
      );
    }
    );

    if (winner == 'O') {
      scoreO += 1;
    } else if (winner == 'X') {
      scoreX += 1;
    }
  }


}



