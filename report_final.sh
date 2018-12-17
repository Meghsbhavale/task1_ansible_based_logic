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


dest_node=$1
src_node=$2



root_master_compare()
{
DEST=$(cat   $HOME/test/report/final/report_final.csv |grep 'module-name'| tr ',' "\n"| nl | grep "$dest_node"| awk '{print $1}')
SOURCE=$(cat   $HOME/test/report/final/report_final.csv |grep 'module-name'| tr ',' "\n"|nl | grep "$src_node"| awk '{print $1}')

cat $HOME/test/report/final/report_final.csv | grep -v "module-name"|cut -d, -f1,$SOURCE >  $HOME/test/report/final/report_final1.csv
cat $HOME/test/report/final/report_final.csv | grep -v "module-name"|cut -d, -f$DEST >  $HOME/test/report/final/report_final2.csv
paste -d,  $HOME/test/report/final/report_final1.csv  $HOME/test/report/final/report_final2.csv > $HOME/test/report/final/report_finalR.csv
rm -rf $HOME/test/report/final/report_final1.csv  $HOME/test/report/final/report_final2.csv

cat $HOME/test/report/final/report_finalR.csv | grep -v "module-name" |while read line
do
        Name=$(echo $line|cut -d, -f1)
        Ver1=$(echo $line|cut -d, -f2)
        Ver2=$(echo $line|cut -d, -f3)

                if [[ $Ver1 == "-" ]]; then
                        echo "No action to be taken" 2>/dev/null 1>/dev/null
                elif [[ $Ver1 > $Ver2  ]]; then
                        echo "$Name,$Ver1"
                elif [[ "-" == "$Ver2" ]]; then
                        echo "$Name,$Ver1"
                elif [[ $Ver1 < $Ver2  ]]; then
                        echo "No Action to be taken" 2>/dev/null 1>/dev/null
                elif [[ $Ver1 == $Ver2  ]]; then
                        echo "No Action to be taken" 2>/dev/null 1>/dev/null
                else
                        echo "No Action to be taken" 2>/dev/null 1>/dev/null
                fi

done
rm -rf $HOME/test/report/final/report_finalR.csv
}
root_master_compare > $HOME/test/report/final/report_filter.csv

