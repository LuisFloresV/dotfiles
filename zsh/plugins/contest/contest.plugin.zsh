# Competitive Programming ZSH Plugin
# me@luisflores.mx
#

function c {

	RED='\e[4;31m'
	GREEN='\e[4;32m'
	BLUE='\e[4;34m'
	NC='\e[0m' # No Color

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
		# Execute and save the output
    	OUTPUT=$(cat $1.input | ./a.out)
	else
		echo -e "${RED}** $1.input not found!! **${NC}"
		rm a.out
	    return
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

	if [ $OUT -eq 0 ]
	then
		echo -e "${GREEN}**** ACCEPTED! ****${NC}"
	    return
	else
		echo -e "${BLUE}************* OUTPUT *************${NC}"
		echo $OUTPUT
		echo -e "${BLUE}************** DIFF **************${NC}"
		echo "$DIFF"
		echo -e "${RED}**** WRONG ANSWER! ****${NC}"
	    return
	fi

    # Remove binary
    rm a.out
}
