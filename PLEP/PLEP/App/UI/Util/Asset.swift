//
//  Asset.swift
//  PLEP
//
//  Created by 이다경 on 4/7/25.
//

class Asset{
    static let flag = "Flag"
    
    struct Plane {
        static let fall = "Plane-Fall"
        static let rise = "Plane-Rise"
    }
    
    struct Loke {
        static let `default` = "Loke-Default"
        static let start = "Loke-Start"
        static let travel = "Loke-Travel"
    }
    
    struct Way {
        static let `default` = "Way-Default"
        static let start = "Way-Start"
        static let travel = "Way-Travel"
    }
    
    struct Calendar {
        static let `default` = "Calendar"
        static let tap = "Calendar-Tap"
    }
    
    struct Home {
        static let `default` = "Home"
        static let tap = "Home-Tap"
    }
    
    struct Profile {
        static let `default` = "Profile"
        static let tap = "Profile-Tap"
    }
    
    struct Search {
        static let `default` = "Search"
        static let tap = "Search-Tap"
    }
    
    struct Sun {
        static let `default` = "Sun"
        static let tap = "Sun-Tap"
    }
    
    static let camera = "Camera"
    
    struct Heart {
        static let `default` = "Heart"
        static let tap = "Heart-Tap"
    }
    
    struct Address {
        static let `default` = "Address"
        static let add = "Address-Add"
        static let bigadd = "Address-Add-Big"
    }
    
    static let call = "Call"
    
    static let url = "Url"
    
    static let gps = "Gps"
    
    static let travel = "Loke_Way_Travel"
    
    static let magic = "Magic"
    
    struct User {
        struct Users {
            static let `default` = "Users"
            static let color = "Users-Color"
        }
        
        struct Add {
            static let `default` = "User-Add"
            
            struct Circle {
                static let `default` = "User-Circle-Add"
                static let big = "User-Circle-Add-Big"
            }
        }
    }
    
    static let crown = "Crown"
    
    struct Share {
        static let target = "Share-Target"
        static let kakao = "Share-Kakao"
        static let discord = "Share-Discord"
        static let email = "Share-Email"
    }
    
    static let link = "Link"
    
    static let more = "More"
    
    static let trash = "Trash"
}
