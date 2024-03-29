#/bin/bash

#Bash 是先进行扩展，再执行命令。因此，扩展的结果是由 Bash 负责的，与所要执行的命令无关。命令本身并不存在参数扩展，收到什么参数就原样执行。这一点务必需要记住。

#模式扩展早于正则表达式出现，可以看作是原始的正则表达式。它的功能没有正则那么强大灵活，但是优点是简单和方便

#Bash 允许用户关闭扩展。
#$ set -o noglob
# 或者
#$ set -f

#下面的命令可以重新打开扩展。
#$ set +o noglob
# 或者
#$ set +f



#波浪线扩展
#波浪线~会自动扩展成当前用户的主目录。
echo ~

#~/dir表示扩展成主目录的某个子目录，dir是主目录里面的一个子目录名。

#~user表示扩展成用户user的主目录。
echo ~me
#如果~user的user是不存在的用户名，则波浪号扩展不起作用。
#echo ~xxx

#~+会扩展成当前所在的目录，等同于pwd命令。
echo ~+


#? 字符扩展
#?字符代表文件路径里面的任意单个字符，不包括空字符。比如，Data???匹配所有Data后面跟着三个字符的文件名。
ls  00?.sh

#如果匹配多个字符，就需要多个?连用。
ls ???.sh

#? 字符扩展属于文件名扩展，只有文件确实存在的前提下，才会发生扩展。如果文件不存在，扩展就不会发生。
#echo ?.txt

#如果?.txt可以扩展成文件名，echo命令会输出扩展后的结果；如果不能扩展成文件名，echo就会原样输出?.txt



#* 字符扩展
#*字符代表文件路径里面的任意数量的任意字符，包括零个字符。
ls *.sh

#显示所有隐藏文件
#echo .*

#如果要匹配隐藏文件，同时要排除.和..这两个特殊的隐藏文件，可以与方括号扩展结合使用，写成.[!.]*
#echo .[!.]*

#*字符扩展属于文件名扩展，只有文件确实存在的前提下才会扩展。如果文件不存在，就会原样输出
#当前目录不存在 c 开头的文件,导致c*.txt会原样输出
# echo c*.txt

#文本文件在子目录，*.txt不会产生匹配，必须写成*/*.txt。有几层子目录，就必须写几层星号。
# 匹配子目录
#ls */*.txt

#Bash 4.0 引入了一个参数globstar，当该参数打开时，允许**匹配零个或多个子目录。因此，**/*.txt可以匹配顶层的文本文件和任意深度子目录的文本文件。详细介绍请看后面shopt命令的介绍



#方括号扩展
#方括号扩展的形式是[...]，只有文件确实存在的前提下才会扩展。如果文件不存在，就会原样输出。括号之中的任意一个字符。
# 比如，[aeiou]可以匹配五个元音字母中的任意一个。

#不存在文件 a.txt 和 b.txt
#$ ls [ab].txt
#ls: 无法访问'[ab].txt': 没有那个文件或目录

#方括号扩展还有两种变体：[^...]和[!...]。它们表示匹配不在方括号里面的字符，这两种写法是等价的。
# 比如，[^abc]或[!abc]表示匹配除了a、b、c以外的字符。



#[start-end] 扩展
#方括号扩展有一个简写形式[start-end]，表示匹配一个连续的范围。比如，[a-c]等同于[abc]，[0-9]匹配[0123456789]。
ls 00[1-5].sh

#下面是一些常用简写的例子。

# [a-z]：所有小写字母。
# [a-zA-Z]：所有小写字母与大写字母。
# [a-zA-Z0-9]：所有小写字母、大写字母与数字。
# [abc]*：所有以a、b、c字符之一开头的文件名。
# program.[co]：文件program.c与文件program.o。
# BACKUP.[0-9][0-9][0-9]：所有以BACKUP.开头，后面是三个数字的文件名。
# 这种简写形式有一个否定形式[!start-end]，表示匹配不属于这个范围的字符。比如，[!a-zA-Z]表示匹配非英文字母的字符。

ls 00[!1-2].sh



#大括号扩展
#大括号扩展{...}表示分别扩展成大括号里面的所有值，各个值之间使用逗号分隔。比如，{1,2,3}扩展成1 2 3。
 echo {1,2,3}

 echo d{a,e,i,u,o}g

 echo Front-{A,B,C}-Back

#大括号扩展不是文件名扩展。它会扩展成所有给定的值，而不管是否有对应的文件存在。
#ls {a,b,c}.txt
#即使不存在对应的文件，{a,b,c}依然扩展成三个文件名，导致ls命令报了三个错误。

#另一个需要注意的地方是，大括号内部的逗号前后不能有空格。否则，大括号扩展会失效。
#echo {1 , 2}

#逗号前面可以没有值，表示扩展的第一项为空。
# cp a.log{,.bak} 等同于  cp a.log a.log.bak

#大括号可以嵌套。
echo {j{p,pe}g,png}
echo a{A{1,2},B{3,4}}b


#{start..end} 扩展
#大括号扩展有一个简写形式{start..end}，表示扩展成一个连续序列。比如，{a..z}可以扩展成26个小写英文字母。

echo {1..10}
for i in  {1..10}; do echo $i;done

echo {a..c}
echo {g..a}

#如果遇到无法理解的简写，大括号模式就会原样输出，不会扩展。
echo {a1..3c}

#简写形式可以嵌套使用，形成复杂的扩展
echo .{mp{3..4},m4{a,b,p,v}}

#大括号扩展的常见用途为新建一系列目录。
#mkdir {2007..2009}-{01..12}
#上面命令会新建36个子目录，每个子目录的名字都是”年份-月份“。

#这个写法的另一个常见用途，是直接用于for循环。
for i in {1..4}
do
  echo $i
done

echo {01..5}


#简写形式还可以使用第二个双点号（start..end..step），用来指定扩展的步长。
echo {1..10..2}

#多个简写形式连用，会有循环处理的效果。
#
#$ echo {a..c}{1..3}


#变量扩展
echo $SHELL
echo ${SHELL}


#子命令扩展
echo $(date)
echo `date`



#字符类
#[[:class:]]表示一个字符类，扩展成某一类特定字符之中的一个。常用的字符类如下。
#
#[[:alnum:]]：匹配任意英文字母与数字
#[[:alpha:]]：匹配任意英文字母
#[[:blank:]]：空格和 Tab 键。
#[[:cntrl:]]：ASCII 码 0-31 的不可打印字符。
#[[:digit:]]：匹配任意数字 0-9。
#[[:graph:]]：A-Z、a-z、0-9 和标点符号。
#[[:lower:]]：匹配任意小写字母 a-z。
#[[:print:]]：ASCII 码 32-127 的可打印字符。
#[[:punct:]]：标点符号（除了 A-Z、a-z、0-9 的可打印字符）。
#[[:space:]]：空格、Tab、LF（10）、VT（11）、FF（12）、CR（13）。
#[[:upper:]]：匹配任意大写字母 A-Z。
#[[:xdigit:]]：16进制字符（A-F、a-f、0-9）。



#量词语法
#量词语法用来控制模式匹配的次数。它只有在 Bash 的extglob参数打开的情况下才能使用，不过一般是默认打开的。下面的命令可以查询。
# shopt extglob

#如果extglob参数是关闭的，可以用下面的命令打开。
#shopt -s extglob

#shopt 命令
#shopt命令可以调整 Bash 的行为。它有好几个参数跟通配符扩展有关。
#
#shopt命令的使用方法如下
# 打开某个参数
$ shopt -s [optionname]

# 关闭某个参数
$ shopt -u [optionname]

# 查询某个参数关闭还是打开
$ shopt [optionname]





#shopt 命令




