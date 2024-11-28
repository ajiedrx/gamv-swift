//
//  States.swift
//  gamv
//
//  Created by Ajie DR on 17/11/24.
//

import Foundation

enum ViewState<Success, Failure> where Failure : Error {
    case idle
    case loading
    case success(Success)
    case failure(Failure)
}
