# XLAppResourcesAnalysis
分析APP安装包内的资源文件大小脚本

# 用法：
参数1: 目标项目根目录

# 示例
cd XLAppResourcesAnalysis

Ruby  app_resources_analysis.rb  参数1 

----- start analysis app resources -----

----- end analysis -----

[Tips:处理结束之后，结果以html报表形式展示，查看路径是当ruby脚本所在的同级目录中

# 如何获取LinkMap文件

1、针对主工程配置打开LinkMap开关：Xcode->Project->Build Settings-> Search map -> 设置 Write Link Map Files 选项为YES（release、debug区分配置）

2、编译之后会在指定路径生成LinkMap文件产物，默认是在/Users/xiaoyiqingifelse/Library/Developer/Xcode/DerivedData/xxx-cnwlggeskzjwiyejtomaplxmpnbd/Build/Intermediates.noindex/xxx.build/Debug-iphonesimulator/xxx.build/xxx-LinkMap-normal-x86_64.txt
