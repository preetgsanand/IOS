//
//  PeopleViewModel.swift
//  TMDB
//
//  Created by Preet G S Anand on 11/1/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import Foundation


class CastViewModel {
    private(set) var name : String
    private(set) var character : String
    private(set) var profile_path : String
    
    
    init(name : String,
        character : String,
        profile_path : String) {
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
