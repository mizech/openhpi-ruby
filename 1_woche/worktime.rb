def work_per_month(worktime)
    ret = {}
    stats = {}
    
    worktime.each { | day | 
      key = day[:date][0..6]
      spec_day = day[:date][8..9]
      check = ret[key]

      if check == nil
          ret[key] = day[:time]
          stats[key] = [day[:time], 1, [spec_day]]
      else 
        total = stats[key][0]
        times = stats[key][1]

        total = total + day[:time]

        if not stats[key][2].include?(spec_day)
          times = times + 1
          stats[key][2] << spec_day  
        end

        stats[key][0] = total
        stats[key][1] = times

        ret[key] = total / times
      end
    }
    
    ret
end

list = [
  {work: "item 1", date: "2017-04-26", time: 20},
  {work: "item 2", date: "2017-04-27", time: 27},
  {work: "item 3", date: "2017-04-27", time: 33},
  {work: "item 4", date: "2017-05-05", time: 20},
  {work: "item 5", date: "2017-05-06", time: 12},
  {work: "item 6", date: "2017-05-14", time: 10}
]

puts(work_per_month(list))

