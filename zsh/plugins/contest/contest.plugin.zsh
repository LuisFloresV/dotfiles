# Competitive Programming ZSH Plugin
# me@luisflores.mx
#

RED='\e[4;31m'
GREEN='\e[4;32m'
BLUE='\e[4;34m'
YELLOW_BACKGROUND='\e[43m'
YELLOW='\e[4;33m'
NC='\e[0m' # No Color

function c {
	FILENAME="$1/$1"
	FILE="$FILENAME.cpp"

    # Compile with c++11 flag
    c++ -std=c++11 $FILE -o $1/a.out
    # Save return status
    OUT=$?

    if [ $OUT != 0 ]
	then
		echo -e "${RED}************* COMPILATION ERROR!! *************${NC}"
	    return
	fi
	
	# Check if input file exists
	if [ -f "$FILENAME.input" ]
	then
		# Redirect output from input file to the binary and save the output
    	OUTPUT=$(cat $FILENAME.input | $1/a.out)
	else
		echo -e "${RED}**File $1.input not found! Enter input manually **${NC}"
		echo
		# Enter data manually
		OUTPUT=$($1/a.out)
	fi

	# Check if output file exists
	if [ -f "$FILENAME.output" ]
	then
		DIFF=$(diff <(echo "$OUTPUT") "$FILENAME.output")
		OUT=$?
	else
		echo -e "${RED}** $1.output not found!! **${NC}"
		echo -e "${BLUE}************* OUTPUT *************${NC}"
		echo $OUTPUT
		rm $1/a.out
	    return
	fi

	# Check diff status 
	# $OUT == 0, No differences
	# $OUT != 0, Some differences
	if [ $OUT -eq 0 ]
	then
		echo -e "${GREEN}**** ACCEPTED! ****${NC}"
	else
		echo -e "${BLUE}************* OUTPUT *************${NC}"
		echo $OUTPUT
		echo -e "${YELLOW}************** DIFF **************${NC}"
		echo
		echo "${YELLOW_BACKGROUND}$DIFF${NC}"
		echo
		echo -e "${RED}**** WRONG ANSWER! ****${NC}"
	fi

    rm $1/a.out
}

function create {
	mkdir "$1"
	touch "$1/$1.cpp"
	touch "$1/$1.input"
	touch "$1/$1.output"
}

function clean {
	mv $1/$1.cpp .
	rm -rf $1
}
