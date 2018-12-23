#!/bin/bash 
 
echo "ok" 
 
#I thought it might be cool to move the preview.html and stuff to another box to have it converted rightly 
 
#echo "1 remove stuff.html " 
#rm stuff.html 
 
echo "2 remove preview.pdf locally" 
rm preview.pdf 
 
#echo "4 repair the stuff.html" 
#sed -ie 's/F8F8F8/E2E2E2 !important/g' stuff.html 
#sed -ie 's/monospace;/monospace; background-color: #fcf9ee !important/g' stuff.html 
 
 
#echo "5 remote delete the stuff.pdf" 
#rm /mnt/apollo/stuff.pdf 
#rm /mnt/apollo/stuff.html 
#rm /mnt/apollo/update.js 
#rm /mnt/apollo/settext.js 
#rm -rf /mnt/apollo/figure 
 
echo "Nuke the directory and mkdir it" 
ssh 192.168.13.83 -p 10222 'rm -rf /tmp/htmltopdfconversion; mkdir -p /tmp/htmltopdfconversion' 
 
 
python /home/el/bin/file_mover/main.py defiant rosewill /home/el/.vim/mdpreview/preview.html /tmp/htmltopdfconversion/preview.html 
python /home/el/bin/file_mover/main.py defiant rosewill /home/el/.vim/mdpreview/update.js /tmp/htmltopdfconversion/update.js 
python /home/el/bin/file_mover/main.py defiant rosewill /home/el/.vim/mdpreview/settext.js /tmp/htmltopdfconversion/settext.js 
python /home/el/bin/file_mover/main.py defiant rosewill /home/el/.vim/mdpreview/style.css /tmp/htmltopdfconversion/style.css 
 
#Move the images assets and figures 
#cp -r ./figure /mnt/apollo 
 
echo "7 remote run wkhtmltopdf " 
 
#INSTALL: rosewill fedora:  sudo yum -y install xorg-x11-server-Xvfb 
#Do all your work in /tmp and it's good to go.  anywhere else on disk with xvfb-run jails its member who needs webkit stuffs 
 
ssh 192.168.13.83 -p 10222 '/usr/bin/xvfb-run --server-args="-screen 0, 1024x768x24" wkhtmltopdf -O portrait --window-status ready_to_print /tmp/htmltopdfconversion/preview.html /tmp/htmltopdfconversion/preview.pdf;' 
 
sleep 1s 
 
python /home/el/bin/file_mover/main.py rosewill defiant /tmp/htmltopdfconversion/preview.pdf /home/el/.vim/mdpreview/preview.pdf 
 
evince /home/el/.vim/mdpreview/preview.pdf 
