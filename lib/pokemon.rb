class Pokemon
    attr_reader :id, :name, :type, :hp, :db
    @@all = []
  
    def initialize (id:, name:, type:, hp: nil, db:)
      @id = id
      @name = name
      @type = type
      @hp = hp
      @db = db
      @@all << self
    end
  
    def self.save(name, type, db_connection)
      db_connection.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
    end
  
    def self.find(id, db_connection)
      pokemon = db_connection.execute("SELECT * FROM pokemon WHERE id = ?", id).flatten
      name = pokemon[1]
      type = pokemon[2]
      hp = pokemon[3]
  
      pokemon_inst = Pokemon.new(id: id, name: name, type: type, hp: hp, db: db_connection)
    end
  
    def alter_hp(new_hp, db_connection)
      db_connection.execute("UPDATE pokemon SET hp = ? WHERE id = ?", new_hp, @id)
    end
  

end
