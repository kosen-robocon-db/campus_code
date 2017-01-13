require "campus_code/campus"
require "thor"

module CampusCode

  class CLI < Thor

    desc "make [FILE]", "Makes campus codes from a file."
    def make(file)
      Campus.new(file).make_codes
    end

    desc "seed [FILE]", "Makes lines to create campus objects in seed.rb"
    def seed(file)
      Campus.new(file).seed_codes
    end

  end

end
