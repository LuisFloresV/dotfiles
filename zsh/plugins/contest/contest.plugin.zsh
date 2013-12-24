# Competitive Programming ZSH Plugin
# me@luisflores.mx
#

## CONFIGURATION ##
TEMPLATE=true
TEMPLATE_PATH="/Users/Luis/Developer/Competitive-Programming/template.cpp"
###################

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

function c {
	FILE_PATH="$1/$1"

	# Check if source file exists
	if [ -f "$FILE_PATH.cpp" ]; then
		# Compile with c++11 flag
	    c++ -std=c++11 $FILE_PATH.cpp -o $FILE_PATH.out -Wall -DJUDGE
	    
	    # Check return status
    	if [ $? != 0 ]; then
			echo "${RED}*** COMPILATION ERROR!! ***${NC}"
	    	return
		fi
	else
		echo "${RED}** $1.cpp not found!! **${NC}"
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
	mkdir "$1"
	STATEMENT="Create folder $1"
	printPad $STATEMENT

	touch "$1/$1.input"
	STATEMENT="Create file $1/$1.input"
	printPad $STATEMENT

	touch "$1/$1.output"
	STATEMENT="Create file $1/$1.output"
	printPad $STATEMENT

	if [ $TEMPLATE ]; then
		if [ -f $TEMPLATE_PATH ]; then
			cp $TEMPLATE_PATH $1/$1.cpp
			STATEMENT="Copy template file"
			printPad $STATEMENT
		else
			STATEMENT="Copy template file"
			printPad $STATEMENT "${RED}NO${NC}"
			touch "$1/$1.cpp"
			STATEMENT="Create file $1/$1.cpp"
			printPad $STATEMENT
			echo
			echo "${YELLOW}** Template file not found, please check template file path **${NC}"
		fi
	else
		touch "$1/$1.cpp"
		STATEMENT="Create file $1/$1.cpp"
		printPad $STATEMENT
	fi
}

function clean {
	mv $1/$1.cpp .
	rm -rf $1
}

# Helper methods

function printPad() {
	if [ -z "$2" ]; then
		if [ $? = 0 ]; then
			STATUS="${GREEN}OK${NC}"
		else
			STATUS="${RED}NO${NC}"
		fi
	else
		STATUS=$2
	fi

	PAD=$(printf '%0.1s' "."{1..80})
	PADLENGTH=80
	printf "${WHITE} %s %*.*s ${NC}[ %b ]\n" "$1" 0 $((PADLENGTH - ${#1} - ${#STATUS} )) "$PAD" "$STATUS"
}
