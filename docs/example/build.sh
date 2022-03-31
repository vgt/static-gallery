cd $1
echo $PWD
TARGET="index.html"
mapfile -t IDS < photos/ids
TITLE=$(cat photos/title)
cat index_header.part | sed "s/___TITLE___/$TITLE/g" > $TARGET

for (( i = 0; i < ${#IDS[@]}; ++ i))
do
  ID=${IDS[$i]}
  echo $ID
  convert photos/$ID -auto-orient -thumbnail 400x400 photos/thumb_$ID 
  convert photos/thumb_$ID -auto-orient -thumbnail 1x1 photos/tint_$ID 
  cat index_item.part | sed "s/___NR___/${IDS[$i]}/g" | sed "s/___NR_PREV___/${IDS[$i-1]}/g" | sed "s/___NR_NEXT___/${IDS[$i+1]}/g" | sed "s/___TITLE___/$TITLE/g" >> $TARGET
done

cat index_trailer.part >> $TARGET
