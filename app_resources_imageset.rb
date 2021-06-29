#!/usr/bin/ruby
# -*- coding: UTF-8 -*-
# __author__ xulin
#

class ImageSet
    attr_accessor :name, :size, :path
    def initialize
        reset
    end

    def reset
        @name = ""
        @size = 0
        @path = ""
    end
end
