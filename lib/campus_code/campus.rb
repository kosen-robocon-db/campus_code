require 'campus_code/geocoder'
require 'csv'
require 'pp'

module CampusCode

  class Campus

    def initialize(file)
      @file = file
    end

    def make_codes
      read
      get_coordinates
      sort
      encode
      output
    end

    def seed_codes
      read
      get_coordinates
      sort
      encode
      output_seed_lines
    end

    private

    def read
      @campus_table = CSV.table(@file, { headers: false, :encoding => 'UTF-8'})
    end

    def get_coordinates
      geocoder = Geocoder.new
      @campus_table.each do |row|
        coordinates = geocoder.get_coordinates(row[1])
        if coordinates && coordinates.size == 2
          row[3] = coordinates[:latitude]
          row[4] = coordinates[:longtitude]
        end
      end
    end

    def sort
      sorted_campus_table = []
      (1..9).each do |i|
        campases = @campus_table.select { |row| row[0] == i }
        campases.sort! do |a, b|
          (b[3] <=> a[3]).nonzero? || (b[4] <=> a[4])
        end
        campases.each { |row| sorted_campus_table.push(row) }
      end
      @campus_table = sorted_campus_table
    end

    def encode
      @campus_table.each_with_index do |row, i|
        row[5] = ("#{row[0]}" "#{"%02d" % (i + 1)}" "0").to_i
      end
    end

    def output
      @campus_table.each do |row|
        row.each_with_index do |col, i|
          i != 5 ? print(col,",") : puts(col)
        end
      end
    end

    def output_seed_lines
      region = {  1 => "北海道", 2 => "東北", 3 => "関東甲信越", 4 => "東海北陸", \
                  5 => "近畿", 6 => "中国", 7 => "四国", 8 => "九州沖縄", \
                  9 => "他" }
      region_flag = 0
      @campus_table.each do |row|
        if row[0] != region_flag then
          region_flag = row[0]
          puts("region = Region.create(name: \"#{region[row[0]]}\")")
        end
        puts("Campus.create(region: region, code: #{row[5]}, \
              name: \"#{row[1]}\", abbreviation: \"#{row[2]}\", \
              latitude: #{row[3]}, longtitude: #{row[4]})")
      end
    end

  end

end
