module WordSearch
  module TwoDimensional
    class Plane < Plane::Base
      def initialize(x, y)
        @catalog = Catalog.new
        @x, @y = x, y

        initialize_plane do |x_point, y_point|
          self[x_point][y_point] = Point.new(x_point, y_point)
        end
      end

      def to_s
        values.map do |row|
          row.values.map(&:letter)
        end.transpose.reverse.map(&:join).join("\n")
      end

      def add_letters
        super do |x_point, y_point|
          self[x_point][y_point].letter ||= random_letter
        end
      end

      def total_points
        x * y
      end

      def max
        [x, y].max
      end

      def directions
        @directions ||= WordSearch::TwoDimensional::Direction
      end

      class << self
        def make_from_file(file)
          string = File.read(file).split("\n").reverse

          return false if (x_len = string.collect(&:length).uniq).count > 1 ||
                          x_len.blank?

          make_word_search(x_len, string)
        end

        private

        def make_word_search(x_len, string)
          plane = new(x_len.first, string.count)

          string.each_with_index do |row, y|
            row.split('').each_with_index do |letter, x|
              add_to_catalog(plane, plane[x][y] = Point.new(x, y, letter))
            end
          end

          plane
        end

        def add_to_catalog(plane, point)
          plane.catalog[point.letter] ||= []
          plane.catalog[point.letter] << point
        end
      end
    end
  end
end