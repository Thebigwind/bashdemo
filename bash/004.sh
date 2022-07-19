#/bin/bash

#引号和转义
#某些字符在 Bash 里面有特殊含义（比如$、&、*）
echo $date
#上面例子中，输出$date不会有任何结果，因为$是一个特殊字符。

#如果想要原样输出这些特殊字符，就必须在它们前面加上反斜杠，使其变成普通字符。这就叫做“转义”
echo \$date

#反斜杠本身也是特殊字符，如果想要原样输出反斜杠，就需要对它自身转义，连续使用两个反斜线（\\）
echo \\

#反斜杠除了用于转义，还可以表示一些不可打印的字符。
#\a：响铃
#\b：退格
#\n：换行
#\r：回车
#\t：制表符

#如果想要在命令行使用这些不可打印的字符，可以把它们放在引号里面，然后使用echo命令的-e参数
echo a\tb   #atb
echo  -e "a\tb" #a    b


#换行符是一个特殊字符，表示命令的结束，Bash 收到这个字符以后，就会对输入的命令进行解释执行。换行符前面加上反斜杠转义，就使得换行符变成一个普通字符，Bash 会将其当作长度为0的空字符处理，从而可以将一行命令写成多行。

#mv \
#/path/to/foo \
#/path/to/bar
#
##等同于
#$ mv /path/to/foo /path/to/bar

echo "---------------------------"
#单引号
#单引号用于保留字符的字面含义，各种特殊字符在单引号里面，都会变为普通字符，比如星号（*）、美元符号（$）、反斜杠（\）等
#单引号使得 Bash 扩展、变量引用、算术运算和子命令，都失效了。如果不使用单引号，它们都会被 Bash 自动扩展。
echo '*'
echo '$USER'
echo '$((2+2))'
echo '$(echo foo)'

#更合理的方法是改在双引号之中使用单引号
echo "it's a girl"

#双引号
#双引号比单引号宽松，大部分特殊字符在双引号里面，都会失去特殊含义，变成普通字符。
echo "*"

#三个特殊字符除外：美元符号（$）、反引号（`）和反斜杠（\）。这三个字符在双引号之中，依然有特殊含义，会被 Bash 自动扩展
echo "$SHELL"
echo "`date`"

#换行符在双引号之中，会失去特殊含义，Bash 不再将其解释为命令的结束，只是作为普通的换行符。所以可以利用双引号，在命令行输入多行文本。
echo "hello
world
world
"

#双引号的另一个常见的使用场合是，文件名包含空格。这时就必须使用双引号（或单引号），将文件名放在里面

#双引号还有一个作用，就是保存原始命令的输出格式。
echo $(cal)

#原始格式输出
echo "$(cal)"


echo "--------------------------------"
#Here 文档
#Here 文档（here document）是一种输入多行字符串的方法，格式如下。
#它的格式分成开始标记（<< token）和结束标记（token）
#开始标记是两个小于号 + Here 文档的名称，名称可以随意取，后面必须是一个换行符；结束标记是单独一行顶格写的 Here 文档名称，如果不是顶格，结束标记不起作用。两者之间就是多行字符串的内容。

<< token
text
token

cat << _EOF_
<html>
<head>
    <title>
    The title of your page
    </title>
</head>

<body>
    Your page content goes here.
</body>
</html>
_EOF_

#Here 文档内部会发生变量替换，同时支持反斜杠转义，但是不支持通配符扩展，双引号和单引号也失去语法作用，变成了普通字符
foo='hello world'
cat << _example_
$foo
"$foo"
'$foo'
_example_

#如果不希望发生变量替换，可以把 Here 文档的开始标记放在单引号之中
cat << '_example_'
$foo
"$foo"
'$foo'
_example_

#Here 文档的本质是重定向，它将字符串重定向输出给某个命令，相当于包含了echo命令。
#$ command << token
#  string
#token
#
## 等同于
#
#$ echo string | command


echo "--------------------------------"
#Here 字符串
#Here 文档还有一个变体，叫做 Here 字符串（Here string），使用三个小于号（<<<）表示
#它的作用是将字符串通过标准输入，传递给命令

#有些命令直接接受给定的参数，与通过标准输入接受参数，结果是不一样的。所以才有了这个语法，使得将字符串通过标准输入传递给命令更方便
cat <<< 'hi there'
#等同于
echo 'hi there' | cat


md5sum <<< 'ddd'
## 等同于
echo 'ddd' | md5sum

