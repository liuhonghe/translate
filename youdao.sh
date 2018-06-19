#! /bin/bash
#
# youdao.sh
#
# Copyright (C) 2016 liuhonghe
# 
# description 参数支持多个单词，句子
#
#
# errorCode：
#　0 - 正常
#　20 - 要翻译的文本过长
#　30 - 无法进行有效的翻译
#　40 - 不支持的语言类型
#　50 - 无效的key
#　60 - 无词典结果，仅在获取词典结果生效
#
#  api限制 每小时1000以内
#
if [ $# -eq 0 ]; then        
    echo "You can run the script like this: fanyi.sh apple"
    exit 1        
fi
keyword=''
for i in $@
do
	keyword="${keyword} $i"
done
jq=`which jq`
# 接口申请已停止
url='http://fanyi.youdao.com/openapi.do?keyfrom=xxxxxxxx&key=xxxxxxxx&type=data&doctype=json&version=1.1'
resJson=`curl -s --data-urlencode "q=${keyword}" ${url}`
errorCode=`echo $resJson | ${jq} ".errorCode"`
if [ $errorCode -ne 0 ];then
echo "${errorCode}：
　0 - 正常
　20 - 要翻译的文本过长
　30 - 无法进行有效的翻译
　40 - 不支持的语言类型
　50 - 无效的key
　60 - 无词典结果，仅在获取词典结果生效"
exit $errorCode
fi
fayin=`echo $resJson | ${jq} ".basic .phonetic" | sed 's/\"//g'`
translation=`echo $resJson | ${jq} ".translation"`
translation=${translation##[}
translation=${translation%%]}
jieshi=`echo $resJson | ${jq} ".basic .explains"`
jieshi=${jieshi##[}
jieshi=${jieshi%%]}

echo 
echo -e "\033[34m $keyword \033[0m"
echo -e "\033[33m /${fayin}/ \033[0m"
echo 
echo -e "\033[34m 翻译结果: \033[0m"
echo -e "\033[31m ${translation} \033[0m"
echo -e "\033[34m 解释: \033[0m"
echo -e "\033[32m ${jieshi} \033[0m"

exit 0
