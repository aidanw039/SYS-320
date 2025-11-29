#! /bin/bash
clear

# filling courses.txt
bash courses.sh

courseFile="courses.txt"

function displayCoursesofInst(){

echo -n "Please Input an Instructor Full Name: "
read instName

echo ""
echo "Courses of $instName :"
cat "$courseFile" | grep "$instName" | cut -d';' -f1,2 | \
sed 's/;/ | /g'
echo ""

}

function courseCountofInsts(){

echo ""
echo "Course-Instructor Distribution"
cat "$courseFile" | cut -d';' -f7 | \
grep -v "/" | grep -v "\.\.\." | \
sort -n | uniq -c | sort -n -r 
echo ""

}

# TODO - 1
# Make a function that displays all the courses in given location
# function dislaplays course code, course name, course days, time, instructor
# Add function to the menu
# Example input: JOYC 310
# Example output: See the screenshots in canvas

function displayCoursesofLoc() {
echo -n "Please Input an location: "
read locName
echo ""
echo "Courses located at $locName: "
cat "$courseFile" | grep "$locName" |    cut -d';' -f1,2 | sed 's/;/ | /g' 
echo ""

}


# TODO - 2
# Make a function that displays all the courses that has availability
# (seat number will be more than 0) for the given course code
# Add function to the menu
# Example input: SEC
# Example output: See the screenshots in canvas

function showAvailableCourses() {
echo -n "Please Input A subject Name: "
read subName
echo ""
echo "Courses in $subName with available seats"
cat "$courseFile" | grep "$subName" | awk -F";"  '{ if ( $4 < 1 ){print $0 > /dev/null} else { print  "ID: " $1  " | Name:  " $2 " | Seats available: " $4 } }' 

} 
showAvailableCourses
exit;

while :
do
        echo ""
        echo "Please select and option:"
        echo "[1] Display courses of an instructor"
        echo "[2] Display course count of instructors"
	echo "[3] Display courses of a location"
	echo "[4] Display available courses for subject"
	echo "[5] Exit"

        read userInput
        echo ""

        if [[ "$userInput" == "5" ]]; then
                echo "Goodbye"
                break

        elif [[ "$userInput" == "1" ]]; then
                displayCoursesofInst
        elif [[ "$userInput" == "2" ]]; then
                courseCountofInsts
	elif [[ "$userInput" == "3" ]]; then
		displayCoursesofLoc
	elif [[ "$userInput" == "4" ]]; then
		showAvailableCourses
	else	
		echo "please give valid input"
        # TODO - 3 Display a message, if an invalid input is given
        fi
	echo "press enter to start again"
	read
	clear
done
