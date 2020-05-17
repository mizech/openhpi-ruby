puts("-- Ruby Playground --")

str = "First Second Third"

puts str[0..4]

lang = {
    de: "Deutsch",
    en: "Englisch",
    fr: "Franzoesisch"
}

lang[:ru] = "Russisch"

lang.each { | k, v |
    puts "#{k}: #{v} #{k.class}"
}

nums = [3, 39, 98, 4, 308, 8, 58, 493, 2, 502]

grouped = nums.group_by { | n | n > 100 }

puts grouped

