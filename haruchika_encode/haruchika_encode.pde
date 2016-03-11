//KYO TYA TYU HYOがなぜか認識できない…。26
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

Summary_e summary;

void setup() {
  size(300, 510);
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
  summary = new Summary_e();
}

void draw() {
  summary.d();
}

void keyPressed() {
    Key.pressed(key);
  if (key =='q' || key =='a' || key=='z') {
    audio.addSignal(dO);
  }
  if (key =='w' || key=='s' || key=='x') {
    audio.addSignal(rE);
  }
  if (key =='e'||key=='d'||key=='c') {
    audio.addSignal(mI);
  }
  if (key=='r' || key=='f'|| key=='v') {
    audio.addSignal(FA);
  }
  if (key=='t' || key=='g'||key=='b') {
    audio.addSignal(SO);
  }
  if (key=='y'||key=='h'||key=='n') {
    audio.addSignal(RA);
  }
  if (key=='u'||key=='j'||key=='m') {
    audio.addSignal(SHI);
  }
  if (key=='i'||key=='k') {
    audio.addSignal(Do);
  }
  if (key=='o'||key=='l') {
    audio.addSignal(Re);
  }
  if (key=='p') {
    audio.addSignal(Mi);
  }
}

void keyReleased() {
summary.k();
  Key.released(key);
  if (key =='q' || key =='a' || key=='z') {
    audio.removeSignal(dO);
  }
  if (key =='w' || key=='s' || key=='x') {
    audio.removeSignal(rE);
  }
  if (key =='e'||key=='d'||key=='c') {
    audio.removeSignal(mI);
  }
  if (key=='r' || key=='f'|| key=='v') {
    audio.removeSignal(FA);
  }
  if (key=='t' || key=='g'||key=='b') {
    audio.removeSignal(SO);
  }
  if (key=='y'||key=='h'||key=='n') {
    audio.removeSignal(RA);
  }
  if (key=='u'||key=='j'||key=='m') {
    audio.removeSignal(SHI);
  }
  if (key=='i'||key=='k') {
    audio.removeSignal(Do);
  }
  if (key=='o'||key=='l') {
    audio.removeSignal(Re);
  }
  if (key=='p') {
    audio.removeSignal(Mi);
  }
}


