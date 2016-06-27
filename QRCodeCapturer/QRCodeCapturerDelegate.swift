//
//  QRCodeCapturerDelegate.swift
//  QRCodeCapturer
//
//  Created by Yuri Kasperovich on 6/27/16.
//  Copyright © 2016 Yuri Kasperovich. All rights reserved.
//

import Foundation

protocol QRCodeCapturerDelegate {
  func foundCode(text: String)
}
