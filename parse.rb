#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'yaml'

lbcf = {}

basepath = 'https://www.ccel.org/creeds/bcf/'
main_page = 'bcf.htm'

page = Nokogiri::HTML(open("#{basepath}#{main_page}"))

links = page.css('a[href*="bcfc"]')

links.each do |link|
  url = "#{basepath}#{link['href']}"
  page = Nokogiri::HTML(open(url))

  chapter = page.css('a[name*="chapter"]').attr('name').to_s.gsub('chapter', '')
  title = page.css('h1,h2').text.gsub('.', '')

  lbcf[chapter] = {title: title, paragraphs: {}}

  page.css("a[name*='c#{chapter}']").each do |node|
    paragraph = node.attr('name').gsub("c#{chapter}.", '')
    content = node.parent

    lbcf[chapter][:paragraphs][paragraph] = []

    references = content.css('a[href*="scric"]')

    content.children.each do |child|

      if child.element? && child.css('a').any? && child.css('a').attr('href')

        ref_url = child.css('a').attr('href')
        ref_verses = page.css("a[href='#{ref_url}']").last

        ref_verses.css('i').remove
        verses = ref_verses.text.to_s.gsub("\r\n", ' ').strip

        child = "<span class=\"ref\">#{verses}</span>"

      elsif child.text?
        child = child.text.to_s.gsub("#{paragraph}.", '')
      else
        next
      end

      lbcf[chapter][:paragraphs][paragraph] << child.to_s.gsub("\r\n", ' ').rstrip
    end
  end
end

puts lbcf.to_yaml
