// green tags -> more things about a code
// todo Including header files
#include<termios.h> // header file for terminal attributes
#include<unistd.h>
#include<errno.h>
#include<stdlib.h>
#include<ctype.h> //for iscntrl() function
#include<stdio.h>

// todo Defines
#define CTRL_KEY(k) ((k) & 0x1f) //? This will convert the above 3 bits to 0.

// todo Data

struct termios orig_termios;

// Terminal
//It will print error message and exit the program.
void die(const char *s){
    write(STDOUT_FILENO, "\x1b[2J", 4);
    write(STDOUT_FILENO, "\x1b[H", 3);
    perror(s); // * IT looks at the errno variable and prints a discriptive error message
    exit(1);  // * exit the program with exit status 0 that indictes a faliure.
}


void disableRawMode(){
    if(tcsetattr(STDIN_FILENO, TCIFLUSH, &orig_termios) == -1){
        die("tcsetattr");
    }
}
void enableRawMode(){

    if(tcgetattr(STDERR_FILENO, &orig_termios)==-1) die("tcgetattr");
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
    raw.c_cc[VMIN] = 0;// Vnim sets the minimim number of bytes before read and return.
    raw.c_cc[VTIME] = 1; //VTIME sets the max amount of time to wait bedore read().


    if(tcsetattr(STDIN_FILENO, TCSADRAIN, &raw) == -1) die("tcgetattr");
}

//! editorReadKey()'s job is to wait for one keybress and return it. ( deals with low level terminal input))
char editorReadKey() {
    int nread;
    char c;
    while((nread = read(STDIN_FILENO, &c, 1)) != 1) {
        if(nread == -1 && errno != EAGAIN) die("read");
    }
    return c;
}
// todo Output
void editorDrawRows() {
    int y;
    for(y = 0; y<24; y++){
        write(STDOUT_FILENO, "~\r\n",3);
    }
}
void editorRefreshScreen(){
    write(STDOUT_FILENO, "\x1b[2J", 4); //? They both come from unstid.h header file.
    write(STDOUT_FILENO, "\x1b[H", 3); //? This is onlt 3 byte long and uses H command to position cursor.
    //in the above line of code we are adding 4 bytes, \x1b is 27 in decimal and [2J are other 3 bytes.
    editorDrawRows();
    write(STDOUT_FILENO, "\x1b[H", 3);
}

// todo Input

//! this function waits of keypress and then handel it.(it deals with mapping keys to editor function.)
void editorProcessKeypress() {
    char c = editorReadKey();

    switch (c){
        case CTRL_KEY('q'):
        write(STDOUT_FILENO, "\x1b[2J", 4);
        write(STDOUT_FILENO, "\x1b[H", 3);
        exit(0);
        break;
    }
}




// todo Init 
int main(){
    enableRawMode();

    while(1){
        // char c = '\0';
        // if(read(STDIN_FILENO, &c,1)==-1 && errno != EAGAIN) die("read");
        // if(iscntrl(c)){
        //     printf("%d\r\n", c); //FROM NOW we have to write \r\n for newline.
        // } else {
        //     printf("%d ('%c')\r\n",c,c);
        // }
        // if( c == CTRL_KEY('q')) break;
        editorRefreshScreen();
        editorProcessKeypress();
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