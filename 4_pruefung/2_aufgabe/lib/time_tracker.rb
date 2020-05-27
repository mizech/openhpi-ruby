require "task_list"
require "core_ext"

class TimeTracker
  DEFAULT_FILE_NAME = "tasks.txt"

  attr_reader :out

  # Speichere ein IO Objekt, welches als Ausgabemedium für alle
  # Programmausgaben dienen soll.
  #
  def initialize(out, filename: DEFAULT_FILE_NAME)
    @out = out
    @filename = filename
  end

  def tasklist
    @tasklist ||= TaskList.from_file @filename
  end

  # Führe den Time Tracker mit diesen Kommandozeilenargumenten aus.
  #
  def run(argv)
    command = argv.shift.to_s
    if command.empty?
      out.puts "Bitte gibt einen Befehl ein."
      return
    end

    method_name = "run_#{command}"

    if respond_to?(method_name)
      send(method_name, *argv)
    else
      out.puts "Unbekannter Befehl: #{command}"
    end
  end

  # Behandelt den Befehl "add". Fügt ein
  def run_add(text = nil)
    if text.to_s.blank?
      raise ArgumentError, "Bitte gib einen Text für die Aufgabe an."
    end

    tasklist << Task.new(text, Time.now)
    tasklist.save @filename
  end

  def run_done(text = nil)
    if text.to_s.blank?
      raise ArgumentError, "Bitte gib an welche Aufgabe erledigt ist."
    end

    task = tasklist.find {|t| t.text == text }
    if task && task.open?
      task.complete!
      tasklist.save @filename
      out.puts "Aufgabe erledigt: #{text}"
      out.puts "Noch #{tasklist.count(&:open?)} Aufgaben offen."
    else
      out.puts "Keine Aufgabe gefunden: #{text}"
    end
  end

  # Liste offene Aufgaben auf
  def run_list
    if tasklist.any?(&:open?)
      out.puts "Noch #{tasklist.count(&:open?)} offene Aufgabe(n):"

      # Leerzeile als Trenner einfügen
      out.puts

      # Offene Aufgaben nach Dauer (wie lange schon offen) ausgeben
      tasklist.select(&:open?).sort_by(&:start_time).each do |task|
        str = ""
        task.tag.each { |n| str << "#{n}, " }

        out.puts "OFFEN seit #{task.start_time}: #{task.text} (#{str[0...-2]})"
      end
    else
      out.puts "Keine offenen Aufgaben."
    end

    out.puts

    # Abgeschlossene Aufgaben ausgeben, zuletzt erledigte zuerst
    tasklist.select(&:completed?).sort_by(&:end_time).reverse.each do |task|
        str = ""
        task.tag.each { |n| str << "#{n}, " }

        puts "Tags: "
        puts task.tag

      out.puts "Fertig seit #{task.end_time}: #{task.text} (#{str[0...-2]})"
    end
  end
end
