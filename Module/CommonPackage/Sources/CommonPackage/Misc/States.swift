//
//  States.swift
//  gamv
//
//  Created by Ajie DR on 17/11/24.
//

import Foundation

public enum ViewState<Success, CommonError> {
    case idle
    case loading
    case success(Success)
    case failure(CommonError)
}
