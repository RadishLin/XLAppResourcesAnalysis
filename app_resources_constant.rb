#!/usr/bin/ruby
# -*- coding: UTF-8 -*-
# __author__ xulin

$MAX_SIZE = 0
$FILE_TYPE_LIST = %w[.h .m .swift .pch .xib .c .md .pbxproj]
$LIBCRYPTO      = "libcrypto.a"
$LIBSSL         = "libssl.a"
$XCWORKSPACE    = ".xcworkspace"
$GIT            = ".git"
$IMAGESET_TAG   = ".imageset"
$CONTENTS_JSON  = "Contents.json"
$HTML_CONTENT   = "<h2 align=center>iOS Resources Analysis 数据</h2>" \
               "<table border='1px solid' " \
               "style='border-collapse:collapse;table-layout:fixed;word-break:break-all;width: 80%;margin: 0 auto;'>" \
               "<th style='width: 80%'>资源</th>" \
               "<th>大小</th>" \
               "<tr>"
