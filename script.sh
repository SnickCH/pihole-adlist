#This script is in work. don't use it at this moment.
#!/bin/bash   
#This script downloads automatically the newest PI-hole tracking list (from a provided URL) and updates gravity

#Variable declaration

#Add the URL you want to use for download
URL1="https://raw.githubusercontent.com/SnickCH/pihole-adlist/main/addlist2.txt"

#Dont change anything that starts from here

#The file that should be safed. You should have mounted the coresponding directory into your container
FILE=/workdir/addlist.list
#A lot of temporary variables that will be used inside the container
TMPLST1=tmpaddlist1.list
#TMPLST2=tmpaddlist2.list
TMP=tmp.list

#Here the script starts

#Download the URL provided (-c= partial download -O = output name)
wget -c $URL1 -O $TMPLST1
#Check if the file already exist. If it exist: we merge both files, sort it, make it uniq (no dublicates), and delete # that aren't used anymore

if [[ -f "$FILE" ]]; then
	echo "file exist"
	#Check what is already in the file and add the missing parts
	sort $FILE $TMPLST1 | uniq >>$TMP
	#Delete all Hashmarks (makes no sense anymore, we sorted the file, so it is at the wrong place)
	sed -i '/#/d' $TMP
	#Delete all whitespaces
	sed -i '/#/d' addlist.list
	#Write the final file
	rm $FILE
	cp $TMP $FILE

#If the file doesn't exist (for what ever reason) we create it
else 
	echo "file doesnt exist"
	#create the file
	cp $TMPLST1 $FILE
fi
