import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 71, 154, 149)),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'ケルちゃん'),
    );
  }
}

// 【外枠】ガワの積み木
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// 【中身】頭脳の積み木
class _MyHomePageState extends State<MyHomePage> {
  // 【チェックポイント】こんな感じで登録してあげましょう
  String displayEx = '';
  String equation = '';
  double firstNum = 0;    // 1番目の数字を入れる「数値用」の箱
  String operator = '';   // 記号を覚えておく「文字用」の箱

  @override
  Widget build(BuildContext context) {
    List<String> buttons = [
      'AC','+/-','%','÷',
      '7','8','9','×',
      '4','5','6','-',
      '1','2','3','+',
      ' ','0','.','=',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Column(
                children:<Widget>[
                  Text(
                    equation,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    // ★ここを '0' ではなく displayEx に！
                    displayEx,
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                ]
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: buttons.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: (buttons[index] == '÷' || buttons[index] == '×' || buttons[index] == '-' || buttons[index] == '+' || buttons[index] == '+/-' ||  buttons[index] == '%')
                          ? const Color.fromARGB(255, 84, 148, 148)
                          : (buttons[index] == 'AC' || buttons[index] == '=')
                          ? const Color.fromARGB(255, 82, 119, 138)
                          : const Color.fromARGB(255, 77, 77, 77),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        if (buttons[index] == 'AC') {
                          equation = '';
                          displayEx = '';
                        } else if (buttons[index] == '+'){
                              // String（文字）を double（数値）に変換して倉庫に入れる魔法
                              if (displayEx.isNotEmpty) {
                                firstNum = double.parse(displayEx); 
                                operator = '+';
                                displayEx = ''; // 次の数字のために画面をクリア
                                equation += '+';
                              }
                          } else if (buttons[index] == '-'){
                              if (displayEx.isNotEmpty) {
                                 firstNum = double.parse(displayEx); 
                                 operator = '-';
                                 displayEx = ''; // 次の数字のために画面をクリア
                                 quation += '-';
                              }
                            } else if (buttons[index] == '×'){
                                if (displayEx.isNotEmpty) {
                                  firstNum = double.parse(displayEx); 
                                  operator = '×';
                                  displayEx = ''; // 次の数字のために画面をクリア
                                  equation += '×';
                                }
                              } else if (buttons[index] == '÷'){
                                  if (displayEx.isNotEmpty) {
                                    firstNum = double.parse(displayEx); 
                                    operator = '÷';
                                    displayEx = ''; // 次の数字のために画面をクリア
                                    equation += '÷';
                                  }
                                }else if (buttons[index] == '='){  
                             // 1. 今画面にある数字も数値に変えて、2番目の数字（secondNum）として扱う
                              if (displayEx.isNotEmpty) {
                                double secondNum = double.parse(displayEx);
                                equation += '=';
                                // 2. 付箋（operator）の中身を見て、計算する
                                if (operator == '+') {
                                  // 倉庫の数字 ＋ 今の数字 を計算して、画面（displayEx）に書き込む！
                                  // 数値を文字に戻す .toString() を忘れずに！
                                  displayEx = (firstNum + secondNum).toString();
                                }
                                if (operator == '-'){
                                  displayEx = (firstNum - secondNum).toString();
                                }
                                if (operator == '×'){
                                  displayEx = (firstNum * secondNum).toString();
                                }
                                if (operator == '÷'){
                                  displayEx = (firstNum / secondNum).toString();
                                }
                                // 3. 使い終わった付箋をきれいにする
                                operator = '';
                              }
                              
                            }  else{
                            if (displayEx == '0'){
                              displayEx = buttons[index];
                              equation = buttons[index];
                            } else{
                              displayEx += buttons[index];
                              equation += buttons[index];
                            }
      // displayEx = displayEx + buttons[index]; みたいなイメージ！
                            }
                          
                      },
                  
                );
              },
              child: Text(buttons[index]),
            ),
          );
              },
        
      )
    )
        ],
      ),
    );
  }
}