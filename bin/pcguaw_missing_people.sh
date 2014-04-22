for person in $(cat /tmp/personid_uaw_missing_sorted.txt);
do
 echo "PERSON $person"
 grep -c  $person /tmp/uawpersonid.txt
done
