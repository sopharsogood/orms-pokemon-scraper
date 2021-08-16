require_relative '../bin/environment.rb'

class Pokemon
    attr_accessor :name, :type, :id, :db

    def initialize(name:, type:, id: nil, db:)
        self.name = name
        self.type = type
        self.db = db
        self.id = id
    end

    def self.save(name, type, db)
        sql = "INSERT INTO pokemon (name, type) VALUES (?, ?)"
        db.execute(sql, name, type)
    end

    def self.find(id, db)
        sql = "SELECT * FROM pokemon WHERE id = ? LIMIT 1"
        db.execute(sql, id).collect do |row|
            Pokemon.new(name: row[1], type: row[2], id: row[0], db: db)
        end.first
    end

end
