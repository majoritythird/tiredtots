Factory.define :sleep_block do |f|
  f.start 3.hours.ago
  f.finish  1.hour.ago
end
