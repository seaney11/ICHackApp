//
//  SecondViewController.swift
//  IC_Hack20_StudentApp
//
//  Created by Sean McGuire on 09/02/2020.
//  Copyright © 2020 Zoë Despature. All rights reserved.
//

import UIKit
import ARKit

class SecondViewController: UIViewController {
    
    @IBOutlet
    var textView: UITextView!

    @IBOutlet
    var image: UIImageView!
    
    var imageHidden = true
    
    var ip: String = ""
    var port: Int = 0
    
    var inputStream: InputStream!
    var outputStream: OutputStream!

    //2
    var transcript = ""

    //3
    let maxReadLength = 4096
    
    func setupNetworkCommunication() {
      // 1
      var readStream: Unmanaged<CFReadStream>?
      var writeStream: Unmanaged<CFWriteStream>?

      // 2
      CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault,
                                         "192.168.43.182" as CFString,
                                         8888,
                                         &readStream,
                                         &writeStream)
        
        inputStream = readStream!.takeRetainedValue()
        outputStream = writeStream!.takeRetainedValue()
        inputStream.delegate = self
        inputStream.schedule(in: .current, forMode: .common)
        outputStream.schedule(in: .current, forMode: .common)
    
        inputStream.open()
        outputStream.open()
    }

    
    override func viewDidLoad() {
        setupNetworkCommunication()
    }
//        super.viewDidLoad()
//        func setupScene() {
//            let scene = SCNScene()
//            sceneView.scene = scene
//        }
//
//        func setupConfiguration() {
//            let configuration = ARWorldTrackingConfiguration()
//            sceneView.session.run(configuration)
//        }
//        let client = TCPClient(address: "192.168.43.148", port: 50010)
//        switch client.connect(timeout: 1) {
//          case .success:
//            print("wohooo")
//          case .failure(let error):
//            print(error)
//        }
//        // Do any additional setup after loading the view.
//    }
    
//    private let configuration = ARWorldTrackingConfiguration()
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        self.ARWindow.showStatistics = true
//        self.ARWindow.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
//    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.ARWindow.session.run(configuration)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.ARWindow.session.pause()
//    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}

extension SecondViewController: StreamDelegate {
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
        case .hasBytesAvailable:
          print("new message received")
          readAvailableBytes(stream: aStream as! InputStream)
        case .endEncountered:
          print("new message received")
        case .errorOccurred:
          print("error occurred")
        case .hasSpaceAvailable:
          print("has space available")
        default:
          print("some other event...")
        }
    }
    
    private func readAvailableBytes(stream: InputStream) {
      //1
      let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: maxReadLength)
        var length = 0

      //2
      while stream.hasBytesAvailable {
        //3
        let numberOfBytesRead = inputStream.read(buffer, maxLength: maxReadLength)

        //4
        if numberOfBytesRead < 0, let error = stream.streamError {
          print(error)
          break
        }
        length += numberOfBytesRead
      }
        var msg = String(
          bytesNoCopy: buffer,
          length: length,
          encoding: .utf8,
          freeWhenDone: true) ?? ""
        if (msg.starts(with: "1")){
            imageHidden = !imageHidden
            image.isHidden = imageHidden
            textView.frame.size.height = imageHidden ? 1072 : 700
        }
        if (msg.starts(with: "0")){
            msg = ""
        }
        transcript += msg
        textView.text = transcript
    }
}
