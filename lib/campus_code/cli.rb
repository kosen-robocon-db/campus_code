require "campus_code/campus"
require "thor"

module CampusCode

  class CLI < Thor

    desc "make [FILE]", "Makes campus codes from a file."
    def make(file)
      Campus.new(file).make_codes
    end

  end

end
