# Competitive Programming ZSH Plugin
# me@luisflores.mx
#

## CONFIGURATION ##
TEMPLATE=true
TEMPLATE_PATH="/Users/Luis/Developer/Competitive-Programming/template.cpp"

# USACO
USACO_USERNAME="aklovo1"
USACO_LANGUAJE="C++11"
###################

## GLOBAL VARIABLES ##
RED='\e[0;31m'
URED='\e[4;31m'
GREEN='\e[0;32m'
UGREEN='\e[4;32m'
BLUE='\e[0;34m'
UBLUE='\e[4;34m'
YELLOW='\e[0;33m'
UYELLOW='\e[4;33m'
WHITE='\e[0;37m'
NC='\e[0m' # No Color

OK="${GREEN}OK${NC}"
NO="${RED}NO${NC}"
#######################

function c {
    FILE_PATH="$1/$1"
    COMPILATION_FLAG="$2"

    if [ -f "$FILE_PATH.out" ]; then
        rm $FILE_PATH.out
    fi

    # Check if source file exists
    if [ -f "$FILE_PATH.cpp" ]; then
        # Compile with c++11 flag
        if [ $COMPILATION_FLAG ] && [ $COMPILATION_FLAG = "1" ]; then
            # Compile with JUDGE flag (debug purpose)
            c++ -std=c++11 $FILE_PATH.cpp -o $FILE_PATH.out -Wall -DJUDGE
        else
            c++ -std=c++11 $FILE_PATH.cpp -o $FILE_PATH.out -Wall
        fi

        # Check return status
        if [ ! -f "$FILE_PATH.out" ] ; then
            echo "${RED}*** COMPILATION ERROR!! ***${NC}"
            return
        fi
    else
        echo "${RED}** $FILE_PATH.cpp not found!! **${NC}"
        return
    fi
    
    # Check if input file exists
    if [ -f "$FILE_PATH.input" ]; then
        # Redirect output from input file to the binary and save the output
        OUTPUT=$(cat $FILE_PATH.input | time $FILE_PATH.out)
    else
        echo "${UYELLOW}**File $1.input not found! Enter input manually **${NC}"
        echo
        # Enter data manually
        OUTPUT=$($FILE_PATH.out)
    fi

    if [ $? != 0 ]; then
        # assert, crash, etc?
        echo "${RED}*** CRASH??!! ***${NC}"
        rm $FILE_PATH.out
        return
    fi

    # Check if output file exists
    if [ -f "$FILE_PATH.output" ]; then
        DIFF=$(diff <(echo "$OUTPUT") "$FILE_PATH.output")
    else
        echo "${YELLOW}** $1.output not found!! **${NC}"
        echo "${BLUE}*** YOUR OUTPUT ***${NC}"
        echo $OUTPUT
        rm $FILE_PATH.out
        return
    fi

    # Check diff status 
    # $OUT == 0, No differences
    # $OUT != 0, Some differences

    if [ $? = 0 ]; then
        echo "${UGREEN}*** ACCEPTED! ***${NC}"
    else
        echo
        echo "${YELLOW}-------- DIFF --------${NC}"
        echo "${WHITE}$DIFF${NC}"
        echo "${YELLOW}----------------------${NC}"
        echo
        echo "${YELLOW}-------- INPUT --------${NC}"
        echo "${WHITE}$(cat $FILE_PATH.input)${NC}" 
        echo "${YELLOW}-----------------------${NC}"    
        echo
        echo "${BLUE}----- YOUR OUTPUT -----${NC}"
        echo "${WHITE}$OUTPUT${NC}"
        echo "${BLUE}-----------------------${NC}"
        echo
        echo "${BLUE}--- EXPECTED OUTPUT ---${NC}"
        echo "${WHITE}$(cat $FILE_PATH.output)${NC}"
        echo "${BLUE}-----------------------${NC}"
        echo
        echo "${URED}**** WRONG ANSWER! ****${NC}"
    fi

    rm $FILE_PATH.out
}

function create {

    FORMAT=$2

    mkdir "$1"
    STATEMENT="Creating folder $1"
    printPad $STATEMENT

    touch "$1/$1.input"
    STATEMENT="Creating file $1/$1.input"
    printPad $STATEMENT

    touch "$1/$1.output"
    STATEMENT="Creating file $1/$1.output"
    printPad $STATEMENT

    STATEMENT="Copying template file"

    if [ $TEMPLATE ]; then
        if [ -f $TEMPLATE_PATH ]; then
            if [ $FORMAT ] && [ $FORMAT = "USACO" ]; then
                printHeaderUSACO $1 >> $1/$1.cpp 
                cat $TEMPLATE_PATH >> $1/$1.cpp
            else
                cp $TEMPLATE_PATH $1/$1.cpp
            fi

            printPad $STATEMENT
        else
            printPad $STATEMENT $NO
            touch "$1/$1.cpp"
            STATEMENT="Creating file $1/$1.cpp"
            printPad $STATEMENT
            echo
            echo "${YELLOW}** Template file not found, please check template file path **${NC}"
        fi
    else
        touch "$1/$1.cpp"
        STATEMENT="Creating file $1/$1.cpp"
        printPad $STATEMENT
    fi
}

function clean {
    mv $1/$1.cpp .
    STATEMENT="Moving file $1/$1.cpp"
    printPad $STATEMENT

    rm -rf $1
    STATEMENT="Removing folder $1"
    printPad $STATEMENT
}

# Helper methods

function printPad {
    if [ -z "$2" ]; then
        if [ $? = 0 ]; then
            STATUS="$OK"
        else
            STATUS="$NO"
        fi
    else
        STATUS=$2
    fi

    PAD=$(printf '%0.1s' "."{1..80})
    PADLENGTH=80
    printf "${WHITE} %s %*.*s ${NC}[ %b ]\n" "$1" 0 $((PADLENGTH - ${#1} - ${#STATUS} )) "$PAD" "$STATUS"
}

function printHeaderUSACO {
    echo "/*"
    echo "ID: $USACO_USERNAME"
    echo "PROG: $1"
    echo "LANG: $USACO_LANGUAJE"
    echo "*/"
}
