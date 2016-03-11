import ddf.minim.*;
import ddf.minim.signals.*;

Minim minim;
AudioOutput audio;
SineWave dO;
SineWave rE;
SineWave mI;
SineWave FA;
SineWave SO;
SineWave RA;
SineWave SHI;
SineWave Do;
SineWave Re;
SineWave Mi;

int c_flag;
float r, g, b;
int count;
int [] lope = new int [120];
int l_num;
int go;
int R;
PFont moji;
PImage ton;
int [] posx = new int [3];
int [] sb_n = new int [3];
int [][] o_f = new int [5][3];
int flag;
int put_0;
int [] put_1 = new int [3];
int de_flag;
String str;

void setup() {
  size(415, 400);
  r=255;
  g=255;
  b=255;
  R=630;
  moji = createFont("MS-Gothic-48.vlw", 42);
  ton=loadImage("toooo.png");
  textFont(moji, 50);
  textAlign(CENTER);
  minim = new Minim(this);
  audio = minim.getLineOut(Minim.STEREO);
  dO = new SineWave(523.25, 0.8, audio.sampleRate());
  rE = new SineWave(587.33, 0.8, audio.sampleRate());
  mI = new SineWave(659.26, 0.8, audio.sampleRate());
  FA = new SineWave(698.46, 0.8, audio.sampleRate());
  SO = new SineWave(783.99, 0.8, audio.sampleRate());
  RA = new SineWave(880, 0.8, audio.sampleRate());
  SHI = new SineWave(987.77, 0.8, audio.sampleRate());
  Do = new SineWave(1046.50, 0.8, audio.sampleRate());
  Re = new SineWave(1174.66, 0.8, audio.sampleRate());
  Mi = new SineWave(1318.51, 0.8, audio.sampleRate());
  I_letter.init_letter();
}

void draw() {
  bg();
  image(ton, 15, 107, 100, 216); 
  for (int i=0; i<3; i++) {//3つの大きな区切り
    if (o_f[4][i]==0) {
      fill(200, 125);
    } else if (o_f[4][i]==1) {
      fill(255, 125);
    }
    strokeWeight(1);
    stroke(0);
    rect(110+90*i, 300-15*(5+8)-15, 90, 15*15+30);
  }
  for (int i=0; i<5; i++) {//五線譜
    strokeWeight(2);
    line(15, 150+30*i, width-15, 150+30*i);
  }
  strokeWeight(1);
  for (int i=0; i<4; i++) {//下の□   
    for (int j=0; j<3; j++) {
      if (o_f[i][j]==0) {
        fill(200, 125);
      } else if (o_f[i][j]==1) {
        fill(255, 125);
      }
      rect(20+90*i+6+26*j, 300-15*(6-8)+12+15, 26, 26);
      fill(10);
      textSize(25);
      text(j+1, 20+90*i+6+26*j+13, 300-15*(6-8)+12+23+15);
    }
  }
  if (de_flag==0) {
    fill(200, 125);
  } else if (de_flag==1) {
    fill(255, 125);
  }
  rect(width-120, 20, 100, 45);//decodeボタン
  fill(0);
  textSize(25);
  text("decode", width-70, 50);

  fill(0);
  textSize(50);
  text("「　　　　」", width/2-60, 60);

  if (flag==0) {//四角の灰色の状態
    for (int j=0; j<3; j++) {
      o_f[0][j]=1;
    }
  } else if (flag>=1) {//何個音符あるかまで判定した
    for (int i=0; i<5; i++) {//初期状態
      for (int j=0; j<3; j++) {
        if (i==0 && j!=put_0-1) {
          o_f[i][j]=0;
        } else if (0<i && i<=put_0) {
          o_f[i][j]=1;
        } else if (put_0<i && i<4) {
          o_f[i][j]=0;
        } else if (i==4 && j<=put_0-1) {
          o_f[i][j]=1;
        } else if (i==4 && put_0-1<j) {
          o_f[i][j]=0;
        }
      }
    }
    for (int i=1; i<4; i++) {//下の四角のON/OFF
      for (int j=0; j<3; j++) {
        if (put_1[i-1]!=0 && j==put_1[i-1]-1) {
          o_f[i][j]=1;
        } else if (put_1[i-1]!=0 && j!=put_1[i-1]-1) {
          o_f[i][j]=0;
        }
      }
    }
    int decision=0;//decode_button    
    for (int i=0; i<put_0; i++) {
      if (posx[i]!=0) {
        decision++;
      }
      for (int j=0; j<3; j++) {
        if (o_f[i+1][j]!=1) {
          decision++;
        }
      }
    }
    if (decision==put_0*3) {
      de_flag=1;
    }
  }
  if (flag==2) {
    fill(0);
    textSize(50);
    text(str, width/2-60, 60);
    for (int i=0; i<put_0; i++) {
      if (sb_n[i]==0) {
        audio.addSignal(dO);
      } else if (sb_n[i]==1) {
        audio.addSignal(rE);
      } else if (sb_n[i]==2) {
        audio.addSignal(mI);
      } else if (sb_n[i]==3) {
        audio.addSignal(FA);
      } else if (sb_n[i]==4) {
        audio.addSignal(SO);
      } else if (sb_n[i]==5) {
        audio.addSignal(RA);
      } else if (sb_n[i]==6) {
        audio.addSignal(SHI);
      } else if (sb_n[i]==7) {
        audio.addSignal(Do);
      } else if (sb_n[i]==8) {
        audio.addSignal(Re);
      } else if (sb_n[i]==9) {
        audio.addSignal(Mi);
      }
    }
  }
  if (flag!=2) {
    audio.removeSignal(dO);
    audio.removeSignal(rE);
    audio.removeSignal(mI);
    audio.removeSignal(FA);
    audio.removeSignal(SO);
    audio.removeSignal(RA);
    audio.removeSignal(SHI);
    audio.removeSignal(Do);
    audio.removeSignal(Re);
    audio.removeSignal(Mi);
  }


  if (put_0!=0) {//音符の配置
    for (int i=0; i<put_0; i++) {
      if (posx[i]!=0) {
        if (sb_n[i]<=5) {
          sb_u(posx[i], sb_n[i]);
        } else {
          sb_d(posx[i], sb_n[i]);
        }
      }
    }
  }
}



void mousePressed() {
  //音符の個数 
  if (300-15*(6-8)+12+15<mouseY && mouseY<300-15*(6-8)+12+26+15 && 20+90*0+6+26*0<mouseX && mouseX<20+90*0+6+26*2+26) {
    for (int i=0; i<4; i++) {//o_fのリセット
      for (int j=0; j<3; j++) {
        if (i==0) {
          o_f[i][j]=1;
        } else {
          o_f[i][j]=0;
        }
      }
    }
    for (int i=0; i<3; i++) {
      put_1[i]=0;
    }
    for (int i=0; i<3; i++) {//音符のリセット
      posx[i]=0;
      sb_n[i]=0;
    }
    de_flag=0;
    flag=1; 
    for (int j=0; j<3; j++) {
      if (20+90*0+6+26*j<mouseX && mouseX<20+90*0+6+26*j+26) {
        put_0=j+1;//1,2,3
      }
    }
  }

  if (flag>=1) {//音符の配置
    flag=1;
    if (300-15*(5+8)<mouseY && mouseY<300-15*(5+8)+15*15 && 110+90*0<mouseX && mouseX<110+90*(put_0-1)+90) {
      for (int i=0; i<put_0; i++) {
        if (110+90*i<mouseX && mouseX<110+90*i+90) {
          posx[i]=110+90*i+45;
          for (int j=0; j<10; j++) {
            if (200-15*j-7.5<mouseY && mouseY<300-15*j+7.5) {
              sb_n[i]=j;
            }
          }
        }
      }
    }
    for (int i=1; i<put_0+1; i++) {//音符の番号
      for (int j=0; j<3; j++) {
        if (300-15*(6-8)+12+15<mouseY && mouseY<300-15*(6-8)+12+26+15 && 20+90*i+6+26*j<mouseX && mouseX<20+90*i+6+26*j+26) {
          put_1[i-1]=j+1;//1,2,3
        }
      }
    }
  }
  if (flag==1) {
    if (de_flag==1 && width-100<mouseX && mouseX<width-100+80 && 20<mouseY && mouseY<20+45) {
      if (put_0==1) {
        str=I_letter.num1s[sb_n[0]*3+put_1[0]-1];
      } else if (put_0==2) {
        if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="あ(A)") {
          str=I_letter.num2s[sb_n[1]*3+put_1[1]-1][0];
        } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="い(I)") {
          str=I_letter.num2s[sb_n[1]*3+put_1[1]-1][1];
        } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="う(U)") {
          str=I_letter.num2s[sb_n[1]*3+put_1[1]-1][2];
        } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="え(E)") {
          str=I_letter.num2s[sb_n[1]*3+put_1[1]-1][3];
        } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="お(O)") {
          str=I_letter.num2s[sb_n[1]*3+put_1[1]-1][4];
        } else {
          if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="あ(A)") {
            str=I_letter.num2s[sb_n[0]*3+put_1[0]-1][0];
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="い(I)") {
            str=I_letter.num2s[sb_n[0]*3+put_1[0]-1][1];
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="う(U)") {
            str=I_letter.num2s[sb_n[0]*3+put_1[0]-1][2];
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="え(E)") {
            str=I_letter.num2s[sb_n[0]*3+put_1[0]-1][3];
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="お(O)") {
            str=I_letter.num2s[sb_n[0]*3+put_1[0]-1][4];
          } else {
            str="--";
          }
        }
      } else if (put_0==3) {
        if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="Y") {//1番目って「Y」？
          if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="あ(A)") {
            str=I_letter.num3s[sb_n[2]*3+put_1[2]-1][0];
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="い(I)") {
            str=I_letter.num3s[sb_n[2]*3+put_1[2]-1][1];
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="う(U)") {
            str=I_letter.num3s[sb_n[2]*3+put_1[2]-1][2];
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="え(E)") {
            str=I_letter.num3s[sb_n[2]*3+put_1[2]-1][3];
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="お(O)") {
            str=I_letter.num3s[sb_n[2]*3+put_1[2]-1][4];
          } else {
            if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="あ(A)") {
              str=I_letter.num3s[sb_n[1]*3+put_1[1]-1][0];
            } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="い(I)") {
              str=I_letter.num3s[sb_n[1]*3+put_1[1]-1][1];
            } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="う(U)") {
              str=I_letter.num3s[sb_n[1]*3+put_1[1]-1][2];
            } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="え(E)") {
              str=I_letter.num3s[sb_n[1]*3+put_1[1]-1][3];
            } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="お(O)") {
              str=I_letter.num3s[sb_n[1]*3+put_1[1]-1][4];
            } else {
              str="--";
            }
          }
        } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="Y") {//2番目って「Y」？
          if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="あ(A)") {
            str=I_letter.num3s[sb_n[0]*3+put_1[0]-1][0];
          } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="い(I)") {
            str=I_letter.num3s[sb_n[0]*3+put_1[0]-1][1];
          } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="う(U)") {
            str=I_letter.num3s[sb_n[0]*3+put_1[0]-1][2];
          } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="え(E)") {
            str=I_letter.num3s[sb_n[0]*3+put_1[0]-1][3];
          } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="お(O)") {
            str=I_letter.num3s[sb_n[0]*3+put_1[0]-1][4];
          } else {
            if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="あ(A)") {
              str=I_letter.num3s[sb_n[2]*3+put_1[2]-1][0];
            } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="い(I)") {
              str=I_letter.num3s[sb_n[2]*3+put_1[2]-1][1];
            } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="う(U)") {
              str=I_letter.num3s[sb_n[2]*3+put_1[2]-1][2];
            } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="え(E)") {
              str=I_letter.num3s[sb_n[2]*3+put_1[2]-1][3];
            } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="お(O)") {
              str=I_letter.num3s[sb_n[2]*3+put_1[2]-1][4];
            } else {
              str="--";
            }
          }
        } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="Y") {//3番目って「Y」？
          if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="あ(A)") {
            str=I_letter.num3s[sb_n[1]*3+put_1[1]-1][0];
          } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="い(I)") {
            str=I_letter.num3s[sb_n[1]*3+put_1[1]-1][1];
          } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="う(U)") {
            str=I_letter.num3s[sb_n[1]*3+put_1[1]-1][2];
          } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="え(E)") {
            str=I_letter.num3s[sb_n[1]*3+put_1[1]-1][3];
          } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="お(O)") {
            str=I_letter.num3s[sb_n[1]*3+put_1[1]-1][4];
          } else {
            if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="あ(A)") {
              str=I_letter.num3s[sb_n[0]*3+put_1[0]-1][0];
            } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="い(I)") {
              str=I_letter.num3s[sb_n[0]*3+put_1[0]-1][1];
            } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="う(U)") {
              str=I_letter.num3s[sb_n[0]*3+put_1[0]-1][2];
            } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="え(E)") {
              str=I_letter.num3s[sb_n[0]*3+put_1[0]-1][3];
            } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="お(O)") {
              str=I_letter.num3s[sb_n[0]*3+put_1[0]-1][4];
            } else {
              str="--";
            }
          }
        } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="H") {//1番目って「H」？
          if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="あ(A)") {
            if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="C") {
              str="ちゃ";
            } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="S") {
              str="しゃ";
            } else {
              str="--";
            }
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="C") {
            if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="あ(A)") {
              str="ちゃ";
            } else {
              str="--";
            }
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="S") {
            if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="あ(A)") {
              str="ちゃ";
            } else {
              str="--";
            }
          } else {            
            str="--";
          }
        } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="H") {//2番目って「H」？
          if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="あ(A)") {
            if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="C") {
              str="ちゃ";
            } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="S") {
              str="しゃ";
            } else {
              str="--";
            }
          } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="C") {
            if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="あ(A)") {
              str="ちゃ";
            } else {
              str="--";
            }
          } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="S") {
            if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="あ(A)") {
              str="ちゃ";
            } else {
              str="--";
            }
          } else {            
            str="--";
          }
        } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="H") {//3番目って「H」？
          if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="あ(A)") {
            if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="C") {
              str="ちゃ";
            } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="S") {
              str="しゃ";
            } else {
              str="--";
            }
          } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="C") {
            if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="あ(A)") {
              str="ちゃ";
            } else {
              str="--";
            }
          } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="S") {
            if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="あ(A)") {
              str="ちゃ";
            } else {
              str="--";
            }
          } else {            
            str="--";
          }
        } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="T") {//1番目って「T」？
          if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="X") {
            if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="U") {
              str="っ";
            } else {
              str="--";
            }
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="S") {
            if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="U") {
              str="つ";
            } else {
              str="--";
            }
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="U") {
            if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="X") {
              str="っ";
            } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="S") {
              str="つ";
            } else {
              str="--";
            }
          }
        } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="T") {//2番目って「T」？
          if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="X") {
            if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="U") {
              str="っ";
            } else {
              str="--";
            }
          } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="S") {
            if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="U") {
              str="つ";
            } else {
              str="--";
            }
          } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="U") {
            if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="X") {
              str="っ";
            } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="S") {
              str="つ";
            } else {
              str="--";
            }
          }
        } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="T") {//3番目って「T」？
          if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="X") {
            if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="U") {
              str="っ";
            } else {
              str="--";
            }
          } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="S") {
            if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="U") {
              str="つ";
            } else {
              str="--";
            }
          } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="U") {
            if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="X") {
              str="っ";
            } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="S") {
              str="つ";
            } else {
              str="--";
            }
          }
        } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="K") {//1番目って「K」？
          if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="X") {
            if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="あ(A)") {
              str="ヵ";
            } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="え(E)") {
              str="ヶ";
            } else {
              str="--";
            }
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="あ(A)") {
            if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="X") {
              str="ヵ";
            } else {
              str="--";
            }
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="え(E)") {
            if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="X") {
              str="ヶ";
            } else {
              str="--";
            }
          }
        } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="K") {//2番目って「K」？
          if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="あ(A)") {
            if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="X") {
              str="ヵ";
            } else {
              str="--";
            }
          } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="え(E)") {
            if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="X") {
              str="ヶ";
            } else {
              str="--";
            }
          } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="X") {
            if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="あ(A)") {
              str="ヵ";
            } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="え(E)") {
              str="ヶ";
            } else {
              str="--";
            }
          }
        } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="K") {//3番目って「K」？
          if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="あ(A)") {
            if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="X") {
              str="ヵ";
            } else {
              str="--";
            }
          } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="え(E)") {
            if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="X") {
              str="ヶ";
            } else {
              str="--";
            }
          } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="X") {
            if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="あ(A)") {
              str="ヵ";
            } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="え(E)") {
              str="ヶ";
            } else {
              str="--";
            }
          }
        } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="W") {//1番目って「W」？
          if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="X") {
            if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="あ(A)") {
              str="ゎ";
            } else {
              str="--";
            }
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="あ(A)") {
            if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="X") {
              str="ゎ";
            } else {
              str="--";
            }
          }
        } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="W") {//2番目って「W」？
          if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="X") {
            if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="あ(A)") {
              str="ゎ";
            } else {
              str="--";
            }
          } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="あ(A)") {
            if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="X") {
              str="ゎ";
            } else {
              str="--";
            }
          }
        } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="W") {//3番目って「W」？
          if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="X") {
            if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="あ(A)") {
              str="ゎ";
            } else {
              str="--";
            }
          } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="あ(A)") {
            if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="W") {
              str="ゎ";
            } else {
              str="--";
            }
          }
        } else {
          str="--";
        }
      }
      flag=2;
      lope[l_num]=1005;
      if (l_num<lope.length-1) {
        l_num++;
      } else {
        l_num=0;
      }
    }
  }
}

void bg() {
  background(255);
  fill(r, g, b);
  noStroke();
  ellipse(110, 400, R, R);
  for (int i=0; i<lope.length; i++) {
    if (lope[i]>0) {
      for (int j=0; j<25; j++) {
        if (lope[i]+j>R) {
          stroke(r, g, b);
        } else if (lope[i]+j<=R) {
          stroke(255);
        }
        strokeWeight(1);
        noFill();
        ellipse(110, 400, lope[i]+j, lope[i]+j);
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
    if (R>1005) {
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


void sb_u(int x, int i) {
  pushMatrix();
  translate(x, 300-15*i);
  rotate(radians(-15));
  fill(0);
  ellipse(0, 0, 45, 30);
  popMatrix();
  strokeWeight(2);
  line(x+20, 300-15*i, x+20, 300-15*(i+8));
  if (i==0) {
    line(x-30, 300, x+30, 300);
  }
}

void sb_d(int x, int i) {
  pushMatrix();
  translate(x, 300-15*i);
  rotate(radians(-15));
  fill(0);
  ellipse(0, 0, 45, 30);
  popMatrix();
  strokeWeight(2);
  line(x-20, 300-15*i, x-20, 300-15*(i-8));
}

