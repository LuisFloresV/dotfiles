# Competitive Programming ZSH Plugin
# me@luisflores.mx
#

RED='\e[4;31m'
GREEN='\e[4;32m'
BLUE='\e[4;34m'
NC='\e[0m' # No Color

function c {
	FILE="$1.cpp"

	echo $FILE

    # Compile with c++11 flag
    c++ -std=c++11 "$FILE"
    # Save return status
    OUT=$?

    if [ $OUT != 0 ]
	then
		echo -e "${RED}************* COMPILATION ERROR!! *************${NC}"
	    return
	fi
	
	# Check if input file exists
	if [ -f "$1.input" ]
	then
		# Redirect output from input file to the binary and save the output
    	OUTPUT=$(cat $1.input | ./a.out)
	else
		echo -e "${RED}**File $1.input not found! Enter input manually **${NC}"
		echo
		# Enter data manually
		OUTPUT=$(./a.out)
	fi

	# Check if output file exists
	if [ -f "$1.output" ]
	then
		DIFF=$(diff <(echo "$OUTPUT") "$1.output")
		OUT=$?
	else
		echo -e "${RED}** $1.output not found!! **${NC}"
		echo -e "${BLUE}************* OUTPUT *************${NC}"
		echo $OUTPUT
		rm a.out
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
		echo -e "${RED}************** DIFF **************${NC}"
		echo "$DIFF"
		echo -e "${RED}**** WRONG ANSWER! ****${NC}"
	fi

    rm a.out
}

function create {
	mkdir "$1"
	touch "$1/$1.cpp"
	touch "$1/$1.input"
	touch "$1/$1.output"
}
