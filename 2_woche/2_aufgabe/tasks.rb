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

  def write(filename, list)
    i = 0

    file = File.open(filename, "w")

    list.each do |line|
      file.puts line
    end

    file.close
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
  open = 0
  statements = []
  action_done = false

  list = TaskList.new 
  list.load("tasks.txt")

  list.each { |task| 
    if text == task.text && (task.completed?).class != Time
      task.complete!
      action_done = true
    end

    if (task.completed?).class != Time
        open = open + 1
    end 

    statements << "#{task.text},#{task.start_time},#{task.end_time}" 
  }

  list = TaskList.new 
  list.write("tasks.txt", statements)

  if action_done == true
    puts "#{text} erledigt. Noch #{open} Aufgaben offen."
  else 
    puts "Nichts zu erledigen."
  end
end

