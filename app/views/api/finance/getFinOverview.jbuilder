json.general @ow.general do |finance|
  json.name finance.name
  json.cat finance.cat
  json.value finance.value
end
json.years @ow.months do |finance|
  json.name finance.name
  json.cat finance.cat
  json.value finance.value
end