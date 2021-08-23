#!/usr/bin/ruby
# -*- coding: UTF-8 -*-
# __author__ xulin

require 'pp'
require 'find'
require_relative 'app_resources_imageset'
require_relative 'app_resources_constant'

module Analysis

  class Analysis
    def initialize
      @imageset = ImageSet.new
      @output_array = Array.new
    end

    def start
      root_path = ARGV.first
      recursion_dir(root_path)
      format_output()
    end

    def recursion_dir(root_path)
      if !File.directory?(root_path)
        return
      end

      Find.find(root_path) do |path|
        if File.file?(path) and !$FILE_TYPE_LIST.include?(File.extname(path)) and filer_path_vaild(path)
          if File.basename(path) != $CONTENTS_JSON
            parent_dir_path = File.dirname(path)
            parent_dir_name = File.split(parent_dir_path).last

            if File.extname(parent_dir_name) == $IMAGESET_TAG
              if @imageset.name != parent_dir_name
                reset(path)
                @imageset.size = File.size(path)
                @imageset.name = parent_dir_name
                @imageset.path = path
              else
                @imageset.size = [@imageset.size, File.size(path)].max
              end
            else
              reset(path)
              size_bit = File.size(path)
              appent_result(path, size_bit)
              $MAX_SIZE += size_bit
            end
          end
        end
      end
    end

    def format_output()
      @output_array = @output_array.sort{|objectA,objectB|objectA.size<=>objectB.size}
      @output_array = @output_array.reverse
      appent_result("共计：", $MAX_SIZE)
      @output_array.each do |object|
        appent_content(object.path, object.size)
      end
    end

    def appent_result(path, size)
      result = ImageSet.new
      result.size = size
      result.path = path
      @output_array.push(result)
    end

    def appent_content(resource_path, resource_size)
      $HTML_CONTENT += "<td style=text-align:left>" + "#{resource_path}" + "</td>"
      $HTML_CONTENT += "<td style=text-align:center>" + "#{format_size(resource_size)}" + "</td>"
      $HTML_CONTENT += "<tr>"
    end

    def reset(path)
      if @imageset.size != 0
        appent_result(@imageset.path, @imageset.size)
        $MAX_SIZE += @imageset.size
        @imageset.reset
      end
    end

    def filer_path_vaild(path)
      if path.include?($LIBCRYPTO) or path.include?($LIBSSL) or path.include?($XCWORKSPACE) or path.include?($GIT) or path.include?($PODS)
        return false
      elsif File.extname(path) == ""
        return false
      else
        return true
      end
    end

    def format_size(size_bit)
      size_byte = size_bit / 1024.0
      if size_byte > 1024
        return "#{format("%.2f", size_byte / 1024)}M"
      else
        return "#{format("%.2f", size_byte)}KB"
      end
    end
  end

  analysis = Analysis.new
  analysis.start

  output_file_path = Dir.pwd + "/XLResourcesAnalysis.html"
  File.open(output_file_path, "w+") do |file|
    file.write($HTML_CONTENT)
  end

end

BEGIN {
   if ARGV.empty?
     puts "exit，argument error！"
     exit
   end
   
   if !File.directory?(ARGV.first)
     puts "exit，argument invalid！"
     exit
   end
   puts "----- start analysis app resources -----"
}

END {
  puts "----- end analysis -----"
}
