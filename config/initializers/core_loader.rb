Dir.glob("#{RAILS_ROOT}/lib/core/*.{rb}").each do |file|
  require "#{file}"
end
