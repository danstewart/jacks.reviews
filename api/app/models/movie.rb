class Movie < ApplicationRecord
  has_many :movie_tags
  has_many :movie_comments
  has_many :tags, :through => :movie_tags

  validates_presence_of :title, :tmdb_id

  # NOTE: This might become slow over time
  # Take an array of tables to join and return JSON of movie
  def self.with(items)
    results = self.includes(:tags, :movie_comments)

    results = results.map do |m|
      result = m.as_json
      items.each do |item|
        result[item] = m.send("get_#{item}")
      end

      result
    end
  end

  # Take an array of tables to join and return JSON of movie
  def with(items)
    response = self.as_json
    items.each do |item|
      response[item] = self.send("get_#{item}")
    end

    return response
  end

  def get_tags
    self.tags.map(&:text)
  end

  def get_comments
    self.movie_comments.as_json
  end

  def add_tag(name)
    name.gsub!(/\s+/, '')
    tag = Tag.find_by(text: name) || Tag.create!(text: name)
    MovieTag.create(movie_id: self.id, tag_id: tag.id)
  end
end
