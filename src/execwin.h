// Headers for downloading
#include <stdio.h>

int exec(const char * cmd, const char * options) {
    FILE * f = _popen(cmd, options);
    if ( f == 0 ) {
        fprintf( stderr, "Could not execute\n" );
        return 1;
    }
    const int BUFSIZE = 1000;
    char buf[ BUFSIZE ];
    while( fgets( buf, BUFSIZE,  f ) ) {
        fprintf( stdout, "%s", buf  );
    }
    _pclose( f );
    return 0;
}
