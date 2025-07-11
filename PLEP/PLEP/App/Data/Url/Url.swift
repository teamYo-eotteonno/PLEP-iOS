//
//  Url.swift
//  PLEP
//
//  Created by 이다경 on 7/5/25.
//

import SwiftUI

struct PLEPURL {
    static let url = "http://plep.shop:3000/api/v1"
    
    static let admin = "\(url)/admin/users"
    
    enum Admin {
        static let addUsers = admin
        static let getUsers = admin
        static func getUsers(id: String) -> String {
            return "\(admin)/\(id)"
        }
        static func editUsers(id: String) -> String {
            return "\(admin)/\(id)"
        }
        static func deleteUsers(id: String) -> String {
            return "\(admin)/\(id)"
        }
    }
    
    static let users = "\(url)/users"
    
    enum Users {
        static let editUsersPhoto = "\(users)/photo"
        static let editUsersName = "\(users)/name"
        static let editUsersBio = "\(users)/bio"
        static func getUsers(id: String) -> String {
            return "\(users)/\(id)"
        }
    }
    
    static let files = "\(url)/files"
    
    enum Files {
        static let uploadFiles = "\(files)/upload"
    }
    
    static let auth = "\(url)/auth"
    
    enum Auth {
        static let login = "\(auth)/email/login"
        static let join = "\(auth)/email/register"
        static let getPassword = "\(auth)/forgot/password"
        static let resetPassword = "\(auth)/reset/password"
        static let getMe = "\(auth)/me"
        static let editMe = "\(auth)/me"
        static let deleteMe = "\(auth)/me"
        static let refresh = "\(auth)/refresh"
        static let logout = "\(auth)/logout"
    }
    
    enum Email {
        static let code = "\(auth)/code"
    }
    
    static let follow = "\(users)/follow"
    
    enum Follow {
        static func addFollow(followingId: Int) -> String {
            return "\(follow)/\(followingId)"
        }
        static func deleteFollow(followingId: Int) -> String {
            return "\(follow)/\(followingId)"
        }
        static func getFollowers(userId: Int) -> String {
            return "\(follow)ers/\(userId)"
        }
        static func getFollowings(userId: Int) -> String {
            return "\(follow)ers/\(userId)"
        }
        static func getFollows(userId: Int) -> String {
            return "\(follow)s/\(userId)"
        }
    }
    
    static let feeds = "\(url)/feeds"
    
    enum Feeds {
        static let addFeeds = feeds
        static let getFeeds = feeds
        static let addPlaceCount = "\(feeds)/place/count"
        static func getFeeds(feedId: Int) -> String {
            return "\(feeds)/\(feedId)"
        }
        static func editFeeds(feedId: Int) -> String {
            return "\(feeds)/\(feedId)"
        }
        static func deleteFeeds(feedId: Int) -> String {
            return "\(feeds)/\(feedId)"
        }
    }
    
    static let groups = "\(url)/groups"
    
    enum Groups {
        static let addGroups = groups
        static let getGroups = groups
        static func editGroups(groupId: Int) -> String {
            return "\(groups)/\(groupId)"
        }
        static func deleteGroups(groupId: Int) -> String {
            return "\(groups)/\(groupId)"
        }
    }
    
    static let schedules = "\(url)/schedules"
    
    enum Schedules {
        static func addSchedules(groupId: Int) -> String {
            return "\(schedules)/\(groupId)"
        }
        static let getSchedules = schedules
        static func editSchedules(scheduleId: Int) -> String {
            return "\(schedules)/\(scheduleId)"
        }
        static func deleteSchedules(scheduleId: Int) -> String {
            return "\(schedules)/\(scheduleId)"
        }
    }
    
    static let timetables = "\(url)/timetables"
    
    enum Timetables {
        static func addTimetables(scheduleId: Int) -> String {
            return "\(timetables)/\(scheduleId)"
        }
        static func getTimetables(scheduleId: Int) -> String {
            return "\(timetables)/\(scheduleId)"
        }
        static func editCheckTimetables(timetableId: Int) -> String {
            return "\(timetables)/check/\(timetableId)"
        }
        static func editUncheckCheckTimetables(timetableId: Int) -> String {
            return "\(timetables)/uncheck/\(timetableId)"
        }
        static func editTimetables(timetableId: Int) -> String {
            return "\(timetables)/\(timetableId)"
        }
        static func deleteTimetables(timetableId: Int) -> String {
            return "\(timetables)/\(timetableId)"
        }
    }
    
    static let rooms = "\(url)/rooms"
    
    enum Rooms {
        static let addRooms = rooms
        static let getRooms = rooms
        static func joinRooms(roomId: Int) -> String {
            return "\(rooms)/join/\(roomId)"
        }
        static func kickUser(userId: Int) -> String {
            return "\(rooms)/kick/\(userId)"
        }
        static let leaveRooms = "\(rooms)/leave"
    }
    
    static let shares = "\(url)/shares"
    
    enum Shares {
        static let addShares = shares
        static let getShares = shares
        static let editShares = shares
        static let deleteShares = shares
    }
}
