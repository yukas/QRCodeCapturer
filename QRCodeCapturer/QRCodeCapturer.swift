//
//  QRCodeCapturer.swift
//  QRCodeCapturer
//
//  Created by Yuri Kasperovich on 6/27/16.
//  Copyright © 2016 Yuri Kasperovich. All rights reserved.
//

import AVFoundation

class QRCodeCapturer: NSObject, AVCaptureMetadataOutputObjectsDelegate {
  let bounds: CGRect
  var delegate: QRCodeCapturerDelegate
  var previewLayer: AVCaptureVideoPreviewLayer!
  
  private var captureSession: AVCaptureSession!
  private var previousScannedValue: String?
  
  init(bounds: CGRect, delegate: QRCodeCapturerDelegate) {
    self.bounds   = bounds
    self.delegate = delegate
    
    super.init()
    
    initializeCaptureSession()
    createLayer()
  }
  
  func startCaptureSession() {
    if captureSession.running == false {
      captureSession.startRunning()
    }
  }
  
  func stopCaptureSession() {
    if (captureSession.running == true) {
      captureSession.stopRunning();
    }
  }
  
  // MARK: - AVCaptureMetadataOutputObjectsDelegate
  
  func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
    handleScannedObjects(metadataObjects)
  }
  
  // MARK: - Private
  
  private func initializeCaptureSession() {
    captureSession = AVCaptureSession()
    
    addVideoInput()
    addMetadataOutput()
  }
  
  private func addVideoInput() {
    let videoCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    let videoInput: AVCaptureDeviceInput
    
    do {
      videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
    } catch {
      return
    }
    
    if (captureSession.canAddInput(videoInput)) {
      captureSession.addInput(videoInput)
    }
  }
  
  private func addMetadataOutput() {
    let metadataOutput = AVCaptureMetadataOutput()
    
    if (captureSession.canAddOutput(metadataOutput)) {
      captureSession.addOutput(metadataOutput)
      
      metadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
      metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
    } else {
      return
    }
  }
  
  private func createLayer() {
    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    previewLayer.frame = bounds
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
  }
  
  private func handleScannedObjects(metadataObjects: [AnyObject]!) {
    if let metadataObject = metadataObjects.first {
      let readableObject = metadataObject as! AVMetadataMachineReadableCodeObject;
      
      if readableObject.stringValue != previousScannedValue {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        delegate.foundCode(readableObject.stringValue);
        previousScannedValue = readableObject.stringValue
      }
    }
  }
}