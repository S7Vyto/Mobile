//
//  AsyncOperation.swift
//  SVNewsletter
//
//  Created by Sam on 23/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import UIKit
import SwiftyJSON

typealias OperationCompletionBlock = ([NewsEntity]) -> Void

class AsyncOperation: Operation {
    enum State: String {
        case isReady, isFinished, isExecuting
    }
    
    var state = State.isReady {
        willSet {
            willChangeValue(forKey: state.rawValue)
            willChangeValue(forKey: newValue.rawValue)
        }
        didSet {
            didChangeValue(forKey: oldValue.rawValue)
            didChangeValue(forKey: state.rawValue)
        }
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override var isExecuting: Bool {
        return state == State.isExecuting
    }
    
    override var isFinished: Bool {
        return state == State.isFinished
    }
    
    let data: [JSON]
    let finishBlock: OperationCompletionBlock
    
    required init(data: [JSON], _ finishBlock: @escaping OperationCompletionBlock) {
        self.data = data
        self.finishBlock = finishBlock
        super.init()
        
        self.name = "SVNewsletter::ParsingData"
        self.queuePriority = .high
        self.qualityOfService = .userInitiated
    }
    
    override func start() {
        guard !isCancelled else {
            state = .isFinished
            return
        }
        
        state = .isReady
        main()
    }
}
