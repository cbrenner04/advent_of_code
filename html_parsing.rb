# frozen_string_literal: true

def update_title(text)
  text.gsub("<h2>", "#").gsub("<h2 id=\"part2\">", "##").gsub("</h2>", "\n\n").gsub("---", "")
end

def update_code_blocks_and_emphases(text)
  text.gsub("<pre><code>", "```text\n").gsub("</code></pre>", "```\n") # handle large code blocks
      .gsub("<code><em>", "**").gsub("</em></code>", "**") # handle emphasized code blocks
      .gsub(%r{</?code>}, "`") # handle rest of code blocks
      .gsub(%r{</?em>}, "**") # handle emphasized text
end

def update_links(string)
  article = string.dup
  link_matches_1 = article.scan(%r{<a target="_blank" href="(.[^>]*)">(.[^<]*)</a>})
  link_matches_1.each do |link, text|
    article.gsub!("<a target=\"_blank\" href=\"#{link}\">#{text}</a>", "[#{text}](#{link})")
  end
  link_matches_2 = article.scan(%r{<a href="(.*)" target="_blank">(.[^<]*)</a>})
  link_matches_2.each do |link, text|
    article.gsub!("<a href=\"#{link}\" target=\"_blank\">#{text}</a>", "[#{text}](#{link})")
  end
  article
end

def update_paragraphs(text)
  text.gsub("<p>", "").gsub("</p>", "\n")
end

def update_unordered_lists(text)
  article = text.dup
  unordered_list_matches = article.scan(%r{<ul>(((?!</ul>).|\n)*)</ul>})
  unordered_list_matches.each do |list, _|
    updated = list.gsub("<li>", "- ").gsub("</li>", "")
    article.gsub!("\n<ul>#{list}</ul>", updated)
  end
  article
end

def update_ordered_lists(text)
  article = text.dup
  ordered_list_matches = article.scan(%r{<ul>(((?!</ul>).|\n)*)</ul>})
  ordered_list_matches.each do |list, _|
    updated = list.gsub("<li>", "1. ").gsub("</li>", "")
    article.gsub!("\n<ul>#{list}</ul>", updated)
  end
  article
end

def update_spans(text)
  text.gsub(/<span ((?!>).)*>/, "").gsub("</span>", "")
end

def parse_html(text)
  articles = text.scan(%r{<article class="((?!>).)*">(((?!<article).|\n)*)</article>})
  articles.map do |_, article, _|
    article = update_title(article)
    article = update_code_blocks_and_emphases(article)
    article = update_links(article)
    article = update_paragraphs(article)
    article = update_unordered_lists(article)
    article = update_ordered_lists(article)
    update_spans(article)
  end.join("")
end
