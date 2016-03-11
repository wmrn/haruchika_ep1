class Summary_e {
  int c_flag;
  float r, g, b;
  int count;
  int [] lope = new int [120];
  int l_num;
  int go;
  int R;
  PFont moji;
  PImage ton;
  int num;//押されてる数

  Summary_e() {
    r=255;
    g=255;
    b=255;
    R=630;
    moji = createFont("MS-Gothic-48.vlw", 42);
    ton=loadImage("toooo.png");
    textFont(moji, 50);
    textAlign(CENTER);
    I_letter.init_letter();
  }

  void d() {
    bg();
    image(ton, 15, 157, 100, 216);
    for (int i=0; i<5; i++) {
      strokeWeight(2);
      stroke(0);
      line(15, 200+30*i, width-15, 200+30*i);
    }  
    fill(0);
    textSize(50);
    text("「　　　　」", width/2, 50);
    for (int i=0; i<10; i++) {
      for (int j=0; j<3; j++) {
        if (Key.onp[i][j]==1) {
          num++;
        }
      }
    }

    if (num==1) {//1このとき
      for (int i=0; i<10; i++) {
        for (int j=0; j<3; j++) {
          if (Key.onp[i][j]==1) {
            le(num, i, j, 0);
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
        for (int i=0; i<10; i++) {
          for (int j=0; j<3; j++) {        
            if (Key.onp[i][j]==1) {
              if (i!=0 || j!=1) {//A
                if (i!=7 || j!=0) {//I
                  if (i!=6 || j!=0) {//U
                    if (i!=2 || j!=0) {//E
                      if (i!=8 || j!=0) {//O 
                        le(num, i, j, 0);                              
                        if (i==1) {
                          sb_u(180, i, j);
                          sb_d(220, 0, 1);
                        } else {
                          sb_u(200, i, j);
                          sb_d(200, 0, 1);
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
        for (int i=0; i<10; i++) {
          for (int j=0; j<3; j++) {        
            if (Key.onp[i][j]==1) {
              if (i!=0 || j!=1) {//A
                if (i!=7 || j!=0) {//I
                  if (i!=6 || j!=0) {//U
                    if (i!=2 || j!=0) {//E
                      if (i!=8 || j!=0) {//O
                        le(num, i, j, 1);
                        if (i==6) {
                          sb_u(180-2, i, j);
                          sb_d(220+2, 7, 0);
                        } else if (i==7) {
                          sb_u(200, 7, j);
                          sb_d(200, 7, 0);
                        } else if (i==8) {
                          sb_u(180, i, j);
                          sb_d(220, 7, 0);
                        } else if (i==9) {
                          sb_u(200, i, j);
                          sb_d(200, 7, 0);
                        } else {
                          sb_u(180-4, i, j);
                          sb_d(220+4, 7, 0);
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
        for (int i=0; i<10; i++) {
          for (int j=0; j<3; j++) {        
            if (Key.onp[i][j]==1) {
              if (i!=0 || j!=1) {//A
                if (i!=7 || j!=0) {//I
                  if (i!=6 || j!=0) {//U
                    if (i!=2 || j!=0) {//E
                      if (i!=8 || j!=0) {//O
                        le(num, i, j, 2);
                        if (i==5) {
                          sb_u(180-2, i, j);
                          sb_d(220+2, 6, 0);
                        } else if (i==6) {
                          sb_d(200, i, j);
                          sb_u(200, 6, 0);
                        } else if (i==7) {
                          sb_u(180, i, j);
                          sb_d(220, 6, 0);
                        } else if (i==8 || i==9) {
                          sb_u(200, i, j);                        
                          sb_d(200, 6, 0);
                        } else {
                          sb_u(180-4, i, j);
                          sb_d(220+4, 6, 0);
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
        for (int i=0; i<10; i++) {
          for (int j=0; j<3; j++) {        
            if (Key.onp[i][j]==1) {
              if (i!=0 || j!=1) {//A
                if (i!=7 || j!=0) {//I
                  if (i!=6 || j!=0) {//U
                    if (i!=2 || j!=0) {//E
                      if (i!=8 || j!=0) {//O
                        le(num, i, j, 3);
                        if (i==0) {
                          sb_d(200, i, j);
                          sb_u(200, 2, 0);
                        } else if (i==1) {
                          sb_d(180-2, i, j);
                          sb_u(220+2, 2, 0);
                        } else if (i==2) {
                          sb_d(200, i, j);
                          sb_u(200, 2, 0);
                        } else if (i==3) {
                          sb_d(180, i, j);
                          sb_u(220, 2, 0);
                        } else {
                          sb_d(200-2, i, j);
                          sb_u(200+2, 2, 0);
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
        for (int i=0; i<10; i++) {
          for (int j=0; j<3; j++) {        
            if (Key.onp[i][j]==1) {
              if (i!=0 || j!=1) {//A
                if (i!=7 || j!=0) {//I
                  if (i!=6 || j!=0) {//U
                    if (i!=2 || j!=0) {//E
                      if (i!=8 || j!=0) {//O
                        le(num, i, j, 4);
                        if (i==7) {
                          sb_u(180-2, i, j);
                          sb_d(220+2, 8, 0);
                        } else if (i==8) {
                          sb_d(200, i, j);
                          sb_u(200, 8, 0);
                        } else if (i==9) {
                          sb_u(180, i, j);
                          sb_d(220, 8, 0);
                        } else {
                          sb_u(180-4, i, j);
                          sb_d(220+4, 8, 0);
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
      if (Key.onp[1][2]==1 && Key.onp[1][0]==1 && Key.onp[0][1]==1) {
        textSize(50);
        text("ゎ", width/2, 50);
        sb_u(160-4, 1, 2);
        sb_d(200, 1, 0);
        sb_u(240, 0, 1);
      }else if (Key.onp[1][2]==1 && Key.onp[7][1]==1 && Key.onp[0][1]==1) {
        textSize(50);
        text("ヵ", width/2, 50);
        sb_u(160-8, 1, 2);
        sb_d(200, 7, 1);
        sb_u(240, 0, 1);
      } else if (Key.onp[1][2]==1 && Key.onp[5][0]==1 && Key.onp[7][0]==1) {
        textSize(50);
        text("ぃ", width/2, 50);
        sb_u(160-8, 1, 2);
        sb_d(200, 5, 0);
        sb_d(240+8, 7, 0);
      } else if (Key.onp[1][2]==1 && Key.onp[4][0]==1 && Key.onp[6][0]==1) {//XTUのとき
        textSize(50);
        text("っ", width/2, 50);
        sb_u(160-8, 1, 2);      
        sb_d(200, 4, 0);      
        sb_d(240+4, 6, 0);
      }else if (Key.onp[1][2]==1 && Key.onp[5][0]==1 && Key.onp[2][0]==1) {
        textSize(50);
        text("ぇ", width/2, 50);
        sb_u(160-8, 1, 2);
        sb_d(200, 5, 0);
        sb_u(240, 2, 0);
      } else if (Key.onp[1][2]==1 && Key.onp[7][1]==1 && Key.onp[2][0]==1) {
        textSize(50);
        text("ヶ", width/2, 50);
        sb_u(160-8, 1, 2);
        sb_d(200, 7, 1);
        sb_u(240, 2, 0);
      }else if (Key.onp[1][1]==1 && Key.onp[5][1]==1 && Key.onp[7][0]==1) {//SHIのとき
        textSize(50);
        text("し", width/2, 50);
        sb_u(160-8, 1, 1);
        sb_d(200, 5, 1);
        sb_d(240+4, 7, 0);
      } else if (Key.onp[2][2]==1 && Key.onp[5][1]==1 && Key.onp[7][0]==1) {//CHIのとき
        textSize(50);
        text("ち", width/2, 50);
        sb_u(160-8, 2, 2);
        sb_d(200, 5, 1);
        sb_d(240+4, 7, 0);
      } else if (Key.onp[4][0]==1 && Key.onp[1][1]==1 && Key.onp[6][0]==1) {//TSUのとき
        textSize(50);
        text("つ", width/2, 50);
        sb_d(160-4, 4, 0);
        sb_u(200, 1, 1);
        sb_d(240+8, 6, 0);
      } else if (Key.onp[2][2]==1 && Key.onp[5][1]==1 && Key.onp[0][1]==1) {//CHAのとき
        textSize(50);
        text("ちゃ", width/2, 50);
        sb_u(160-8, 2, 2);
        sb_d(200, 5, 1);
        sb_u(240, 0, 1);
      } else if (Key.onp[1][1]==1 && Key.onp[5][1]==1 && Key.onp[0][1]==1) {//SHAのとき
        textSize(50);
        text("しゃ", width/2, 50);
        sb_u(160-8, 1, 1);
        sb_d(200, 5, 1);
        sb_u(240, 0, 1);
      } else if (Key.onp[2][2]==1 && Key.onp[5][1]==1 && Key.onp[6][0]==1) {//CHUのとき
        textSize(50);
        text("ちゅ", width/2, 50);
        sb_u(160-8, 2, 2);
        sb_d(200, 5, 1);
        sb_u(240+4, 6, 0);
      } else if (Key.onp[1][1]==1 && Key.onp[5][1]==1 && Key.onp[6][0]==1) {//SHUのとき
        textSize(50);
        text("しゅ", width/2, 50);
        sb_u(160-8, 1, 1);
        sb_d(200, 5, 1);
        sb_u(240+4, 6, 0);
      } else if (Key.onp[2][2]==1 && Key.onp[5][1]==1 && Key.onp[8][0]==1) {//CHOのとき
        textSize(50);
        text("ちょ", width/2, 50);
        sb_u(160-8, 2, 2);
        sb_d(200, 5, 1);
        sb_d(240+4, 8, 0);
      } else if (Key.onp[1][1]==1 && Key.onp[5][1]==1 && Key.onp[8][0]==1) {//SHOのとき
        textSize(50);
        text("しょ", width/2, 50);
        sb_u(160-8, 1, 1);
        sb_d(200, 5, 1);
        sb_d(240+4, 8, 0);
      } else if (Key.onp[5][0]==1 && Key.onp[0][1]==1) {//YAのとき
        for (int i=0; i<10; i++) {
          for (int j=0; j<3; j++) {        
            if (Key.onp[i][j]==1) {
              if (i!=1 || j!=0) {//W
                if (i!=5 || j!=0) {//Y
                  if (i!=0 || j!=1) {//A
                    if (i!=7 || j!=0) {//I
                      if (i!=6 || j!=0) {//U
                        if (i!=2 || j!=0) {//E
                          if (i!=8 || j!=0) {//O
                            le(num, i, j, 0);
                            if (i<=3) {                  
                              sb_u(160-8, i, j);
                              sb_d(200, 5, 0);
                            } else if (i==4 || i==5) {
                              sb_u(160-4, i, j);
                              sb_d(200, 5, 0);
                            } else {
                              sb_d(160, i, j);
                              sb_u(200, 5, 0);
                            }                                       
                            sb_u(240, 0, 1);
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
      } else if (Key.onp[5][0]==1 && Key.onp[6][0]==1) {//YUのとき
        for (int i=0; i<10; i++) {
          for (int j=0; j<3; j++) {        
            if (Key.onp[i][j]==1) {
              if (i!=1 || j!=0) {//W
                if (i!=5 || j!=0) {//Y
                  if (i!=0 || j!=1) {//A
                    if (i!=7 || j!=0) {//I
                      if (i!=6 || j!=0) {//U
                        if (i!=2 || j!=0) {//E
                          if (i!=8 || j!=0) {//O
                            le(num, i, j, 1);
                            if (i<=2) {                  
                              sb_u(160-8, i, j);
                            } else if (i==4 || i==5) {
                              sb_d(160-8, i, j);
                            } else {
                              sb_d(160, i, j);
                            }
                            sb_u(200, 5, 0);
                            sb_d(240+8, 6, 0);
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
        for (int i=0; i<10; i++) {
          for (int j=0; j<3; j++) {        
            if (Key.onp[i][j]==1) {
              if (i!=1 || j!=0) {//W
                if (i!=5 || j!=0) {//Y
                  if (i!=0 || j!=1) {//A
                    if (i!=7 || j!=0) {//I
                      if (i!=6 || j!=0) {//U
                        if (i!=2 || j!=0) {//E
                          if (i!=8 || j!=0) {//O
                            le(num, i, j, 2);
                            if (i<=2) {                  
                              sb_u(160-8, i, j);
                            } else if (i==4 || i==5) {
                              sb_d(160-8, i, j);
                            } else {
                              sb_d(160, i, j);
                            }
                            sb_u(200, 5, 0);
                            sb_d(240+8, 8, 0);
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
    num=0;
  }

  void bg() {
    background(r, g, b);
    fill(255);
    noStroke();
    ellipse(width+110, 450, R, R);
    for (int i=0; i<lope.length; i++) {
      if (lope[i]>0) {
        for (int j=0; j<8; j++) {
          if (lope[i]+j>R) {
            stroke(255);
          } else if (lope[i]+j<=R) {
            stroke(r, g, b);
          }
          strokeWeight(3);
          noFill();
          ellipse(width+110, 450, lope[i]+j, lope[i]+j);
        }
      }
    }

    for (int i=0; i<lope.length; i++) {
      if (lope[i]>0) {
        if (lope[i]<0) {
          lope[i]=0;
        } else {
          lope[i]--;
        }
        if (lope[i]==R) {
          if (R>=630) {
            go=1;
          } else if (R<630) {
            go=2;
          }
        }
      }
    }
    if (go==0) {
      R=630;
    } else if (go==1) {
      R++;
      if (R>1215) {
        R=0;
        go=2;
      }
    } else if (go==2) {
      if (R>=630) {      
        R=630;
        go=0;
      } else {
        R++;
      }
    }

    if (c_flag%8==0) {
      if (r<=226 && g<=244 && b<=132) {
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
      if (r==255 && g==255 && b==255) {
        c_flag++;
      } else {
        r+=2.63/12;
        g+=1.0/12;
        b+=11.18/12;
      }
    } else if (c_flag%8==2) {
      if (r<=249 && g<=127 && b<=172) {
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
      if (r==255 && g==255 && b==255) {
        c_flag++;
      } else {
        r+=1.0/22;
        g+=21.33/22;
        b+=13.83/22;
      }
    } else if (c_flag%8==4) {
      if (r<=129 && g<=219 && b<=249) {
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
      if (r==255 && g==255 && b==255) {
        c_flag++;
      } else {
        r+=21.0/22;
        g+=6.0/22;
        b+=1.0/22;
      }
    } else if (c_flag%8==6) {
      if (r<=249 && g<=192 && b<=127) {
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
      if (r==255 && g==255 && b==255) {
        c_flag++;
      } else {
        r+=1.0/50;
        g+=10.5/50;
        b+=21.33/50;
      }
    }
  }

  void k() {
    lope[l_num]=1215;
    if (l_num<lope.length-1) {
      l_num++;
    } else {
      l_num=0;
    }
  }

  void sb_u(int x, int i, int j) {
    pushMatrix();
    translate(x, 350-15*i);
    rotate(radians(-15));
    fill(0);
    ellipse(0, 0, 45, 30);
    popMatrix();
    line(x+20, 350-15*i, x+20, 350-15*(i+8));
    if (i==0) {
      line(x-30, 350, x+30, 350);
    }
    textSize(30);
    if (i<=3) {
      text(j+1, x+20, 350-15*(3+8)-10);
    } else {
      text(j+1, x+20, 350-15*(i+8)-10);
    }
  }

  void sb_d(int x, int i, int j) {
    pushMatrix();
    translate(x, 350-15*i);
    rotate(radians(-15));
    fill(0);
    ellipse(0, 0, 45, 30);
    popMatrix();
    line(x-20, 350-15*i, x-20, 350-15*(i-8));
    if (i==0) {
      line(x-30, 350, x+30, 350);
    }
    textSize(30);
    if (i>=6) {    
      text(j+1, x-20, 350-15*(6-8)+30);
    } else {
      text(j+1, x-20, 350-15*(i-8)+30);
    }
  }

  void le(int n, int i, int j, int b) {
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

