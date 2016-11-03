# translate
**shell翻译脚本**

> 利用有道翻译与百度翻译api

1. 有道api:限制每小时1000次以内
2. 百度api:当月翻译字符数≤2百万

*脚本需要curl和[jq](https://stedolan.github.io/jq/)命令解析json*

参数支持多个单词，语句

usage：

```
./script.sh keyword1 keyword2 paragraph1 paragraph2
./script.sh "keyword1 keyword2 paragraph1 paragraph2"
```

原本是没有多少情怀的，但，当发现不愿为某个所改变的时候，那就是情怀，浓浓的黑窗口
