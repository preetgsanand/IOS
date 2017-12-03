import Foundation


class CastViewModel {
    private(set) var id : Int
    private(set) var name : String
    private(set) var character : String
    private(set) var profile_path : String
    
    
    init(id : Int,
         name : String,
        character : String,
        profile_path : String) {
        self.id = id
        self.name = name
        self.character = character
        self.profile_path = profile_path
    }
    
    
    func getUrl() -> URL? {
        return URL(string : MEDIA_BASE_URL + profile_path)
    }
    
    func getDetails() -> String {
        return "\(self.name)\n(\(self.character))"
    }
}

class PeopleCreditViewModel {
    private(set) var id : Int
    private(set) var poster_path : String
    private(set) var release_date : Date
    private(set) var character : String
    private(set) var title : String
    
    init(id : Int,
         poster_path : String,
         release_date : Date,
         character : String,
         title : String) {
        self.id = id
        self.poster_path = poster_path
        self.release_date = release_date
        self.character = character
        self.title = title
    }
    
    func getUrl() -> URL? {
        return URL(string : MEDIA_BASE_URL + poster_path)
    }
    
    func getTitle() -> String {
        return "\(title) (\(DateUtils.dateToReadableYear(date: release_date)))"
    }
    
    func getCharacter() -> String {
        return "as \(character)"
    }
}


class PeopleDetailViewModel {
    private(set) var name : String
    private(set) var birthday : Date
    private(set) var profile_path : String
    private(set) var biography : String
    private(set) var place_of_birth : String
    
    init(name : String,
         birthday : Date,
         profile_path : String,
         biography : String,
         place_of_birth : String) {
        self.biography = biography
        self.place_of_birth = place_of_birth
        self.name = name
        self.birthday = birthday
        self.profile_path = profile_path
        
    }
    
    func getUrl() -> URL? {
        return URL(string : MEDIA_BASE_URL + profile_path)
    }
    
    func getBirthDetails() -> String {
        return "Born \(DateUtils.dateToReadableFormat(date: birthday)) in \(place_of_birth)"
    }
}
