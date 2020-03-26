class Cache
  def self.store(key, data)
    File.open(file_path(key), 'w') do |f|
      f.write(JSON.generate(data))
    end
  end

  def self.fetch(key, max_age = nil)
    return nil unless File.file?(file_path(key))

    File.open(file_path(key), 'r') do |f|
      if max_age
        age = File.mtime(f).to_i
        return nil if Time.now.to_i - age > max_age
      end

      return JSON.parse(f.read)
    end
  end


  private
  def self.file_path(name)
    return "#{Rails.root}/tmp/cache/#{name}.json"
  end
  

end