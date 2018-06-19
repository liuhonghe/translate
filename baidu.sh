#! /bin/bash
#
# baidu.sh
#
# Copyright (C) 2016 liuhonghe
# 
# description 参数支持多个单词，句子
# 根据官网 http://api.fanyi.baidu.com/api/trans/product/apidoc 的说明
# "源语言语种不确定时可设置为 auto，目标语言语种不可设置为 auto。"
# 但实际应用中，是自动转换的，与to参数没什么关系
#
# api限制 当月翻译字符数≤2百万
#

if [ $# -eq 0 ]; then        
    echo "You can run the script like this: baidu.sh apple"
    exit 1        
fi

keyword=''
for i in $@
do
	keyword="${keyword} $i"
done

jq=`which jq`
apiUrl='http://api.fanyi.baidu.com/api/trans/vip/translate'
q=${keyword}
from='auto'
to='en' #中文为zh
# http://api.fanyi.baidu.com/api/trans/product/desktop?req=developer
appid='xxxxxxxxxxx'
salt=`date +%s`
secret='xxxxxxxxxxxxxxxxxxxx'
pinJie=${appid}${q}${salt}${secret}
sign=`echo -n ${pinJie} | md5sum | cut -d ' ' -f1`
fullUrl="${apiUrl}?from=${from}&to=${to}&appid=${appid}&salt=${salt}&sign=${sign}"
translation=`curl -s --data-urlencode "q=${q}" "${fullUrl}"`
fanyi=`echo ${translation} | ${jq} ".trans_result[] .dst"`

echo
echo -e "\033[34m $keyword \033[0m"
echo
echo -e "\033[31m ${fanyi} \033[0m"
echo
