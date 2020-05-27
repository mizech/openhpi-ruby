require "task"

class TaskList
  def initialize
    @tasks = []
  end

  def self.from_file(filename)
    new.tap do |tasklist|
      tasklist.load filename
    end
  end

  def load(filename)
    File.open(filename, "r") do |file|
      file.each do |line|
        self << Task.parse(line)
      end
    end
  end

  def save(filename)
    File.write filename, @tasks.join("\n")
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
