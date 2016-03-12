//ここで背景とか音符とか文字の判定とかまとめたつもり。(実力不足で全く持ってまとまってない。)

class Summary_e {
//背景用
  int c_flag;
  float r, g, b;
  int count;
  int [] lope = new int [120];
  int l_num;
  int go;
  int R;
  
  PFont moji;
  PImage ton;//ト音記号
  int num;//押されてる数

  Summary_e() {
  //背景
    r=255;//最初は真っ白
    g=255;
    b=255;
    R=630;//背景の模様の円の直径
    
    moji = createFont("MS-Gothic-48.vlw", 42);
    ton=loadImage("toooo.png");
    textFont(moji, 50);
    textAlign(CENTER);
    I_letter.init_letter();//文字代入
  }

  void d() {
    bg();//背景
    image(ton, 15, 157, 100, 216);
    for (int i=0; i<5; i++) {
      strokeWeight(2);
      stroke(0);
      line(15, 200+30*i, width-15, 200+30*i);//五線譜
    }  
    fill(0);
    textSize(50);
    text("「　　　　」", width/2, 50);//常時表示の上のカギかっこ
    for (int i=0; i<10; i++) {
      for (int j=0; j<3; j++) {
        if (Key.onp[i][j]==1) {
          num++;//押されてる数のカウント
        }
      }
    }

    if (num==1) {//1このとき
      for (int i=0; i<10; i++) {
        for (int j=0; j<3; j++) {
          if (Key.onp[i][j]==1) {
            le(num, i, j, 0);//日本語の表示
            if (i<=5) {//上向き↑
              sb_u(200, i, j);
            } else {//下向き↓
              sb_d(200, i, j);
            }
          }
        }
      }
    } else if (num==2) {//2このとき
      if (Key.onp[0][1]==1) {//あ行のとき
        for (int i=0; i<10; i++) {//もう一つの文字を探すためのfor文
          for (int j=0; j<3; j++) {        
            if (Key.onp[i][j]==1) {
              if (i!=0 || j!=1) {//A
                if (i!=7 || j!=0) {//I
                  if (i!=6 || j!=0) {//U
                    if (i!=2 || j!=0) {//E
                      if (i!=8 || j!=0) {//Oじゃないことの確認
                        le(num, i, j, 0); //日本語の表示 
                        //ここからのif文は音符の並びの整理のためのもの
                        if(i==0){//同じ音なら母音側の数字を右にする
                          sb_d(200, i, j);//A以外のもう一つ
                          sb_u(200, 0, 1);//A
                          }else if (i==1) {//1の場合は重ならないように横にずらす
                          sb_u(180, i, j);//A以外のもう一つ
                          sb_d(220, 0, 1);//A
                        } else {//それ以外は全部重ねる
                          sb_u(200, i, j);//A以外のもう一つ
                          sb_d(200, 0, 1);//A
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      } else if (Key.onp[7][0]==1) {//い行のとき
        for (int i=0; i<10; i++) {//もう一つの文字を探すためのfor文
          for (int j=0; j<3; j++) {        
            if (Key.onp[i][j]==1) {
              if (i!=0 || j!=1) {//A
                if (i!=7 || j!=0) {//I
                  if (i!=6 || j!=0) {//U
                    if (i!=2 || j!=0) {//E
                      if (i!=8 || j!=0) {//Oじゃないことの確認
                        le(num, i, j, 1);//日本語の表示
                         //ここのif文は音符の並びの整理のためのもの
                         //主に隣はずらす。同じときは左側に母音。線も何にもないなら重ねる。のルール。
                        if (i==6) {//重ならならないようにずらす
                          sb_u(180-2, i, j);//I以外のもう一つ
                          sb_d(220+2, 7, 0);//I
                        } else if (i==7) {//同じだから母音を右にする
                          sb_d(200, 7, j);//I以外のもう一つ
                          sb_u(200, 7, 0);//I
                        } else if (i==8) {//重ならないようにずらす
                          sb_u(180, i, j);//I以外のもう一つ
                          sb_d(220, 7, 0);//I
                        } else if (i==9) {//線も何にもないから重ねる
                          sb_u(200, i, j);//I以外のもう一つ
                          sb_d(200, 7, 0);//I
                        } else {//棒があるから距離感を保たせるためにずらす
                          sb_u(180-4, i, j);//I以外のもう一つ
                          sb_d(220+4, 7, 0);//I
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      } else if (Key.onp[6][0]==1) {//う行のとき
        for (int i=0; i<10; i++) {//もう一つの文字を探すためのfor文
          for (int j=0; j<3; j++) {        
            if (Key.onp[i][j]==1) {
              if (i!=0 || j!=1) {//A
                if (i!=7 || j!=0) {//I
                  if (i!=6 || j!=0) {//U
                    if (i!=2 || j!=0) {//E
                      if (i!=8 || j!=0) {//Oじゃないことの確認
                        le(num, i, j, 2);//日本語の表示
                        //ここのif文は音符の並びの整理のためのもの
                         //主に隣はずらす。同じときは左側に母音。線も何にもないなら重ねる。のルール。
                        if (i==5) {//重ならならないようにずらす
                          sb_u(180-2, i, j);//U以外のもう一つ
                          sb_d(220+2, 6, 0);//U
                        } else if (i==6) {//同じだから母音を右にする
                          sb_d(200, i, j);//U以外のもう一つ
                          sb_u(200, 6, 0);//U
                        } else if (i==7) {//重ならないようにずらす
                          sb_u(180, i, j);//U以外のもう一つ
                          sb_d(220, 6, 0);//U
                        } else if (i==8 || i==9) {//線も何にもないから重ねる
                          sb_u(200, i, j);//U以外のもう一つ                        
                          sb_d(200, 6, 0);//U
                        } else {//棒があるから距離感を保たせるためにずらす
                          sb_u(180-4, i, j);//U以外のもう一つ
                          sb_d(220+4, 6, 0);//U
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      } else if (Key.onp[2][0]==1) {//え行のとき
        for (int i=0; i<10; i++) {//もう一つの文字を探すためのfor文
          for (int j=0; j<3; j++) {        
            if (Key.onp[i][j]==1) {
              if (i!=0 || j!=1) {//A
                if (i!=7 || j!=0) {//I
                  if (i!=6 || j!=0) {//U
                    if (i!=2 || j!=0) {//E
                      if (i!=8 || j!=0) {//Oじゃないことの確認
                        le(num, i, j, 3);//日本語の表示
                        //ここのif文は音符の並びの整理のためのもの
                         //主に隣はずらす。同じときは左側に母音。線も何にもないなら重ねる。のルール。
                        if (i==0) {//線も何にもないから重ねる
                          sb_d(200, i, j);//E以外のもう一つ
                          sb_u(200, 2, 0);//E
                        } else if (i==1) {//重ならならないようにずらす
                          sb_d(180-2, i, j);//E以外のもう一つ
                          sb_u(220+2, 2, 0);//E
                        } else if (i==2) {//同じだから母音を右にする
                          sb_d(200, i, j);//E以外のもう一つ
                          sb_u(200, 2, 0);//E
                        } else if (i==3) {//重ならならないようにずらす
                          sb_d(180, i, j);//E以外のもう一つ
                          sb_u(220, 2, 0);//E
                        } else {//線も何にもないから重ねる
                          sb_d(200-2, i, j);//E以外のもう一つ
                          sb_u(200+2, 2, 0);//E
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      } else if (Key.onp[8][0]==1) {//お行のとき
        for (int i=0; i<10; i++) {//もう一つの文字を探すためのfor文
          for (int j=0; j<3; j++) {        
            if (Key.onp[i][j]==1) {
              if (i!=0 || j!=1) {//A
                if (i!=7 || j!=0) {//I
                  if (i!=6 || j!=0) {//U
                    if (i!=2 || j!=0) {//E
                      if (i!=8 || j!=0) {//Oじゃないことの確認
                        le(num, i, j, 4);//日本語の表示
                        //ここのif文は音符の並びの整理のためのもの
                         //主に隣はずらす。同じときは左側に母音。線も何にもないなら重ねる。のルール。
                        if (i==7) {//重ならならないようにずらす
                          sb_u(180-2, i, j);//O以外のもう一つ
                          sb_d(220+2, 8, 0);//O
                        } else if (i==8) {//同じだから母音を右にする
                          sb_d(200, i, j);//O以外のもう一つ
                          sb_u(200, 8, 0);//O
                        } else if (i==9) {//重ならならないようにずらす
                          sb_u(180, i, j);//O以外のもう一つ
                          sb_d(220, 8, 0);//O
                        } else {//棒があるから距離感を保たせるためにずらす
                          sb_u(180-4, i, j);//O以外のもう一つ
                          sb_d(220+4, 8, 0);//O
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    } else if (num==3) {//3このとき
    //3個のその他の何個か
      if (Key.onp[1][2]==1 && Key.onp[1][0]==1 && Key.onp[0][1]==1) {//XWAのとき
        textSize(50);
        text("ゎ", width/2, 50);
        sb_u(160-4, 1, 2);//X
        sb_d(200, 1, 0);//W
        sb_u(240, 0, 1);//A
      }else if (Key.onp[1][2]==1 && Key.onp[7][1]==1 && Key.onp[0][1]==1) {//XKAのとき
        textSize(50);
        text("ヵ", width/2, 50);
        sb_u(160-8, 1, 2);//X
        sb_d(200, 7, 1);//K
        sb_u(240, 0, 1);//A
      }else if (Key.onp[1][2]==1 && Key.onp[4][0]==1 && Key.onp[6][0]==1) {//XTUのとき
        textSize(50);
        text("っ", width/2, 50);
        sb_u(160-8, 1, 2);//X      
        sb_d(200, 4, 0);//T 
        sb_d(240+4, 6, 0);//U
      }else if (Key.onp[1][2]==1 && Key.onp[7][1]==1 && Key.onp[2][0]==1) {//XKEのとき
        textSize(50);
        text("ヶ", width/2, 50);
        sb_u(160-8, 1, 2);//X
        sb_d(200, 7, 1);//K
        sb_u(240, 2, 0);//E
      }else if (Key.onp[1][1]==1 && Key.onp[5][1]==1 && Key.onp[7][0]==1) {//SHIのとき
        textSize(50);
        text("し", width/2, 50);
        sb_u(160-8, 1, 1);//S
        sb_d(200, 5, 1);//H
        sb_d(240+4, 7, 0);//I
      } else if (Key.onp[2][2]==1 && Key.onp[5][1]==1 && Key.onp[7][0]==1) {//CHIのとき
        textSize(50);
        text("ち", width/2, 50);
        sb_u(160-8, 2, 2);//C
        sb_d(200, 5, 1);//H
        sb_d(240+4, 7, 0);//I
      } else if (Key.onp[4][0]==1 && Key.onp[1][1]==1 && Key.onp[6][0]==1) {//TSUのとき
        textSize(50);
        text("つ", width/2, 50);
        sb_d(160-4, 4, 0);//T
        sb_u(200, 1, 1);//S
        sb_d(240+8, 6, 0);//U
      } else if (Key.onp[2][2]==1 && Key.onp[5][1]==1 && Key.onp[0][1]==1) {//CHAのとき
        textSize(50);
        text("ちゃ", width/2, 50);
        sb_u(160-8, 2, 2);//C
        sb_d(200, 5, 1);//H
        sb_u(240, 0, 1);//A
      } else if (Key.onp[1][1]==1 && Key.onp[5][1]==1 && Key.onp[0][1]==1) {//SHAのとき
        textSize(50);
        text("しゃ", width/2, 50);
        sb_u(160-8, 1, 1);//S
        sb_d(200, 5, 1);//H
        sb_u(240, 0, 1);//A
      } else if (Key.onp[2][2]==1 && Key.onp[5][1]==1 && Key.onp[6][0]==1) {//CHUのとき
        textSize(50);
        text("ちゅ", width/2, 50);
        sb_u(160-8, 2, 2);//C
        sb_d(200, 5, 1);//H
        sb_u(240+4, 6, 0);//U
      } else if (Key.onp[1][1]==1 && Key.onp[5][1]==1 && Key.onp[6][0]==1) {//SHUのとき
        textSize(50);
        text("しゅ", width/2, 50);
        sb_u(160-8, 1, 1);//S
        sb_d(200, 5, 1);//H
        sb_u(240+4, 6, 0);//U
      } else if (Key.onp[2][2]==1 && Key.onp[5][1]==1 && Key.onp[8][0]==1) {//CHOのとき
        textSize(50);
        text("ちょ", width/2, 50);
        sb_u(160-8, 2, 2);//C
        sb_d(200, 5, 1);//H
        sb_d(240+4, 8, 0);//O
      } else if (Key.onp[1][1]==1 && Key.onp[5][1]==1 && Key.onp[8][0]==1) {//SHOのとき
        textSize(50);
        text("しょ", width/2, 50);
        sb_u(160-8, 1, 1);//S
        sb_d(200, 5, 1);//H
        sb_d(240+4, 8, 0);//O
      } else if (Key.onp[5][0]==1 && Key.onp[0][1]==1) {//YAのとき
        for (int i=0; i<10; i++) {//残り一つの文字を探すためのfor文
          for (int j=0; j<3; j++) {        
            if (Key.onp[i][j]==1) {
              if (i!=1 || j!=0) {//W
                if (i!=5 || j!=0) {//Y
                  if (i!=0 || j!=1) {//A
                    if (i!=7 || j!=0) {//I
                      if (i!=6 || j!=0) {//U
                        if (i!=2 || j!=0) {//E
                          if (i!=8 || j!=0) {//Oじゃないことの確認
                            le(num, i, j, 0);//日本語の表示
                            //ここのif文は音符の並びの整理のためのもの
                            //2つの時とルールは基本的に同じ。主に左をころころ変えてる。
                            if (i<=3) {//Yよりも下              
                              sb_u(160-8, i, j);//YA以外のもう一つ
                              sb_d(200, 5, 0);//Y
                            } else if (i==4 || i==5) {//隣り合わせと同じとき
                              sb_u(160-4, i, j);//YA以外のもう一つ
                              sb_d(200, 5, 0);//Y
                            } else {//主にYよりも上
                              sb_d(160, i, j);//YA以外のもう一つ
                              sb_u(200, 5, 0);//Y
                            }                                       
                            sb_u(240, 0, 1);//A
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }  else if (Key.onp[5][0]==1 && Key.onp[7][0]==1) {//YIのとき
        for (int i=0; i<10; i++) {//残り一つの文字を探すためのfor文
          for (int j=0; j<3; j++) {        
            if (Key.onp[i][j]==1) {
              if (i!=1 || j!=0) {//W
                if (i!=5 || j!=0) {//Y
                  if (i!=0 || j!=1) {//A
                    if (i!=7 || j!=0) {//I
                      if (i!=6 || j!=0) {//U
                        if (i!=2 || j!=0) {//E
                          if (i!=8 || j!=0) {//Oじゃないことの確認
                            le(num, i, j, 1);//日本語の表示
                            //ここのif文は音符の並びの整理のためのもの
                            //2つの時とルールは基本的に同じ。主に左をころころ変えてる。
                            if (i<=2) {//Yよりも下                  
                              sb_u(160-8, i, j);//YI以外のもう一つ
                            } else if (i==4 || i==5) {//隣り合わせと同じとき
                              sb_d(160-8, i, j);//YI以外のもう一つ
                            } else {//主にYよりも上
                              sb_d(160, i, j);//YI以外のもう一つ
                            }
                            sb_u(200, 5, 0);//Y
                            sb_d(240+8, 6, 0);//I
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }else if (Key.onp[5][0]==1 && Key.onp[6][0]==1) {//YUのとき
        for (int i=0; i<10; i++) {//残り一つの文字を探すためのfor文
          for (int j=0; j<3; j++) {        
            if (Key.onp[i][j]==1) {
              if (i!=1 || j!=0) {//W
                if (i!=5 || j!=0) {//Y
                  if (i!=0 || j!=1) {//A
                    if (i!=7 || j!=0) {//I
                      if (i!=6 || j!=0) {//U
                        if (i!=2 || j!=0) {//E
                          if (i!=8 || j!=0) {//Oじゃないことの確認
                            le(num, i, j, 2);//日本語の表示
                            //ここのif文は音符の並びの整理のためのもの
                            //2つの時とルールは基本的に同じ。主に左をころころ変えてる。
                            if (i<=2) {//Yよりも下                
                              sb_u(160-8, i, j);//YU以外のもう一つ
                            } else if (i==4 || i==5) {//隣り合わせと同じとき
                              sb_d(160-8, i, j);//YU以外のもう一つ
                            } else {//主にYよりも上
                              sb_d(160, i, j);//YU以外のもう一つ
                            }
                            sb_u(200, 5, 0);//Y
                            sb_d(240+8, 6, 0);//U
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      } else if (Key.onp[5][0]==1 && Key.onp[2][0]==1) {//YEのとき
        for (int i=0; i<10; i++) {//残り一つの文字を探すためのfor文
          for (int j=0; j<3; j++) {        
            if (Key.onp[i][j]==1) {
              if (i!=1 || j!=0) {//W
                if (i!=5 || j!=0) {//Y
                  if (i!=0 || j!=1) {//A
                    if (i!=7 || j!=0) {//I
                      if (i!=6 || j!=0) {//U
                        if (i!=2 || j!=0) {//E
                          if (i!=8 || j!=0) {//Oじゃないことの確認
                            le(num, i, j, 3);//日本語の表示
                            //ここのif文は音符の並びの整理のためのもの
                            //2つの時とルールは基本的に同じ。主に左をころころ変えてる。
                            if (i<=3) {//Yよりも下            
                              sb_u(160-8, i, j);//YE以外のもう一つ
                              sb_d(200, 5, 0);//Y
                            } else if (i==4 || i==5) {//隣り合わせと同じとき
                              sb_u(160-4, i, j);//YE以外のもう一つ
                              sb_d(200, 5, 0);//Y
                            } else {//主にYよりも上
                              sb_d(160, i, j);//YE以外のもう一つ
                              sb_u(200, 5, 0);//Y
                            }                                       
                            sb_u(240, 2, 0);//E
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      } else if (Key.onp[5][0]==1 && Key.onp[8][0]==1) {//YOのとき
        for (int i=0; i<10; i++) {//残り一つの文字を探すためのfor文
          for (int j=0; j<3; j++) {        
            if (Key.onp[i][j]==1) {
              if (i!=1 || j!=0) {//W
                if (i!=5 || j!=0) {//Y
                  if (i!=0 || j!=1) {//A
                    if (i!=7 || j!=0) {//I
                      if (i!=6 || j!=0) {//U
                        if (i!=2 || j!=0) {//E
                          if (i!=8 || j!=0) {//Oじゃないことの確認
                            le(num, i, j, 4);//日本語の表示
                            //ここのif文は音符の並びの整理のためのもの
                            //2つの時とルールは基本的に同じ。主に左をころころ変えてる。
                            if (i<=2) {//Yよりも下                 
                              sb_u(160-8, i, j);//YO以外のもう一つ
                            } else if (i==4 || i==5) {//隣り合わせと同じとき
                              sb_d(160-8, i, j);//YO以外のもう一つ
                            } else {//主にYよりも上
                              sb_d(160, i, j);//YO以外のもう一つ
                            }
                            sb_u(200, 5, 0);//Y
                            sb_d(240+8, 8, 0);//O
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    num=0;//押されてる個数のリセット
  }

  void bg() {//背景
    background(r, g, b);
    fill(255);
    noStroke();
    ellipse(width+110, 450, R, R);//ほぼ常時ある円
    for (int i=0; i<lope.length; i++) {
      if (lope[i]>0) {
        for (int j=0; j<8; j++) {//ここ重くていらいらしたら1にする
          if (lope[i]+j>R) {//輪っかが円よりも大きいとき
            stroke(255);//輪っかの色は白
          } else if (lope[i]+j<=R) {//輪っかが円よりも小さいとき
            stroke(r, g, b);//輪っかの色は背景と一緒
          }
          strokeWeight(3);
          noFill();
          ellipse(width+110, 450, lope[i]+j, lope[i]+j);//輪っか
        }
      }
    }

    for (int i=0; i<lope.length; i++) {
      if (lope[i]>0) {
        if (lope[i]<0) {//直径がマイナスになったら「0」にリセット
          lope[i]=0;
        } else {//それ以外は小さくしていく
          lope[i]--;
        }
        if (lope[i]==R) {//輪っかと円がすれ違った場所が
          if (R>=630) {//630よりも大きかった場合
            go=1;
          } else if (R<630) {//630よりも小さかった場合
            go=2;
          }
        }
      }
    }
    if (go==0) {//何にも反応がないとき定位置
      R=630;
    } else if (go==1) {//はみ出すまで大きくする
      R++;
      if (R>1215) {//はみ出したら「0」にリセット
        R=0;
        go=2;
      }
    } else if (go==2) {//630まで大きくなる
      if (R>=630) {      
        R=630;
        go=0;
      } else {
        R++;
      }
    }
    
//色のグラデーション「色を濃く→薄く→白→色を濃く…」のくりかえし
    if (c_flag%8==0) {
      if (r<=226 && g<=244 && b<=132) {//黄緑
        count++;
        if (count>200) {
          c_flag++;
          count=0;
        }
      } else {
        r-=2.63/12;
        g-=1.0/12;
        b-=11.18/12;
      }
    } else if (c_flag%8==1) {    
      if (r==255 && g==255 && b==255) {//白
        c_flag++;
      } else {
        r+=2.63/12;
        g+=1.0/12;
        b+=11.18/12;
      }
    } else if (c_flag%8==2) {
      if (r<=249 && g<=127 && b<=172) {//ピンク
        count++;
        if (count>200) {
          c_flag++;
          count=0;
        }
      } else {
        r-=1.0/22;
        g-=21.33/22;
        b-=13.83/22;
      }
    } else if (c_flag%8==3) {
      if (r==255 && g==255 && b==255) {//白
        c_flag++;
      } else {
        r+=1.0/22;
        g+=21.33/22;
        b+=13.83/22;
      }
    } else if (c_flag%8==4) {
      if (r<=129 && g<=219 && b<=249) {//水色
        count++;
        if (count>200) {
          c_flag++;
          count=0;
        }
      } else {
        r-=21.0/22;
        g-=6.0/22;
        b-=1.0/22;
      }
    } else if (c_flag%8==5) {
      if (r==255 && g==255 && b==255) {//白
        c_flag++;
      } else {
        r+=21.0/22;
        g+=6.0/22;
        b+=1.0/22;
      }
    } else if (c_flag%8==6) {
      if (r<=249 && g<=192 && b<=127) {//オレンジ
        count++;
        if (count>200) {
          c_flag++;
          count=0;
        }
      } else {
        r-=1.0/50;
        g-=10.5/50;
        b-=21.33/50;
      }
    } else if (c_flag%8==7) {
      if (r==255 && g==255 && b==255) {//白
        c_flag++;
      } else {
        r+=1.0/50;
        g+=10.5/50;
        b+=21.33/50;
      }
    }
  }

  void k() {//輪っか発射
    lope[l_num]=1215;
    if (l_num<lope.length-1) {
      l_num++;
    } else {
      l_num=0;
    }
  }

  void sb_u(int x, int i, int j) {//上向きの四分音符
    pushMatrix();
    translate(x, 350-15*i);
    rotate(radians(-15));
    fill(0);
    ellipse(0, 0, 45, 30);
    popMatrix();
    line(x+20, 350-15*i, x+20, 350-15*(i+8));
    if (i==0) {
      line(x-30, 350, x+30, 350);//ドのときの横棒
    }
    //上に表示する数字
    textSize(30);
       if (i<=3) {
      text(j+1, x+20, 350-15*(3+8)-10);//最低位置
    } else {//そのほかは
      text(j+1, x+20, 350-15*(i+8)-10);//iの値に合わせる
    }
  }

  void sb_d(int x, int i, int j) {//下向きの四分音符
    pushMatrix();
    translate(x, 350-15*i);
    rotate(radians(-15));
    fill(0);
    ellipse(0, 0, 45, 30);
    popMatrix();
    line(x-20, 350-15*i, x-20, 350-15*(i-8));
    if (i==0) {
      line(x-30, 350, x+30, 350);//ドのときの横棒
    }
    //上に表示する数字
    textSize(30);
    if (i>=6) {    
      text(j+1, x-20, 350-15*(6-8)+30);//最高位置
    } else {//そのほかは
      text(j+1, x-20, 350-15*(i-8)+30);//iの値に合わせる
    }
  }

  void le(int n, int i, int j, int b) {//日本語表示の関数
    textSize(50);
    if (n==1) {
      text(I_letter.num1s[i*3+j], width/2, 50);
    } else if (n==2) {
      text(I_letter.num2s[i*3+j][b], width/2, 50);
    } else if (n==3) {
      text(I_letter.num3s[i*3+j][b], width/2, 50);
    }
  }
}

