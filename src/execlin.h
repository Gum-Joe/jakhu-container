// Headers for linux exec
#include <stdio.h>

int exec() {
    FILE * f = popen( "ls", "r" );
    if ( f == 0 ) {
        fprintf( stderr, "Could not execute\n" );
        return 1;
    }
    const int BUFSIZE = 1000;
    char buf[ BUFSIZE ];
    while( fgets( buf, BUFSIZE,  f ) ) {
        fprintf( stdout, "%s", buf  );
    }
    pclose( f );
}
