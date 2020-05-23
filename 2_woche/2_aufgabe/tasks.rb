# Für Time.parse
require "time"


class Task
  def initialize(text, start_time, end_time = nil)
    @text = text
    @start_time = start_time
    @end_time = end_time
  end

  def self.parse(line)
    parts = line.strip.split(",")
    new(
      parts[0],
      Time.parse(parts[1]),
      (Time.parse(parts[2]) rescue nil)
    )
  end

  attr_reader :text, :start_time, :end_time

  def completed?
    @end_time
  end

  def complete!
    @end_time = Time.new
  end

  def duration
    return 0 unless completed?

    (@end_time - @start_time).to_i
  end
end

class TaskList
  def initialize(tasks = [])
    @tasks = tasks
  end

  def self.from_file(filename)
    instance = new
    instance.load(filename)
    instance
  end

  def load(filename)
    File.open(filename, "r") do |file|
      file.each do |line|
        self << Task.parse(line)
      end
    end
  end

  include Enumerable

  def each
    @tasks.each { |t| yield t }
  end

  def <<(task)
    @tasks << task
    self
  end
end

if ARGV[0] == "done"
  text = ARGV[1]
  total = 0
  open = 0
  completed = 0
  statements = []

  list = TaskList.new 
  list.load("tasks.txt")

  list.each { |task| 
    if text == task.text
      task.complete!
    end
  }

  list.each { |task| 
    total = total + 1
    prefix = "OFFEN"

    if (task.completed?).class == Time
        prefix = "ERLEDIGT"
        completed = completed + 1
    else 
        open = open + 1
    end 

    statements << "#{task.text},#{task.start_time},#{task.end_time}" 
  }

  puts "#{text} erledigt. Noch #{open} Aufgaben offen."
  # puts "#{open} offen, #{completed} erledigt"

  # puts statements.sort.reverse
end

