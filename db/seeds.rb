Bill.create!([
  {value: 555.0, date: nil, user_id: 1, billcategory_id: 1},
  {value: 555.0, date: nil, user_id: 1, billcategory_id: 1},
  {value: 555.0, date: nil, user_id: 1, billcategory_id: 1}
])
Billcategory.create!([
  {flat_id: 1, name: "first"},
  {flat_id: 1, name: "first"},
  {flat_id: 1, name: "first"}
])
Flat.create!([
  {name: "mc", street: "seilergasse 14", city: "innsbruck", zip: "6020", image_path: nil},
  {name: "MC", street: "Seilergasse 14.1", city: "Innsbruck", zip: "6020", image_path: nil}
])
Ressource.create!([
  {flat_id: 1, name: "Wasser", unit: "m³", pricePerUnit: 0.01, monthlyCost: 10.0, annualCost: 120.0, description: "outside", startValue: 1000.0, startDate: "2014-04-01 16:13:34"},
  {flat_id: 2, name: "Strom", unit: "kw/h", pricePerUnit: 0.2, monthlyCost: 10.0, annualCost: 10.0, description: nil, startValue: 900.0, startDate: "2014-04-01 11:10:55"},
  {flat_id: 1, name: "Strom", unit: "kw/h", pricePerUnit: 0.1526, monthlyCost: 1.2, annualCost: 36.8736, description: nil, startValue: 47999.0, startDate: "2012-07-15 16:13:34"},
  {flat_id: 1, name: "Gas", unit: "m³", pricePerUnit: 0.1548, monthlyCost: 10.0, annualCost: 15.0, description: "hot water", startValue: 5000.0, startDate: "2014-04-04 19:45:10"},
  {flat_id: 1, name: "Strom Boiler", unit: "kw/h", pricePerUnit: 0.110142, monthlyCost: 1.2, annualCost: 13.2, description: "Boiler", startValue: 13635.0, startDate: "2012-07-15 20:13:24"}
])
Ressourceentry.create!([
  {ressource_id: 12, date: "2014-04-01", value: 1000.0, isFirst: true},
  {ressource_id: 12, date: "2014-04-04", value: 3000.0, isFirst: false},
  {ressource_id: 12, date: "2014-04-05", value: 4000.0, isFirst: false},
  {ressource_id: 12, date: "2014-04-06", value: 4500.0, isFirst: false},
  {ressource_id: 12, date: "2014-04-08", value: 5000.0, isFirst: false},
  {ressource_id: 14, date: "2014-04-01", value: 1000.0, isFirst: true},
  {ressource_id: 15, date: "2014-04-01", value: nil, isFirst: true},
  {ressource_id: 14, date: "2014-04-03", value: 3000.0, isFirst: false},
  {ressource_id: 14, date: "2014-04-09", value: 4000.0, isFirst: false},
  {ressource_id: 14, date: "2014-04-09", value: 9000.0, isFirst: false},
  {ressource_id: 14, date: "2014-03-04", value: 2323.0, isFirst: false},
  {ressource_id: 16, date: "2014-04-01", value: 1000.0, isFirst: true},
  {ressource_id: 17, date: "2014-04-01", value: 1000.0, isFirst: true},
  {ressource_id: 18, date: "2014-04-01", value: 900.0, isFirst: true},
  {ressource_id: 16, date: "2014-04-02", value: 1300.0, isFirst: false},
  {ressource_id: 16, date: "2014-04-03", value: 1500.0, isFirst: false},
  {ressource_id: 16, date: "2014-04-04", value: 1800.0, isFirst: false},
  {ressource_id: 16, date: "2014-04-05", value: 1900.0, isFirst: false},
  {ressource_id: 17, date: "2014-04-07", value: 2000.0, isFirst: false},
  {ressource_id: 19, date: "2012-07-15", value: 47999.0, isFirst: true},
  {ressource_id: 17, date: "2014-05-02", value: 4000.0, isFirst: false},
  {ressource_id: 17, date: "2014-05-08", value: 5000.0, isFirst: false},
  {ressource_id: 19, date: "2012-09-25", value: 48172.0, isFirst: false},
  {ressource_id: 19, date: "2012-09-30", value: 48213.0, isFirst: false},
  {ressource_id: 19, date: "2012-10-02", value: 48227.0, isFirst: false},
  {ressource_id: 19, date: "2012-10-15", value: 48325.0, isFirst: false},
  {ressource_id: 19, date: "2012-10-17", value: 48354.0, isFirst: false},
  {ressource_id: 19, date: "2012-10-22", value: 48398.0, isFirst: false},
  {ressource_id: 19, date: "2012-10-27", value: 48451.0, isFirst: false},
  {ressource_id: 19, date: "2012-10-29", value: 48481.0, isFirst: false},
  {ressource_id: 19, date: "2012-10-30", value: 48502.0, isFirst: false},
  {ressource_id: 19, date: "2012-10-31", value: 48523.0, isFirst: false},
  {ressource_id: 19, date: "2012-11-01", value: 48548.0, isFirst: false},
  {ressource_id: 19, date: "2012-11-02", value: 48567.0, isFirst: false},
  {ressource_id: 19, date: "2012-11-03", value: 48582.0, isFirst: false},
  {ressource_id: 19, date: "2012-11-04", value: 48597.0, isFirst: false},
  {ressource_id: 19, date: "2012-11-05", value: 48607.0, isFirst: false},
  {ressource_id: 19, date: "2012-11-06", value: 48624.0, isFirst: false},
  {ressource_id: 19, date: "2012-11-07", value: 48644.0, isFirst: false},
  {ressource_id: 19, date: "2012-11-08", value: 48664.0, isFirst: false},
  {ressource_id: 19, date: "2012-11-09", value: 48683.0, isFirst: false},
  {ressource_id: 19, date: "2012-11-12", value: 48736.0, isFirst: false},
  {ressource_id: 19, date: "2012-11-13", value: 48755.0, isFirst: false},
  {ressource_id: 19, date: "2012-11-14", value: 48771.0, isFirst: false},
  {ressource_id: 19, date: "2012-11-15", value: 48790.0, isFirst: false},
  {ressource_id: 19, date: "2012-11-19", value: 48893.0, isFirst: false},
  {ressource_id: 19, date: "2012-11-20", value: 48912.0, isFirst: false},
  {ressource_id: 19, date: "2012-11-21", value: 48938.0, isFirst: false},
  {ressource_id: 19, date: "2012-11-22", value: 48961.0, isFirst: false},
  {ressource_id: 19, date: "2012-11-23", value: 48987.0, isFirst: false},
  {ressource_id: 19, date: "2012-11-24", value: 49013.0, isFirst: false},
  {ressource_id: 19, date: "2012-11-26", value: 49036.0, isFirst: false},
  {ressource_id: 19, date: "2012-11-27", value: 49061.0, isFirst: false},
  {ressource_id: 19, date: "2012-11-28", value: 49078.0, isFirst: false},
  {ressource_id: 19, date: "2012-11-29", value: 49112.0, isFirst: false},
  {ressource_id: 19, date: "2012-12-03", value: 49186.0, isFirst: false},
  {ressource_id: 19, date: "2012-12-04", value: 49213.0, isFirst: false},
  {ressource_id: 19, date: "2012-12-07", value: 49298.0, isFirst: false},
  {ressource_id: 19, date: "2012-12-09", value: 49364.0, isFirst: false},
  {ressource_id: 19, date: "2012-12-10", value: 49400.0, isFirst: false},
  {ressource_id: 19, date: "2012-12-11", value: 49427.0, isFirst: false},
  {ressource_id: 19, date: "2012-12-12", value: 49453.0, isFirst: false},
  {ressource_id: 19, date: "2012-12-13", value: 49483.0, isFirst: false},
  {ressource_id: 19, date: "2012-12-14", value: 49517.0, isFirst: false},
  {ressource_id: 19, date: "2012-12-15", value: 49553.0, isFirst: false},
  {ressource_id: 19, date: "2012-12-16", value: 49576.0, isFirst: false},
  {ressource_id: 19, date: "2012-12-18", value: 49620.0, isFirst: false},
  {ressource_id: 19, date: "2012-12-19", value: 49641.0, isFirst: false},
  {ressource_id: 19, date: "2012-12-20", value: 49662.0, isFirst: false},
  {ressource_id: 19, date: "2012-12-27", value: 49675.0, isFirst: false},
  {ressource_id: 19, date: "2012-12-29", value: 49749.0, isFirst: false},
  {ressource_id: 19, date: "2012-12-31", value: 49785.0, isFirst: false},
  {ressource_id: 19, date: "2013-01-04", value: 49874.0, isFirst: false},
  {ressource_id: 19, date: "2013-01-05", value: 49894.0, isFirst: false},
  {ressource_id: 19, date: "2013-01-06", value: 49917.0, isFirst: false},
  {ressource_id: 19, date: "2013-01-07", value: 49936.0, isFirst: false},
  {ressource_id: 19, date: "2013-01-08", value: 49955.0, isFirst: false},
  {ressource_id: 19, date: "2013-01-09", value: 49977.0, isFirst: false},
  {ressource_id: 19, date: "2013-01-11", value: 50018.0, isFirst: false},
  {ressource_id: 19, date: "2013-01-13", value: 50062.0, isFirst: false},
  {ressource_id: 19, date: "2013-01-14", value: 50088.0, isFirst: false},
  {ressource_id: 19, date: "2013-01-15", value: 50114.0, isFirst: false},
  {ressource_id: 19, date: "2013-01-18", value: 50197.0, isFirst: false},
  {ressource_id: 19, date: "2013-01-21", value: 50297.0, isFirst: false},
  {ressource_id: 19, date: "2013-01-28", value: 50490.0, isFirst: false},
  {ressource_id: 19, date: "2013-02-03", value: 50648.0, isFirst: false},
  {ressource_id: 19, date: "2013-02-04", value: 50670.0, isFirst: false},
  {ressource_id: 19, date: "2013-02-11", value: 50852.0, isFirst: false},
  {ressource_id: 19, date: "2013-02-17", value: 51026.0, isFirst: false},
  {ressource_id: 19, date: "2013-02-20", value: 51092.0, isFirst: false},
  {ressource_id: 19, date: "2013-02-28", value: 51098.0, isFirst: false},
  {ressource_id: 19, date: "2013-03-04", value: 51193.0, isFirst: false},
  {ressource_id: 19, date: "2013-03-07", value: 51240.0, isFirst: false},
  {ressource_id: 19, date: "2013-03-11", value: 51273.0, isFirst: false},
  {ressource_id: 19, date: "2013-03-17", value: 51368.0, isFirst: false},
  {ressource_id: 19, date: "2013-03-25", value: 51520.0, isFirst: false},
  {ressource_id: 19, date: "2013-04-12", value: 51646.0, isFirst: false},
  {ressource_id: 19, date: "2013-04-26", value: 51753.0, isFirst: false},
  {ressource_id: 19, date: "2013-05-26", value: 51905.0, isFirst: false},
  {ressource_id: 19, date: "2013-07-16", value: 52205.0, isFirst: false},
  {ressource_id: 19, date: "2013-08-30", value: 52339.0, isFirst: false},
  {ressource_id: 19, date: "2013-10-02", value: 52467.0, isFirst: false},
  {ressource_id: 19, date: "2013-10-18", value: 52626.0, isFirst: false},
  {ressource_id: 19, date: "2013-10-25", value: 52685.0, isFirst: false},
  {ressource_id: 19, date: "2013-11-01", value: 52796.0, isFirst: false},
  {ressource_id: 19, date: "2013-11-13", value: 53032.0, isFirst: false},
  {ressource_id: 19, date: "2013-11-27", value: 53415.0, isFirst: false},
  {ressource_id: 19, date: "2013-11-30", value: 53541.0, isFirst: false},
  {ressource_id: 19, date: "2013-12-05", value: 53717.0, isFirst: false},
  {ressource_id: 19, date: "2013-12-20", value: 54246.0, isFirst: false},
  {ressource_id: 19, date: "2014-01-02", value: 54457.0, isFirst: false},
  {ressource_id: 19, date: "2014-01-12", value: 54778.0, isFirst: false},
  {ressource_id: 19, date: "2014-01-23", value: 55069.0, isFirst: false},
  {ressource_id: 19, date: "2014-01-31", value: 55330.0, isFirst: false},
  {ressource_id: 19, date: "2014-02-28", value: 55927.0, isFirst: false},
  {ressource_id: 19, date: "2014-03-31", value: 56427.0, isFirst: false},
  {ressource_id: 17, date: "2014-05-16", value: 5871.0, isFirst: false},
  {ressource_id: 17, date: "2014-05-23", value: 10010.0, isFirst: false},
  {ressource_id: 17, date: "2014-05-29", value: 12000.0, isFirst: false},
  {ressource_id: 19, date: "2014-04-04", value: 56463.0, isFirst: false},
  {ressource_id: 20, date: "2014-04-04", value: 5000.0, isFirst: true},
  {ressource_id: 20, date: "2014-04-06", value: 5413.0, isFirst: false},
  {ressource_id: 20, date: "2014-04-08", value: 5460.0, isFirst: false},
  {ressource_id: 21, date: "2012-07-15", value: 13635.0, isFirst: true},
  {ressource_id: 21, date: "2012-09-25", value: 13718.0, isFirst: false},
  {ressource_id: 21, date: "2012-09-30", value: 13730.0, isFirst: false},
  {ressource_id: 21, date: "2012-10-02", value: 13737.0, isFirst: false},
  {ressource_id: 21, date: "2012-10-15", value: 13781.0, isFirst: false},
  {ressource_id: 21, date: "2012-10-17", value: 13789.0, isFirst: false},
  {ressource_id: 21, date: "2012-10-22", value: 13809.0, isFirst: false},
  {ressource_id: 21, date: "2012-10-27", value: 13826.0, isFirst: false},
  {ressource_id: 21, date: "2012-10-29", value: 13835.0, isFirst: false},
  {ressource_id: 21, date: "2012-10-30", value: 13838.0, isFirst: false},
  {ressource_id: 21, date: "2012-10-31", value: 13843.0, isFirst: false},
  {ressource_id: 21, date: "2012-11-01", value: 13846.0, isFirst: false},
  {ressource_id: 21, date: "2012-11-02", value: 13850.0, isFirst: false},
  {ressource_id: 21, date: "2012-11-03", value: 13855.0, isFirst: false},
  {ressource_id: 21, date: "2012-11-04", value: 13860.0, isFirst: false},
  {ressource_id: 21, date: "2012-11-05", value: 13863.0, isFirst: false},
  {ressource_id: 21, date: "2012-11-06", value: 13868.0, isFirst: false},
  {ressource_id: 21, date: "2012-11-07", value: 13871.0, isFirst: false},
  {ressource_id: 21, date: "2012-11-08", value: 13875.0, isFirst: false},
  {ressource_id: 21, date: "2012-11-09", value: 13879.0, isFirst: false},
  {ressource_id: 21, date: "2012-11-12", value: 13891.0, isFirst: false},
  {ressource_id: 21, date: "2012-11-13", value: 13896.0, isFirst: false},
  {ressource_id: 21, date: "2012-11-14", value: 13899.0, isFirst: false},
  {ressource_id: 21, date: "2012-11-15", value: 13901.0, isFirst: false},
  {ressource_id: 21, date: "2012-11-19", value: 13916.0, isFirst: false},
  {ressource_id: 21, date: "2012-11-20", value: 13919.0, isFirst: false},
  {ressource_id: 21, date: "2012-11-21", value: 13923.0, isFirst: false},
  {ressource_id: 21, date: "2012-11-22", value: 13928.0, isFirst: false},
  {ressource_id: 21, date: "2012-11-23", value: 13931.0, isFirst: false},
  {ressource_id: 21, date: "2012-11-24", value: 13936.0, isFirst: false},
  {ressource_id: 21, date: "2012-11-26", value: 13941.0, isFirst: false},
  {ressource_id: 21, date: "2012-11-27", value: 13943.0, isFirst: false},
  {ressource_id: 21, date: "2012-11-28", value: 13949.0, isFirst: false},
  {ressource_id: 21, date: "2012-11-29", value: 13956.0, isFirst: false},
  {ressource_id: 21, date: "2012-12-03", value: 13973.0, isFirst: false},
  {ressource_id: 21, date: "2012-12-04", value: 13979.0, isFirst: false},
  {ressource_id: 21, date: "2012-12-07", value: 13990.0, isFirst: false},
  {ressource_id: 21, date: "2012-12-09", value: 14001.0, isFirst: false},
  {ressource_id: 21, date: "2012-12-10", value: 14006.0, isFirst: false},
  {ressource_id: 21, date: "2012-12-11", value: 14012.0, isFirst: false},
  {ressource_id: 21, date: "2012-12-12", value: 14015.0, isFirst: false},
  {ressource_id: 21, date: "2012-12-13", value: 14019.0, isFirst: false},
  {ressource_id: 21, date: "2012-12-14", value: 14023.0, isFirst: false},
  {ressource_id: 21, date: "2012-12-15", value: 14027.0, isFirst: false},
  {ressource_id: 21, date: "2012-12-16", value: 14032.0, isFirst: false},
  {ressource_id: 21, date: "2012-12-18", value: 14042.0, isFirst: false},
  {ressource_id: 21, date: "2012-12-19", value: 14047.0, isFirst: false},
  {ressource_id: 21, date: "2012-12-20", value: 14050.0, isFirst: false},
  {ressource_id: 21, date: "2012-12-27", value: 14050.0, isFirst: false},
  {ressource_id: 21, date: "2012-12-29", value: 14062.0, isFirst: false},
  {ressource_id: 21, date: "2012-12-31", value: 14074.0, isFirst: false},
  {ressource_id: 21, date: "2013-01-04", value: 14093.0, isFirst: false},
  {ressource_id: 21, date: "2013-01-05", value: 14096.0, isFirst: false},
  {ressource_id: 21, date: "2013-01-06", value: 14102.0, isFirst: false},
  {ressource_id: 21, date: "2013-01-07", value: 14106.0, isFirst: false},
  {ressource_id: 21, date: "2013-01-08", value: 14109.0, isFirst: false},
  {ressource_id: 21, date: "2013-01-09", value: 14113.0, isFirst: false},
  {ressource_id: 21, date: "2013-01-11", value: 14121.0, isFirst: false},
  {ressource_id: 21, date: "2013-01-13", value: 14129.0, isFirst: false},
  {ressource_id: 21, date: "2013-01-14", value: 14133.0, isFirst: false},
  {ressource_id: 21, date: "2013-01-15", value: 14135.0, isFirst: false},
  {ressource_id: 21, date: "2013-01-18", value: 14149.0, isFirst: false},
  {ressource_id: 21, date: "2013-01-21", value: 14161.0, isFirst: false},
  {ressource_id: 21, date: "2013-01-28", value: 14187.0, isFirst: false},
  {ressource_id: 21, date: "2013-02-03", value: 14220.0, isFirst: false},
  {ressource_id: 21, date: "2013-02-04", value: 14226.0, isFirst: false},
  {ressource_id: 21, date: "2013-02-11", value: 14259.0, isFirst: false},
  {ressource_id: 21, date: "2013-02-17", value: 14291.0, isFirst: false},
  {ressource_id: 21, date: "2013-02-20", value: 14305.0, isFirst: false},
  {ressource_id: 21, date: "2013-02-28", value: 14305.0, isFirst: false},
  {ressource_id: 21, date: "2013-03-04", value: 14327.0, isFirst: false},
  {ressource_id: 21, date: "2013-03-07", value: 14341.0, isFirst: false},
  {ressource_id: 21, date: "2013-03-11", value: 14354.0, isFirst: false},
  {ressource_id: 21, date: "2013-03-17", value: 14381.0, isFirst: false},
  {ressource_id: 21, date: "2013-03-25", value: 14424.0, isFirst: false},
  {ressource_id: 21, date: "2013-04-12", value: 14457.0, isFirst: false},
  {ressource_id: 21, date: "2013-04-26", value: 14523.0, isFirst: false},
  {ressource_id: 21, date: "2013-05-26", value: 14626.0, isFirst: false},
  {ressource_id: 21, date: "2013-07-16", value: 14785.0, isFirst: false},
  {ressource_id: 21, date: "2013-08-30", value: 14828.0, isFirst: false},
  {ressource_id: 21, date: "2013-10-02", value: 14874.0, isFirst: false},
  {ressource_id: 21, date: "2013-10-18", value: 14930.0, isFirst: false},
  {ressource_id: 21, date: "2013-10-25", value: 14957.0, isFirst: false},
  {ressource_id: 21, date: "2013-11-01", value: 14985.0, isFirst: false},
  {ressource_id: 21, date: "2013-11-13", value: 15033.0, isFirst: false},
  {ressource_id: 21, date: "2013-11-27", value: 15080.0, isFirst: false},
  {ressource_id: 21, date: "2013-11-30", value: 15093.0, isFirst: false},
  {ressource_id: 21, date: "2013-12-05", value: 15115.0, isFirst: false},
  {ressource_id: 21, date: "2013-12-20", value: 15183.0, isFirst: false},
  {ressource_id: 21, date: "2014-01-02", value: 15207.0, isFirst: false},
  {ressource_id: 21, date: "2014-01-12", value: 15248.0, isFirst: false},
  {ressource_id: 21, date: "2014-01-23", value: 15296.0, isFirst: false},
  {ressource_id: 21, date: "2014-01-31", value: 15337.0, isFirst: false},
  {ressource_id: 21, date: "2014-02-28", value: 15454.0, isFirst: false},
  {ressource_id: 21, date: "2014-03-31", value: 15607.0, isFirst: false},
  {ressource_id: 17, date: "2014-04-06", value: 1854.0, isFirst: false},
  {ressource_id: 17, date: "2014-04-15", value: 3748.0, isFirst: false},
  {ressource_id: 17, date: "2014-05-29", value: 12111.0, isFirst: false},
  {ressource_id: 22, date: "2014-04-05", value: 333.0, isFirst: true}
])
Shareditem.create!([
  {name: "asdf", tags: nil, available: nil, hidden: nil, description: nil, sharingNote: nil, image_path: nil, flat_id: 1},
  {name: "asdf", tags: nil, available: nil, hidden: nil, description: nil, sharingNote: nil, image_path: nil, flat_id: 1},
  {name: "asdf", tags: nil, available: nil, hidden: nil, description: nil, sharingNote: nil, image_path: nil, flat_id: 1}
])
Shoppinglist.create!([
  {name: "asdf", flat_id: 1},
  {name: "asd", flat_id: 1}
])
User.create!([
  {flat_id: 1, email: "clemens@mto.at", provider: "facebook", uid: "1489303205", name: "Clemens Brunner", oauth_token: nil, oauth_expires_at: "2014-06-04 08:57:11", image_path: "http://graph.facebook.com/1489303205/picture"},
  {flat_id: 2, email: "cle1000.cb@gmail.com", provider: "google_oauth2", uid: "116226731945755969597", name: "Clemens Brunner", oauth_token: nil, oauth_expires_at: "2014-04-02 12:08:40", image_path: "https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg"}
])
