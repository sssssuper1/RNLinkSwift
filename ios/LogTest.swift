//
//  LogTest.swift
//  RNLinkSwift
//
//  Created by Edison on 2018/9/14.
//  Copyright © 2018年 Facebook. All rights reserved.
//
import Foundation

@objc(RNManager) //@objc关键字,用于将方法或对象暴露给OC,以供OC调用访问
class RNManager: NSObject {
  @objc func testCall() {
    print("Hi i am here ====>>> \(#function)")
  }
}
