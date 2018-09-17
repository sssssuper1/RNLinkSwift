//
//  SensorsTrainer.swift
//  RNLinkSwift
//
//  Created by Edison on 2018/9/14.
//  Copyright © 2018年 Facebook. All rights reserved.
//

import Foundation
import SwiftySensors
import SwiftySensorsTrainers

@objc(SensorTrainer)
class SensorTrainer: NSObject {
  private var sensors : [Sensor] = []
  
  @objc func scan() {
    SensorManager.instance.setServicesToScanFor([
      CyclingPowerService.self])
    
    SensorManager.instance.addServiceTypes([
      DeviceInformationService.self])
    
    SensorManager.instance.state = .aggressiveScan
    
    SensorManager.logSensorMessage = { message in
      print(message)
    }
  }
  
  @objc func setDiscoveredObserver(callBack: @escaping ((String, Int) -> Void )) {
    SensorManager.instance.onSensorDiscovered.subscribe(on: self) { [weak self] sensor in
      guard let s = self else {return}
      if !s.sensors.contains(sensor) {
        s.sensors.append(sensor)
        callBack(sensor.peripheral.name ?? "", s.sensors.index(of: sensor)!)
      }
    }
  }
  
  @objc func setConnectedObserver(callBack: @escaping (() -> Void )) {
    SensorManager.instance.onSensorConnected.subscribe(on: self) { sensor in
      if sensor.peripheral.state == .connected {
        callBack()
      }
    }
  }
  
  @objc func connect(to: Int) {
    if to >= sensors.count { return }
    
    let sensor = sensors[to]
    
    if sensor.peripheral.state == .connected {
      SensorManager.instance.disconnectFromSensor(sensor)
    } else if sensor.peripheral.state == .disconnected {
      SensorManager.instance.connectToSensor(sensor)
    }
  }
}
