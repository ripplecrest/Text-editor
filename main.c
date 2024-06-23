#include<termios.h> // header file for terminal attributes
#include<unistd.h>
#include<stdlib.h>
#include<ctype.h>
#include<stdio.h>



struct termios orig_termios;

void disableRawMode(){
    tcsetattr(STDIN_FILENO, TCIFLUSH, &orig_termios);
}
void enableRawMode(){

    tcgetattr(STDERR_FILENO, &orig_termios);
    atexit(disableRawMode);

    struct termios raw = orig_termios;
    
    raw.c_lflag &= ~(ECHO | ICANON);
    tcsetattr(STDIN_FILENO, TCSADRAIN, &raw);
}
int main(){
    enableRawMode();

    char c;
    while(read(STDIN_FILENO, &c, 1) == 1 && c != 'q'){
        if(iscntrl(c)){
            printf("%d", c);
        } else {
            printf("%d ('%c')\n",c,c);
        }
    }
    return 0;
}

// Struct termios, tcgetattr(), tcsetattr(), ECHO and TCAFLUSH  comes from <termios.h>
// Echo cause each key you type to be printed to the terminal.
// at exit comes from stdlib.h it automatically calls the disableRawMode() function on when the program is exit.
// ICANON comes from termios.h 