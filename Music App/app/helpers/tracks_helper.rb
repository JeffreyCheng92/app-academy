module TracksHelper
  def lyric_helper(text)
    lines = text.split("\n")
    lines.map! { |line| "♫ " + line }
    newlines =  "<pre>#{lines.join("\n")}</pre>"
    newlines.html_safe
  end

end
