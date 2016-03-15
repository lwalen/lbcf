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
  title = page.css('h1,h2').text.gsub('.', '').gsub("\r\n", ' ')

  lbcf[chapter] = {title: title, paragraphs: {}}

  page.css("a[name*='c#{chapter}']").each do |node|
    paragraph = node.attr('name').gsub("c#{chapter}.", '')
    content = node.parent

    lbcf[chapter][:paragraphs][paragraph] = []

    references = content.css('a[href*="scric"]')

    content.children.each_with_index do |child, index|

      if child.element? && child.css('a').any? && child.css('a').attr('href')


        ref_url = child.css('a').attr('href')
        ref_verses = page.css("a[href='#{ref_url}']").last

        ref_verses.css('i').remove
        verses = ref_verses.text.to_s.gsub("\r\n", ' ').strip

        lbcf[chapter][:paragraphs][paragraph][index - 1] = "<span class=\"ref\" data-verses=\"#{verses}\">#{lbcf[chapter][:paragraphs][paragraph][index - 1]}"
        child = "</span>"

      elsif child.text?
        child = child.text.to_s.gsub("#{paragraph}.", '')
      elsif child.text
        child = child.text
      end

      lbcf[chapter][:paragraphs][paragraph] << child.to_s.gsub("\r\n", ' ')
    end
  end
end

puts <<-EOS
<html>
<head>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
	<script src="/annotate.js"></script>
	<link href='https://fonts.googleapis.com/css?family=Martel:300' rel='stylesheet' type='text/css'>
	<link href='/style.css' rel='stylesheet' type='text/css'>
</head>
<body>
	<div class="main">
		<h1>London Baptist Confession of Faith (1689)</h1>
EOS

lbcf.each do |chapter, content|
  puts "\t\t<section>"
  puts "\t\t\t<h3 id=\"chapter-#{chapter}\">Chapter #{chapter}</h3>"
  puts "\t\t\t<h2>#{content[:title]}</h2>"
  content[:paragraphs].each do |p_number, p_contents|
    puts "\t\t\t<p>"
    puts "\t\t\t\t#{p_contents.join.strip.gsub('&', '&amp;')}"
    puts "\t\t\t</p>"
  end
  puts "\t\t</section>"
end

puts <<-EOS
	</div>

	<div class="side">
		lots of stuff goes here
	</div>
</body>
</html>
EOS
