require "time"

class Task
  def self.parse(line)
   
    text, start, stop, tag = line.strip.split(",")
    tmp = tag.split(" ")

    new text,
        Time.parse(start.to_s),
        parse_optional_time(stop),
        tag: tmp
  end

  def tags
    @tag
  end

  def self.parse_optional_time(str)
    Time.parse str.to_s
  rescue ArgumentError
    nil
  end

  attr_reader :text, :start_time, :end_time, :tag

  def initialize(text, start_time, end_time = nil, tag: nil)
    @text = text
    @tag = tag
    @start_time = start_time
    @end_time = end_time
  end

  def open?
    !completed?
  end

  def completed?
    @end_time
  end

  def complete!
    @end_time = Time.new
  end

  def duration
    if completed?
      (end_time - start_time).to_i
    else
      0
    end
  end

  def to_s
    [text, start_time, end_time, tag].join(",")
  end
end
