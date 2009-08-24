class String
  def hide_at
    self.gsub('@', ' on ')
  end
end