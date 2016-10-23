//
//  ShutterSpeed.swift
//  CameraBuddy
//
//  Created by Alex Koumparos on 2016-10-23.
//  Copyright © 2016 Koumparos Software. All rights reserved.
//

import Foundation

struct ShutterSpeed {
    
    let name: String
    let seconds: Double
    
}


let shutterSpeeds = [
    ShutterSpeed(name: "4000", seconds: 1/4000),
    ShutterSpeed(name: "2000", seconds: 1/2000),
    ShutterSpeed(name: "1000", seconds: 1/1000),
    ShutterSpeed(name: "500", seconds: 1/500),
    ShutterSpeed(name: "250", seconds: 1/250),
    ShutterSpeed(name: "125", seconds: 1/125),
    ShutterSpeed(name: "60", seconds: 1/60),
    ShutterSpeed(name: "30", seconds: 1/30),
    ShutterSpeed(name: "15", seconds: 1/15),
    ShutterSpeed(name: "12", seconds: 1/12),
    ShutterSpeed(name: "10", seconds: 1/10),
    ShutterSpeed(name: "8", seconds: 1/8),
    ShutterSpeed(name: "5", seconds: 1/5),
    ShutterSpeed(name: "4", seconds: 1/4),
    ShutterSpeed(name: "3", seconds: 1/3),
    ShutterSpeed(name: "2", seconds: 1/2),
    ShutterSpeed(name: "1s", seconds: 1),
    ShutterSpeed(name: "2s", seconds: 2),
    ShutterSpeed(name: "4s", seconds: 4),
    ShutterSpeed(name: "5s", seconds: 5),
    ShutterSpeed(name: "10s", seconds: 10)
    
]

var shutterA = ShutterSpeed(name: "1s", seconds: 1)
var shutterB = ShutterSpeed(name: "1s", seconds: 1)
