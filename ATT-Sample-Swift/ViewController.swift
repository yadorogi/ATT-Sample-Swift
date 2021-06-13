//
//  ViewController.swift
//  ATT-Sample-Swift
//
//  Created by Tetsuo Kawakami on 2021/06/13.
//

import UIKit
import AdSupport
import AppTrackingTransparency

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if #available(iOS 14, *) {
            switch ATTrackingManager.trackingAuthorizationStatus {
            case .authorized:
                print("Allow Tracking")
                print("IDFA: \(ASIdentifierManager.shared().advertisingIdentifier)")
            case .denied:
                print("denied")
            case .restricted:
                print("restricted")
            case .notDetermined:
                showRequestTrackingAuthorizationAlert()
            @unknown default:
                fatalError()
            }
        } else {// iOS13 or lower
            if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
                print("Allow Tracking")
                print("IDFA: \(ASIdentifierManager.shared().advertisingIdentifier)")
            } else {
                print("Limit Tracking")
            }
        }
    }

    //　Show Alert dialog
    private func showRequestTrackingAuthorizationAlert() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                switch status {
                case .authorized:
                    print("authorized")
                    // Get IDFA
                    print("IDFA: \(ASIdentifierManager.shared().advertisingIdentifier)")
                case .denied, .restricted, .notDetermined:
                    print("not authorized")
                @unknown default:
                    fatalError()
                }
            })
        }
    }
}

