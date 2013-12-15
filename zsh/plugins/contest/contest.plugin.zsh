# Competitive Programming ZSH Plugin
# me@luisflores.mx
#

function c {
    # Compile with c++11 flag
    c++ -std=c++11 $1

    # Execute
    ./a.out

    # Remove binary
    rm a.out
}
