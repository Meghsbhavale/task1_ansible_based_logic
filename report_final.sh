#!/bin/bash
root_final ()
{

ls report_*|tr "\n" ","|sed "s|report_||g"|sed "s|.csv||g"|sed "s|.$|\n|g"|sed "s|^|module-name,|g"
cat report_dit*| cut -d, -f1|sort| uniq | while read line ; 
do  
        for i in `ls  report_dit*`; 
        do  
                cat $i | grep "$line" 2>/dev/null 1>/dev/null
                if [[ $? -eq 0 ]]; then
                        grep $line $i |cut -d, -f2;
                else
                        echo "-"
                fi
        done|paste -d, - - |sed "s|^|$line,|g" ; 
done
}
cd  $HOME/test/report/
mkdir final 2>/dev/null
root_final > $HOME/test/report/final/report_final.csv
if [[ $? -eq 0 ]]
then
	echo "Final Report file stored at $HOME/test/report/final/report_final.csv"
else
	echo "Process of Final Report file failed."
fi
