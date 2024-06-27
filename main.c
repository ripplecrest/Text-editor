#include<termios.h> // header file for terminal attributes
#include<unistd.h>
#include<stdlib.h>
#include<ctype.h> //for iscntrl() function
#include<stdio.h>



struct termios orig_termios;

void disableRawMode(){
    tcsetattr(STDIN_FILENO, TCIFLUSH, &orig_termios);
}
void enableRawMode(){

    tcgetattr(STDERR_FILENO, &orig_termios);
    atexit(disableRawMode);

    struct termios raw = orig_termios;
    
    //this will disable the ctrl s & ctrl q
    //XOFF to pause transmission and XON to resume transmission.
    // NL in ICRNL stands for new line
    raw.c_iflag &= ~(BRKINT | ICRNL |INPCK| ISTRIP | IXON); //IXON starts with i it is a input flag.
    
    //turning off al the output processes
    //o means output and post means post-processing of output.
    raw.c_oflag &= ~(OPOST);

    raw.c_cflag |= (CS8);


    //ISIG comes from the <termios.c>, like ICANON but it is not a input flag.
    //IEXTEN is used to turn off ctrl v, ctrl v waits to type another signal and then send character literally
    //IEXTEN is also from termios.h & belongs to the c_lflag. 
    raw.c_lflag &= ~(ECHO | ICANON | IEXTEN | ISIG ); // this disable ctrl c & ctrl z
    
    //adding a timeout for printf().
    raw.c_cc[VMIN] = 0;
    raw.c_cc[VTIME] = 1;


    tcsetattr(STDIN_FILENO, TCSADRAIN, &raw);
}
int main(){
    enableRawMode();

    while(1){
        char c = '\0';
        read(STDIN_FILENO, &c,1);
        if(iscntrl(c)){
            printf("%d\r\n", c); //FROM NOW we have to write \r\n for newline.
        } else {
            printf("%d ('%c')\r\n",c,c);
        }
        if( c == 'q') break;
    }
    return 0;
}

// Struct termios, tcgetattr(), tcsetattr(), ECHO and TCAFLUSH  comes from <termios.h>
// Echo cause each key you type to be printed to the terminal.
// at exit comes from stdlib.h it automatically calls the disableRawMode() function on when the program is exit.
// ICANON comes from termios.h 

// ctrl-c sends a SIGINT signal tp the current process which cause it to terminate.
// ctrl-z senda a SIGTSTP signal to the current process which cause it suspend.




/*
ctrl - m






*/