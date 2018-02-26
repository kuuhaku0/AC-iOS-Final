//
//  AuthUserService.swift
//  Hype Post App
//
//  Created by C4Q on 2/1/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import Firebase

@objc protocol AuthUserServiceDelegate: class {
    
    //Create user delegate protocols
    @objc optional func didFailCreatingUser(_ userService: AuthUserService, error: Error)
    
    //Sign out delegate protocols
    @objc optional func didFailSigningOut(_ userService: AuthUserService, error: Error)
    @objc optional func didSignOut(_ userService: AuthUserService)
    
    //Sign in de()legate protocols
    @objc optional func didFailSigningIn(_ userService: AuthUserService, error: Error)
}


class AuthUserService: NSObject {
    private override init() {
        super.init()
        self.auth = Auth.auth()
    }
    static let manager = AuthUserService()
    
    
    weak public var delegate: AuthUserServiceDelegate?
    private var auth: Auth!
    public static func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }

    public func signOut() {
        do {
            try Auth.auth().signOut()
            delegate?.didSignOut?(self)
        } catch {
            delegate?.didFailSigningOut?(self, error: error)
        }
    }
}
