//
//  DelayTask.swift
//  Reminders
//
//  Created by Mohammad Afshar on 14/01/2024.
//

import Foundation

class DelayTask {
    private var seconds: Double
    var dispatchWorkItem: DispatchWorkItem?
    
    init(seconds: Double = 3.0) {
        self.seconds = seconds
    }
    
    func performDelayedTask(_ work: @escaping () -> Void) {
        dispatchWorkItem = DispatchWorkItem {
            work()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: dispatchWorkItem!)
    }
    
    func cancelDelayedTask() {
        dispatchWorkItem?.cancel()
    }
}
