#/bin/bash

echo hello; echo there

filename='demo2'

if [ -x "$filename" ]; then    # 注意："if" and "then"需要分隔符
                               # 思考一下这是为什么?
  echo "File $filename exists."; cp $filename $filename.bak
else
  echo "File $filename not found."; touch $filename
fi; echo "File test complete."