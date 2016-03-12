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
int [] posx = new int [3];//どこのboxをクリックしたか
int [] sb_n = new int [3];//音符の番号把握
int [][] o_f = new int [5][3];//選択可能か不可かの判定
int flag;//段階
int put_0;//個数の確認
int [] put_1 = new int [3];//番号の確認
int de_flag;//必要事項がそろってるかそろってないか
String str;//これに文字を代入して表示させる

void setup() {
  size(415, 400);
  //背景
  r=255;//最初は真っ白
  g=255;
  b=255;
  R=630;//背景の模様の円の直径
  
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
  I_letter.init_letter();//文字の代入
}

void draw() {
  bg();//背景
  image(ton, 15, 107, 100, 216); 
  for (int i=0; i<3; i++) {//3つの大きな区切り
    if (o_f[4][i]==0) {//選択可能の時
      fill(200, 125);
    } else if (o_f[4][i]==1) {//選択不可の時
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
      if (o_f[i][j]==0) {//選択可能の時
        fill(200, 125);
      } else if (o_f[i][j]==1) {//選択不可または非選択の時
        fill(255, 125);
      }
      rect(20+90*i+6+26*j, 300-15*(6-8)+12+15, 26, 26);
      fill(10);
      textSize(25);
      text(j+1, 20+90*i+6+26*j+13, 300-15*(6-8)+12+23+15);
    }
  }
  
  if (de_flag==0) {//選択可能の時
    fill(200, 125);
  } else if (de_flag==1) {//選択不可の時
    fill(255, 125);
  }
  rect(width-120, 20, 100, 45);//decodeボタン
  fill(0);
  textSize(25);
  text("decode", width-70, 50);

  fill(0);
  textSize(50);
  text("「　　　　」", width/2-60, 60);//常時表示の上のかっこ

  if (flag==0) {//個数の部分だけ選択可能
    for (int j=0; j<3; j++) {
      o_f[0][j]=1;
    }
  } else if (flag>=1) {//何個音符あるかまで判定した
    for (int i=0; i<5; i++) {//個数のみ選択した初期状態
      for (int j=0; j<3; j++) {
        if (i==0 && j!=put_0-1) {//選択されたもの以外はoffにする
          o_f[i][j]=0;
        } else if (0<i && i<=put_0) {//選択された個数だけ選択可能にする
          o_f[i][j]=1;
        } else if (put_0<i && i<4) {//それ以外はoff
          o_f[i][j]=0;
        } else if (i==4 && j<=put_0-1) {//大きな□を選択された個数だけ選択可能にする
          o_f[i][j]=1;
        } else if (i==4 && put_0-1<j) {//それ以外の大きな□をoff
          o_f[i][j]=0;
        }
      }
    }
    for (int i=1; i<4; i++) {//下の四角のON/OFF
      for (int j=0; j<3; j++) {
        if (put_1[i-1]!=0 && j==put_1[i-1]-1) {//選択されたものはon
          o_f[i][j]=1;
        } else if (put_1[i-1]!=0 && j!=put_1[i-1]-1) {//それ以外はoff
          o_f[i][j]=0;
        }
      }
    }
    int decision=0;//decode_button    
    for (int i=0; i<put_0; i++) {//選択されてる個数の確認
      if (posx[i]!=0) {
        decision++;
      }
      for (int j=0; j<3; j++) {
        if (o_f[i+1][j]!=1) {
          decision++;
        }
      }
    }
    if (decision==put_0*3) {//必要事項がそろったことが確認で来たらon
      de_flag=1;
    }
  }
  
  if (flag==2) {//文字の判定が終わって表示する
    fill(0);
    textSize(50);
    text(str, width/2-60, 60);//日本語表示
    for (int i=0; i<put_0; i++) {//音符の音
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
  if (flag!=2) {//deocdeした後じゃないときは音鳴らさない
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
      if (posx[i]!=0) {//クリックされたことの確認
        if (sb_n[i]<=5) {//第3線よりも下なら上向き
          sb_u(posx[i], sb_n[i]);
        } else {//それ以外は上向き
          sb_d(posx[i], sb_n[i]);
        }
      }
    }
  }
}


void mousePressed() {
  //音符の個数の選択 
  if (300-15*(6-8)+12+15<mouseY && mouseY<300-15*(6-8)+12+26+15 && 20+90*0+6+26*0<mouseX && mouseX<20+90*0+6+26*2+26) {
    for (int i=0; i<4; i++) {//o_fのリセット
      for (int j=0; j<3; j++) {
        if (i==0) {//個数のとこだけon
          o_f[i][j]=1;
        } else {
          o_f[i][j]=0;
        }
      }
    }
    for (int i=0; i<3; i++) {//番号の確認のリセット
      put_1[i]=0;
    }
    for (int i=0; i<3; i++) {//音符のリセット
      posx[i]=0;
      sb_n[i]=0;
    }
    de_flag=0;//deocdeボタンのリセット
    flag=1;//音符選択の段階へ
    for (int j=0; j<3; j++) {//個数確認
      if (20+90*0+6+26*j<mouseX && mouseX<20+90*0+6+26*j+26) {
        put_0=j+1;//1,2,3
      }
    }
  }

  if (flag>=1) {
    flag=1;//段階2からでも音符の配置のし直しが出来るように段階を1に戻す
    if (300-15*(5+8)<mouseY && mouseY<300-15*(5+8)+15*15 && 110+90*0<mouseX && mouseX<110+90*(put_0-1)+90) {
      for (int i=0; i<put_0; i++) {
        if (110+90*i<mouseX && mouseX<110+90*i+90) {
          posx[i]=110+90*i+45;//音符の配置
          for (int j=0; j<10; j++) {
            if (200-15*j-7.5<mouseY && mouseY<300-15*j+7.5) {
              sb_n[i]=j;//音階の確認
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
  
  if (flag==1) {//decode中？
    if (de_flag==1 && width-100<mouseX && mouseX<width-100+80 && 20<mouseY && mouseY<20+45) {
      if (put_0==1) {//1このとき
        str=I_letter.num1s[sb_n[0]*3+put_1[0]-1];
      } else if (put_0==2) {//2このとき
        if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="あ(A)") {//1番目って「A」？
          str=I_letter.num2s[sb_n[1]*3+put_1[1]-1][0];
        } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="い(I)") {//1番目って「I」？
          str=I_letter.num2s[sb_n[1]*3+put_1[1]-1][1];
        } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="う(U)") {//1番目って「U」？
          str=I_letter.num2s[sb_n[1]*3+put_1[1]-1][2];
        } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="え(E)") {//1番目って「E」？
          str=I_letter.num2s[sb_n[1]*3+put_1[1]-1][3];
        } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="お(O)") {//1番目って「O」？
          str=I_letter.num2s[sb_n[1]*3+put_1[1]-1][4];
        } else {//1番目母音じゃないとき
          if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="あ(A)") {//2番目って「A」？
            str=I_letter.num2s[sb_n[0]*3+put_1[0]-1][0];
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="い(I)") {//2番目って「I」？
            str=I_letter.num2s[sb_n[0]*3+put_1[0]-1][1];
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="う(U)") {//2番目って「U」？
            str=I_letter.num2s[sb_n[0]*3+put_1[0]-1][2];
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="え(E)") {//2番目って「E」？
            str=I_letter.num2s[sb_n[0]*3+put_1[0]-1][3];
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="お(O)") {//2番目って「O」？
            str=I_letter.num2s[sb_n[0]*3+put_1[0]-1][4];
          } else {//1つも母音なかったから没
            str="--";
          }
        }
      } else if (put_0==3) {//3このとき
        if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="Y") {//1番目って「Y」？
          if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="あ(A)") {//2番目って「A」？
            str=I_letter.num3s[sb_n[2]*3+put_1[2]-1][0];
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="い(I)") {//2番目って「I」？
            str=I_letter.num3s[sb_n[2]*3+put_1[2]-1][1];
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="う(U)") {//2番目って「U」？
            str=I_letter.num3s[sb_n[2]*3+put_1[2]-1][2];
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="え(E)") {//2番目って「E」？
            str=I_letter.num3s[sb_n[2]*3+put_1[2]-1][3];
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="お(O)") {//2番目って「O」？
            str=I_letter.num3s[sb_n[2]*3+put_1[2]-1][4];
          } else {//2番目母音じゃないとき
            if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="あ(A)") {//3番目って「A」？
              str=I_letter.num3s[sb_n[1]*3+put_1[1]-1][0];
            } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="い(I)") {//3番目って「I」？
              str=I_letter.num3s[sb_n[1]*3+put_1[1]-1][1];
            } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="う(U)") {//3番目って「U」？
              str=I_letter.num3s[sb_n[1]*3+put_1[1]-1][2];
            } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="え(E)") {//3番目って「E」？
              str=I_letter.num3s[sb_n[1]*3+put_1[1]-1][3];
            } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="お(O)") {//3番目って「O」？
              str=I_letter.num3s[sb_n[1]*3+put_1[1]-1][4];
            } else {//1つも母音なかったから没
              str="--";
            }
          }
        } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="Y") {//2番目って「Y」？
          if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="あ(A)") {//3番目って「A」？
            str=I_letter.num3s[sb_n[0]*3+put_1[0]-1][0];
          } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="い(I)") {//3番目って「I」？
            str=I_letter.num3s[sb_n[0]*3+put_1[0]-1][1];
          } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="う(U)") {//3番目って「U」？
            str=I_letter.num3s[sb_n[0]*3+put_1[0]-1][2];
          } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="え(E)") {//3番目って「E」？
            str=I_letter.num3s[sb_n[0]*3+put_1[0]-1][3];
          } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="お(O)") {//3番目って「O」？
            str=I_letter.num3s[sb_n[0]*3+put_1[0]-1][4];
          } else {//3番目母音じゃないとき
            if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="あ(A)") {//1番目って「A」？
              str=I_letter.num3s[sb_n[2]*3+put_1[2]-1][0];
            } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="い(I)") {//1番目って「I」？
              str=I_letter.num3s[sb_n[2]*3+put_1[2]-1][1];
            } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="う(U)") {//1番目って「U」？
              str=I_letter.num3s[sb_n[2]*3+put_1[2]-1][2];
            } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="え(E)") {//1番目って「E」？
              str=I_letter.num3s[sb_n[2]*3+put_1[2]-1][3];
            } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="お(O)") {//1番目って「O」？
              str=I_letter.num3s[sb_n[2]*3+put_1[2]-1][4];
            } else {//1つも母音なかったから没
              str="--";
            }
          }
        } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="Y") {//3番目って「Y」？
          if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="あ(A)") {//1番目って「A」？
            str=I_letter.num3s[sb_n[1]*3+put_1[1]-1][0];
          } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="い(I)") {//1番目って「I」？
            str=I_letter.num3s[sb_n[1]*3+put_1[1]-1][1];
          } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="う(U)") {//1番目って「U」？
            str=I_letter.num3s[sb_n[1]*3+put_1[1]-1][2];
          } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="え(E)") {//1番目って「E」？
            str=I_letter.num3s[sb_n[1]*3+put_1[1]-1][3];
          } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="お(O)") {//1番目って「O」？
            str=I_letter.num3s[sb_n[1]*3+put_1[1]-1][4];
          } else {//1番目母音じゃないとき
            if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="あ(A)") {//2番目って「A」？
              str=I_letter.num3s[sb_n[0]*3+put_1[0]-1][0];
            } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="い(I)") {//2番目って「I」？
              str=I_letter.num3s[sb_n[0]*3+put_1[0]-1][1];
            } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="う(U)") {//2番目って「U」？
              str=I_letter.num3s[sb_n[0]*3+put_1[0]-1][2];
            } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="え(E)") {//2番目って「E」？
              str=I_letter.num3s[sb_n[0]*3+put_1[0]-1][3];
            } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="お(O)") {//2番目って「O」？
              str=I_letter.num3s[sb_n[0]*3+put_1[0]-1][4];
            } else {//1つも母音なかったから没
              str="--";
            }
          }
        } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="H") {//1番目って「H」？
          if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="あ(A)") {//2番目って「A」？
            if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="C") {//3番目って「C」？
              str="ちゃ";
            } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="S") {//3番目って「S」？
              str="しゃ";
            } else {//他は没
              str="--";
            }
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="C") {//2番目って「C」？
            if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="あ(A)") {//2番目って「A」？
              str="ちゃ";
            } else {//他は没
              str="--";
            }
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="S") {//2番目って「S」？
            if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="あ(A)") {//2番目って「A」？
              str="ちゃ";
            } else {//他は没
              str="--";
            }
          } else {//他は没           
            str="--";
          }
        } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="H") {//2番目って「H」？
          if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="あ(A)") {//3番目って「A」？
            if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="C") {//1番目って「C」？
              str="ちゃ";
            } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="S") {//1番目って「S」？
              str="しゃ";
            } else {//他は没
              str="--";
            }
          } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="C") {//3番目って「C」？
            if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="あ(A)") {//1番目って「A」？
              str="ちゃ";
            } else {//他は没
              str="--";
            }
          } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="S") {//3番目って「S」？
            if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="あ(A)") {//1番目って「A」？
              str="ちゃ";
            } else {//他は没
              str="--";
            }
          } else {//他は没           
            str="--";
          }
        } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="H") {//3番目って「H」？
          if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="あ(A)") {//1番目って「A」？
            if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="C") {//2番目って「C」？
              str="ちゃ";
            } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="S") {//2番目って「S」？
              str="しゃ";
            } else {//他は没
              str="--";
            }
          } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="C") {//1番目って「C」？
            if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="あ(A)") {//2番目って「A」？
              str="ちゃ";
            } else {//他は没
              str="--";
            }
          } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="S") {//1番目って「S」？
            if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="あ(A)") {//2番目って「A」？
              str="ちゃ";
            } else {//他は没
              str="--";
            }
          } else {//他は没           
            str="--";
          }
        } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="T") {//1番目って「T」？
          if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="X") {//2番目って「X」？
            if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="U") {//3番目って「U」？
              str="っ";
            } else {//他は没
              str="--";
            }
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="S") {//2番目って「S」？
            if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="U") {//3番目って「U」？
              str="つ";
            } else {//他は没
              str="--";
            }
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="U") {//2番目って「U」？
            if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="X") {//3番目って「X」？
              str="っ";
            } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="S") {//3番目って「S」？
              str="つ";
            } else {//他は没
              str="--";
            }
          }
        } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="T") {//2番目って「T」？
          if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="X") {//3番目って「X」？
            if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="U") {//1番目って「U」？
              str="っ";
            } else {//他は没
              str="--";
            }
          } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="S") {//3番目って「S」？
            if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="U") {//1番目って「U」？
              str="つ";
            } else {//他は没
              str="--";
            }
          } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="U") {//3番目って「U」？
            if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="X") {//1番目って「X」？
              str="っ";
            } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="S") {//1番目って「S」？
              str="つ";
            } else {//他は没
              str="--";
            }
          }
        } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="T") {//3番目って「T」？
          if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="X") {//1番目って「X」？
            if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="U") {//2番目って「U」？
              str="っ";
            } else {//他は没
              str="--";
            }
          } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="S") {//1番目って「S」？
            if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="U") {//2番目って「U」？
              str="つ";
            } else {//他は没
              str="--";
            }
          } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="U") {//1番目って「U」？
            if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="X") {//2番目って「X」？
              str="っ";
            } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="S") {//2番目って「S」？
              str="つ";
            } else {//他は没
              str="--";
            }
          }
        } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="K") {//1番目って「K」？
          if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="X") {//2番目って「X」？
            if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="あ(A)") {//3番目って「A」？
              str="ヵ";
            } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="え(E)") {//3番目って「E」？
              str="ヶ";
            } else {//他は没
              str="--";
            }
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="あ(A)") {//2番目って「A」？
            if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="X") {//3番目って「X」？
              str="ヵ";
            } else {//他は没
              str="--";
            }
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="え(E)") {//2番目って「E」？
            if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="X") {//3番目って「X」？
              str="ヶ";
            } else {//他は没
              str="--";
            }
          }
        } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="K") {//2番目って「K」？
          if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="あ(A)") {//3番目って「A」？
            if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="X") {//1番目って「X」？
              str="ヵ";
            } else {//他は没
              str="--";
            }
          } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="え(E)") {//3番目って「E」？
            if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="X") {//1番目って「X」？
              str="ヶ";
            } else {//他は没
              str="--";
            }
          } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="X") {//3番目って「X」？
            if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="あ(A)") {//1番目って「A」？
              str="ヵ";
            } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="え(E)") {//1番目って「E」？
              str="ヶ";
            } else {//他は没
              str="--";
            }
          }
        } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="K") {//3番目って「K」？
          if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="あ(A)") {//1番目って「A」？
            if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="X") {//2番目って「X」？
              str="ヵ";
            } else {//他は没
              str="--";
            }
          } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="え(E)") {//1番目って「E」？
            if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="X") {//2番目って「X」？
              str="ヶ";
            } else {//他は没
              str="--";
            }
          } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="X") {//1番目って「X」？
            if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="あ(A)") {//2番目って「A」？
              str="ヵ";
            } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="え(E)") {//2番目って「E」？
              str="ヶ";
            } else {//他は没
              str="--";
            }
          }
        } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="W") {//1番目って「W」？
          if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="X") {//2番目って「X」？
            if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="あ(A)") {//3番目って「A」？
              str="ゎ";
            } else {//他は没
              str="--";
            }
          } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="あ(A)") {//2番目って「A」？
            if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="X") {//3番目って「X」？
              str="ゎ";
            } else {//他は没
              str="--";
            }
          }
        } else if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="W") {//2番目って「W」？
          if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="X") {//3番目って「X」？
            if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="あ(A)") {//1番目って「A」？
              str="ゎ";
            } else {//他は没
              str="--";
            }
          } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="あ(A)") {//3番目って「A」？
            if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="X") {//1番目って「X」？
              str="ゎ";
            } else {//他は没
              str="--";
            }
          }
        } else if (I_letter.num1s[sb_n[2]*3+put_1[2]-1]=="W") {//3番目って「W」？
          if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="X") {//1番目って「X」？
            if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="あ(A)") {//2番目って「A」？
              str="ゎ";
            } else {//他は没
              str="--";
            }
          } else if (I_letter.num1s[sb_n[0]*3+put_1[0]-1]=="あ(A)") {//1番目って「A」？
            if (I_letter.num1s[sb_n[1]*3+put_1[1]-1]=="X") {//2番目って「X」？
              str="ゎ";
            } else {//他は没
              str="--";
            }
          }
        } else {//他は没
          str="--";
        }
      }
      flag=2;//decode終了
      lope[l_num]=1005;//輪っか発射
      if (l_num<lope.length-1) {
        l_num++;
      } else {
        l_num=0;
      }
    }
  }
}

void bg() {//背景
  background(255);//色だけencode版とは逆
  fill(r, g, b);
  noStroke();
  ellipse(110, 400, R, R);
  for (int i=0; i<lope.length; i++) {
    if (lope[i]>0) {
      for (int j=0; j<8; j++) {//遅くてイライラしたら8→1にする
        if (lope[i]+j>R) {//輪っかが円よりも大きいとき
          stroke(r, g, b);//輪っかの色は円と一緒
        } else if (lope[i]+j<=R) {//輪っかが円よりも小さいとき
          stroke(255);//輪っかの色は背景と一緒
        }
        strokeWeight(3);
        noFill();
        ellipse(110, 400, lope[i]+j, lope[i]+j);//輪っか
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
    if (R>1005) {//はみ出したら「0」にリセット
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


void sb_u(int x, int i) {//上向きの四分音符
  pushMatrix();
  translate(x, 300-15*i);
  rotate(radians(-15));
  fill(0);
  ellipse(0, 0, 45, 30);
  popMatrix();
  strokeWeight(2);
  line(x+20, 300-15*i, x+20, 300-15*(i+8));
  if (i==0) {
    line(x-30, 300, x+30, 300);//ドのときの横棒
  }
}

void sb_d(int x, int i) {//下向きの四分音符
  pushMatrix();
  translate(x, 300-15*i);
  rotate(radians(-15));
  fill(0);
  ellipse(0, 0, 45, 30);
  popMatrix();
  strokeWeight(2);
  line(x-20, 300-15*i, x-20, 300-15*(i-8));
  //今回は下向きのドの場合は絶対ないから横棒のif文はなし
}

