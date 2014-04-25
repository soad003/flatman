json.array!(@f) do |json, finance|
  json.name finance.name
  json.cat finance.cat
  json.value finance.value
end