//
//  ParsingService.swift
//  Trello
//
//  Created by Preet G S Anand on 11/3/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import Foundation
import SwiftyJSON


class ParsingService {
    static let instance : ParsingService = ParsingService()
    
    func parseLoginDetails(json : JSON) -> User{
        let user = User()
        user.id = json["id"].stringValue
        user.email = json["email"].stringValue
        user.fullname = json["fullName"].stringValue
        user.username = json["username"].stringValue
        return user
    }
    
    func parseBoardList(boardListJSON : [JSON]) -> [Board] {
        var boardList = [Board]()
        for i in 0..<boardListJSON.count {
            boardList.append(parseBoardJSON(boardJSON: boardListJSON[i]))
        }
        return boardList
    }
    
    func parseBoardJSON(boardJSON : JSON) -> Board{
        let board = Board(id : boardJSON["id"].stringValue,
                          name : boardJSON["name"].stringValue,
                          dateLastActivity : stringToDate(dateString : boardJSON["dateLastActivity"].stringValue),
                          backgroundImage : boardJSON["prefs"]["backgroundImage"].stringValue ,
                          backgroundColor : boardJSON["prefs"]["backgroundColor"].stringValue)
        return board
    }
    
    func parseMembershipList(membershipListJSON : [JSON]) -> [Membership] {
        var membershipList = [Membership]()
        for i in 0..<membershipListJSON.count {
            membershipList.append(parseMembership(membershipJSON: membershipListJSON[i]))
        }
        return membershipList
    }
    
    func parseMembership(membershipJSON : JSON) -> Membership {
        let membership = Membership(id : membershipJSON["id"].stringValue,
                                    idMember : membershipJSON["idMember"].stringValue,
                                    memberType : membershipJSON["memberType"].stringValue,
                                    unconfirmed : membershipJSON["uncomfirmed"].boolValue,
                                    deactivated : membershipJSON["deactivated"].boolValue)
        return membership
    }
    
    func parseListListJSON(listListJSON : [JSON]) -> [List]{
        var listList = [List]()
        
        for i in 0..<listListJSON.count {
            listList.append(parseListJSON(listJSON: listListJSON[i]))
        }
        return listList
    }
    
    func parseListJSON(listJSON : JSON) -> List {
        return List(id : listJSON["id"].stringValue,
                    name : listJSON["name"].stringValue,
                    closed : listJSON["closed"].boolValue,
                    idBoard : listJSON["idBoard"].stringValue,
                    pos : listJSON["pod"].intValue,
                    subscribed : listJSON["subscribed"].boolValue)
    }
}
