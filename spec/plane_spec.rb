require 'spec_helper'

describe WordSearch::Plane do
  it 'makes a plane' do
    plane = WordSearch::Plane.new(5, 5)
    expect(plane).to be_a WordSearch::Plane
  end

  it 'outputs plane as a string' do
    plane = WordSearch::Plane.new(5, 5)
    expect(plane.to_s).to be_a String
  end

  describe WordSearch::TwoDimensional::Plane do
    subject { WordSearch::Plane.new(5, 5) }

    it 'is a 2D word search' do
      expect(subject.two_dimensional?)
    end

    it 'is not a 3D word search' do
      expect(subject.three_dimensional?).to be false
    end

    describe 'make from file' do
      subject do
        tempfile = Tempfile.new
        tempfile << "xx\nxx"
        tempfile.rewind
        tempfile
      end

      it 'makes a plane from a text file' do
        plane = WordSearch::TwoDimensional::Plane.make_from_file(subject.path)
        expect(plane.x).to eq(2)
        expect(plane.y).to eq(2)
      end
    end
  end

  describe WordSearch::ThreeDimensional::Plane do
    subject { WordSearch::Plane.new(5, 5, 5) }

    it 'is not a 2D word search' do
      expect(subject.two_dimensional?).to be false
    end

    it 'is a 3D word search' do
      expect(subject.three_dimensional?)
    end

    describe 'make from file' do
      subject do
        tempfile = Tempfile.new
        tempfile << "xx\nxx\n\nxx\nxx\n\nxx\nxx"
        tempfile.rewind
        tempfile
      end

      it 'makes a plane from a text file' do
        plane = WordSearch::ThreeDimensional::Plane.make_from_file(subject.path)
        expect(plane.x).to eq(2)
        expect(plane.y).to eq(2)
        expect(plane.z).to eq(3)
      end
    end
  end
end
