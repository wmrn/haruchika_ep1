static class Key {
  static int [][] onp =new int [10][3];

  static void pressed(char letter) {
    switch(letter) {
    case 'q':
      onp[0][0]=1;
      break;

    case 'a':
      onp[0][1]=1;
      break;

    case 'z':
      onp[0][2]=1;
      break;

    case 'w':
      onp[1][0]=1;
      break;

    case 's':
      onp[1][1]=1;
      break;

    case 'x':
      onp[1][2]=1;
      break;

    case 'e':
      onp[2][0]=1;
      break;

    case 'd':
      onp[2][1]=1;
      break;

    case 'c':
      onp[2][2]=1;
      break;

    case 'r':
      onp[3][0]=1;
      break;

    case 'f':
      onp[3][1]=1;
      break;

    case 'v':
      onp[3][2]=1;
      break;

    case 't':    
      onp[4][0]=1;
      break;

    case 'g':
      onp[4][1]=1;
      break;

    case 'b':
      onp[4][2]=1;
      break;

    case 'y':
      onp[5][0]=1;
      break;

    case 'h':
      onp[5][1]=1;
      break;

    case 'n':
      onp[5][2]=1;
      break;

    case 'u':
      onp[6][0]=1;
      break;

    case 'j':
      onp[6][1]=1;
      break;

    case 'm':
      onp[6][2]=1;
      break;

    case 'i':
      onp[7][0]=1;
      break;

    case 'k':
      onp[7][1]=1;
      break;

    case 'o':
      onp[8][0]=1;
      break;

    case 'l':
      onp[8][1]=1;
      break;

    case 'p':
      onp[9][0]=1;
      break;
    }
  }

  static void released(char letter) {
    switch(letter) {
    case 'q':
      onp[0][0]=0;
      break;

    case 'a':
      onp[0][1]=0;
      break;

    case 'z':
      onp[0][2]=0;
      break;

    case 'w':
      onp[1][0]=0;
      break;

    case 's':
      onp[1][1]=0;
      break;

    case 'x':
      onp[1][2]=0;
      break;

    case 'e':
      onp[2][0]=0;
      break;

    case 'd':
      onp[2][1]=0;
      break;

    case 'c':
      onp[2][2]=0;
      break;

    case 'r':
      onp[3][0]=0;
      break;

    case 'f':
      onp[3][1]=0;
      break;

    case 'v':
      onp[3][2]=0;
      break;

    case 't':    
      onp[4][0]=0;
      break;

    case 'g':
      onp[4][1]=0;
      break;

    case 'b':
      onp[4][2]=0;
      break;

    case 'y':
      onp[5][0]=0;
      break;

    case 'h':
      onp[5][1]=0;
      break;

    case 'n':
      onp[5][2]=0;
      break;

    case 'u':
      onp[6][0]=0;
      break;

    case 'j':
      onp[6][1]=0;
      break;

    case 'm':
      onp[6][2]=0;
      break;

    case 'i':
      onp[7][0]=0;
      break;

    case 'k':
      onp[7][1]=0;
      break;

    case 'o':
      onp[8][0]=0;
      break;

    case 'l':
      onp[8][1]=0;
      break;

    case 'p':
      onp[9][0]=0;
      break;
    }
  }
}
