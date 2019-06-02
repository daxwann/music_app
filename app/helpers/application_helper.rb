module ApplicationHelper
  include ERB::Util

  def auth_token
    "<input type='hidden'
      name='authenticity_token'
      value='#{form_authenticity_token}'>".html_safe
  end

  def ugly_lyrics(lyrics)
    note = "&#9835; "
    uglified = "<pre>"

    return if lyrics.nil?

    escaped_lyrics = html_escape(lyrics)
    uglified += note
    escaped_lyrics.each_char do |char|
      unless char == "\n"
        uglified += char
      else
        uglified += "</pre>\n<pre>"
        uglified += note
      end
    end
    uglified += "<\pre>"

    return uglified.html_safe
  end
end
