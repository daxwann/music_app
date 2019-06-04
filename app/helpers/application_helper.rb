module ApplicationHelper
  include ERB::Util

  def auth_token
    "<input type='hidden'
      name='authenticity_token'
      value='#{form_authenticity_token}'>".html_safe
  end

  def ugly_lyrics(lyrics)
    note = "&#9835; "
    formatted_lyrics = ""

    return if lyrics.nil?

    escaped_lyrics = html_escape(lyrics)
    escaped_lyrics.lines.each do |line|
      formatted_lyrics << note + line
    end

    return "<pre>#{formatted_lyrics}</pre>".html_safe
  end
end
