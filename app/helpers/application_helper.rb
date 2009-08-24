# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def parse_body_for_metadata(text)
    text = simple_format(text)
    
    urls = URI.extract(text).flatten     
    urls.each do |url|                   
        if url.match("maps.google")
          text.gsub!(url, draw_map(url))
        elsif url.match("www.flickr.com")
          text.gsub!(url, draw_photo(url))
        else
          text.gsub!(url, (UnvlogIt.new(url).embed_html(640, 250) rescue auto_link(url)) )
        end
    end
    
    # # Search for links
    #text = auto_link(text)
    text
  end

  def draw_map(url)
    "<iframe width='650' height='400' frameborder='0' scrolling='no'
             marginheight='0' marginwidth='0' src='#{url}&output=embed'
             style='color:#0000FF;text-align:left' id='google_map'>
    </iframe>
    <br />
    <small>
     <a href='#{url}' style='color:#0000FF;text-align:left'>View Larger Map</a>
    </small>"
  end
  
  def draw_photo(url)
    doc = Hpricot( open(url) )
    element = doc.at("#Photo img")
    "#{element['alt']}" + "#{image_tag element['src'], :alt => element['alt']}"
    
  end
  
  def question_name_or_mail
    return @question.owner_mail.hide_at  if @question.owner_name =~ /ISO-8859-1/
    
    @question.owner_name.blank? ? @question.owner_mail.hide_at : @question.owner_name
  end

  def answer_name_or_mail(answer)
    return answer.mail.hide_at  if answer.name =~ /ISO-8859-1/
    
    answer.name.blank? ? answer.mail.hide_at : answer.name
  end
  
  def aditional_vote_class(answer)
    classes = String.new
    classes << (answer.plus? ? "lcol ": "rcol ")
    classes << "novalid " if answer.has_expired?
    return classes    
  end
  
  def bot_talking_random_web( requested_by )
  end
  
end
