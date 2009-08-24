module TMail

  class Mail
    def subject_without_re
      return self.subject.gsub( /^\s*re:\s*/i, '' ).strip
    end
    
    def subject_clean_up
      self.subject_without_re.gsub(/ /, "").downcase
    end
    
    def body_clean_up
      body_clean = ''
      
      # get only the plain part
      if self.multipart?
        body_clean = TMail::Mail.extract_plain_content(self)
        
        body_clean = self.body  if body_clean.strip.blank?
      else
        body_clean = self.body
      end
      
      # put away the firm
      body_clean.gsub!( /^-- $.*/m, '' )
      
      # put away the first line before quotes
      body_clean.gsub!( /^[^>].*<.*@.*>.*\n>.*$/, '' )
      
      # put away the quoute lines
      body_clean.gsub!( /^>.*$/, '' )
      
      # put away the mailing list firms
      body_clean.gsub!( /^--~--~---------[-~]*$.*^-~----------~----[-~]*$/m, '' )
      
      # striping
      body_clean.strip!
      
      return body_clean
    end
    
    protected
      def self.extract_plain_content( part )
        result = ''
        
        if part.multipart?
          part.parts.each do |inner_part|
            result += TMail::Mail.extract_plain_content( inner_part )
          end
        else
          result += part.body  if part.content_type =~ /plain/
        end
        
        return result
      end
  end
  
end