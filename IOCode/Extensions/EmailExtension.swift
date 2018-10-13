//
//  EmailExtension.swift
//  Sweet Dreams App
//
//  Created by Uladzislau Daratsiuk on 6/20/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

extension MainVC: MFMailComposeViewControllerDelegate {
    
    @objc public func sendEmail(){
        let mailComposeViewController = configureMailController()
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposeViewController, animated: true, completion: nil)
        }else{
            showMailError()}
    }
    @objc public func configureMailController()-> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["uladzislau.daratsiuk@gmail.com"])
        mailComposerVC.setSubject("Hi Developer ")
        mailComposerVC.setMessageBody("Hi Developer,", isHTML: false)
        
        return mailComposerVC
    }
    
    @objc public func showMailError(){
        
        let sendMailErrorAlert = UIAlertController (title: "Could not send email", message: "Your device could not send email", preferredStyle: .alert)
        let dismiss = UIAlertAction(title:"OK",style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
        
    }
    
    
    @objc public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil )
    }
}
