import Foundation

class People {
    internal(set) var gender : Int
    internal(set) var id : Int
    internal(set) var name : String
    internal(set) var profile_path : String!
    internal(set) var birthday : Date!
    internal(set) var deathday : Date!
    internal(set) var biography : String!
    internal(set) var place_of_birth : String!
    
    init(gender : Int,
         id : Int,
         name : String,
         profile_path : String?) {
        
    
        self.gender = gender
        self.id = id
        self.name = name
        self.profile_path = profile_path
    }
    
    func setDetails(birthday : Date,
                    deathday : Date,
                    biography : String,
                    place_of_birth : String) {
        self.birthday = birthday
        self.deathday = deathday
        self.biography = biography
        self.place_of_birth = place_of_birth
    }

}

class Credit : People {
    private(set) var cast_id : Int
    private(set) var character : String
    private(set) var credit_id : String
    private(set) var order : Int!

    init(cast_id : Int,
         character : String,
         credit_id : String,
         gender : Int,
         id : Int,
         name : String,
         order : Int?,
         profile_path : String) {
        self.order = order
        self.cast_id = cast_id
        self.character = character
        self.credit_id = credit_id
        super.init(gender: gender, id: id, name: name, profile_path: profile_path)
    }
}

class Crew : People {
    private(set) var department : String
    private(set) var job : String
    
    init(department : String,
         job : String,
         gender : Int,
         id : Int,
         name : String,
         profile_path : String) {
        self.department = department
        self.job = job
        super.init(gender: gender, id: id, name: name, profile_path: profile_path)

    }
}
