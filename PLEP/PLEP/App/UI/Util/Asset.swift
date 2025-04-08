//
//  Asset.swift
//  PLEP
//
//  Created by 이다경 on 4/7/25.
//

class Asset{
    struct Character {
        static let loke = "Loke"
        static let way = "Way"
    }
    struct Logo {
        static let `default` = "Logo-Purple"
        static let dark = "Logo-Black"
        static let light = "Logo-White"
    }
    struct Join {
        static let first = "User-Tag-White"
        static let id = "User-Cirlce-Add-White"
        static let pass = "Password-Check-White"
        static let email = "Sms-Edit-White"
        static let profile = "User-Edit-White"
        static let camera = "Camera-White"
    }
    struct LogIn {
        static let id = "User-Gray"
        static let pass = "Password-Check-Gray"
        struct passcheck {
            static let open = "Eye-Gray"
            static let close = "Eye-Slash-Gray"
        }
    }
    struct Calendar {
        static let `default` = "Calendar-Dark"
        static let choice = "Calendar-Purple"
    }
    struct Home {
        static let `default` = "Home-Dark"
        static let choice = "Home-Purple"
    }
    struct Profile {
        static let `default` = "Profile-Circle-Dark"
        static let choice = "Profile-Circle-Purple"
    }
    struct Search {
        static let `default` = "Search-Normal-Dark"
        static let choice = "Search-Normal-Purple"
    }
    struct Sun {
        static let `default` = "Sun-Dark"
        static let choice = "Sun-Purple"
    }
}
