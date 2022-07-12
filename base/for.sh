#/bin/bash
for i in a b c d
do
  echo 字母:$i
done


for i in {1..10}
do
  echo 数字:$i
done

echo "----------"
for i in {1..10} ;do echo $i; done

echo "----------"
for i in `seq 1 4`;do echo $i;done

echo "----------"

for ((i=1; i<=3; i ++))
do
	echo $i
done

echo "----------"

for i in `ls ~`;do echo $i ; done
