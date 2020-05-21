/opt/karaf/bin/karaf run & 
sleep 93
/opt/karaf/bin/client -r 93  "shell:sleep 13;"
sleep 13
/opt/karaf/bin/client -r 3  -l 2 -u karaf -p karaf "shutdown -f;" 
sleep 33 
