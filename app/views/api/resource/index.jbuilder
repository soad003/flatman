json.array!(@r) do |resource|
  json.id resource.id
  json.page 1
  json.name resource.name
  json.pricePerUnit resource.pricePerUnit
  json.unit resource.unit
  json.monthlyCost resource.monthlyCost
  json.annualCost resource.annualCost
  json.description resource.description
  json.startValue resource.startValue
  json.startDate resource.startDate
  json.entryLength resource.entryLength
  json.chart do
      json.(resource.chart, :labels, :costs)
    end
  json.entries resource.entries do |entry|
    json.(entry, :value, :date, :id, :costs, :usage, :isFirst)
  end

  json.overview do
    json.general resource.overview.general do |entry|
        json.name entry.name
        json.usage entry.usage
        json.costs entry.costs
    end
    json.years resource.overview.years do |entry|
        json.name entry.name
        json.usage entry.usage
        json.costs entry.costs
    end
  end
  json.chartDateRange do
        json.(resource.chartDateRange, :startDate, :endDate)
    end
end