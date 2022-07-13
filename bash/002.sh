#/bin/bash
echo "命令的作用是在屏幕输出一行文本可以将该命令的参数原样输出"

#echo输出的文本末尾会有一个回车符。-n参数可以取消末尾的回车符
echo -n hello world

echo

echo a;echo b

echo -n a;echo b
echo "----------"
#-e参数 -e参数会解释引号（双引号和单引号）里面的特殊字符（比如换行符\n）。如果不使用-e参数，
# 即默认情况下，引号会让特殊字符变成普通字符，echo不解释它们，原样输出。

echo "Hello\nWorld"

echo -e "Hello\nWorld"

echo -e 'Hello\nWorld'

#命令格式  command [ arg1 ... [ argN ]]
#如 ls -l
echo foo bar
#等同于
echo foo \
bar


echo "-----------"
#Bash 使用空格（或 Tab 键）区分不同的参数。 $ command foo bar
#如果参数之间有多个空格，Bash 会自动忽略多余的空格。
echo this is a     test

echo "------------"
#分号（;）是命令的结束符，使得一行可以放置多个命令，上一个命令执行结束后，再执行第二个命令。

echo "-------------"
#Bash 还提供两个命令组合符&&和||，允许更好地控制多个命令之间的继发关系。
#Command1 && Command2
#Command1 || Command2

#只要cat命令执行结束，不管成功或失败，都会继续执行ls命令
cat filelist.txt ; ls -l filelist.txt

#只有cat命令执行成功，才会继续执行ls命令。如果cat执行失败（比如不存在文件flielist.txt），那么ls命令就不会执行
cat filelist.txt && ls -l filelist.txt

#只有mkdir foo命令执行失败（比如foo目录已经存在），才会继续执行mkdir bar命令。如果mkdir foo命令执行成功，就不会创建bar目录了
#mkdir foo || mkdir bar

echo "-------------"
#type命令用来判断命令的来源
type echo
type ls
type type

#如果要查看一个命令的所有定义，可以使用type命令的-a参数。
type -a echo

#type命令的-t参数，可以返回一个命令的类型：别名（alias），关键词（keyword），函数（function），内置命令（builtin）和文件（file）。
type -t bash
type -t if

#快捷键
#Ctrl + L：清除屏幕并将当前行移到页面顶部。
#Ctrl + C：中止当前正在执行的命令。
#Shift + PageUp：向上滚动。
#Shift + PageDown：向下滚动。
#Ctrl + U：从光标位置删除到行首。
#Ctrl + K：从光标位置删除到行尾。
#Ctrl + W：删除光标位置前一个单词。
#Ctrl + D：关闭 Shell 会话。
#↑，↓：浏览已执行命令的历史记录。
#除了上面的快捷键，Bash 还具有自动补全功能。命令输入到一半的时候，可以按下 Tab 键，Bash 会自动完成剩下的部分。比如，输入tou，然后按一下 Tab 键，Bash 会自动补上ch。
#除了命令的自动补全，Bash 还支持路径的自动补全。有时，需要输入很长的路径，这时只需要输入前面的部分，然后按下 Tab 键，就会自动补全后面的部分。如果有多个可能的选择，按两次 Tab 键，Bash 会显示所有选项，让你选择
