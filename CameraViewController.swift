//
//  CameraViewController.swift
//  Skweez 2
//
//  Created by Tilliss, Seth on 1/23/17.
//  Copyright © 2017 Tilliss, Seth. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    @IBOutlet weak var imageView: UIImageView!
    var newMedia: Bool?
    
    /*@IBAction func openEditor(_ sender: AnyObject)
    {
        var imageEditorViewController = ImageEditorViewController(imageView: imageView )
        imageEditorViewController.pushViewController
    }*/
    
    @IBAction func useCamera(_ sender: AnyObject)
    {
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.camera)
        {
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType =
                UIImagePickerControllerSourceType.camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true,
                         completion: nil)
            newMedia = true
        }
    }
    
    @IBAction func useCameraRoll(_ sender: AnyObject)
    {
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.savedPhotosAlbum)
        {
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType =
                UIImagePickerControllerSourceType.photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true,
                         completion: nil)
            newMedia = false
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        self.dismiss(animated: true, completion: nil)
        
        if mediaType.isEqual(to: kUTTypeImage as String)
        {
            let image = info[UIImagePickerControllerOriginalImage]
                as! UIImage
            
            imageView.image = image
            
            if (newMedia == true)
            {
                UIImageWriteToSavedPhotosAlbum(image, self,
                                               #selector(CameraViewController.image(image:didFinishSavingWithError:contextInfo:)), nil)
            } else if mediaType.isEqual(to: kUTTypeMovie as String) {

            }
            
        }
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafeRawPointer)
    {
        
        if error != nil
        {
            let alert = UIAlertController(title: "Save Failed",
             message: "Failed to save image",
             preferredStyle: UIAlertControllerStyle.alert)
             
             let cancelAction = UIAlertAction(title: "OK",
             style: .cancel, handler: nil)
             
             alert.addAction(cancelAction)
             self.present(alert, animated: true,
             completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*func prepareForSegue(segue: UIStoryboardSegue, sender:AnyObject?)
    {
        let destViewController: ImageEditorViewController = segue.destination as! ImageEditorViewController
        
        destViewController.imageView = imageView.image
    }*/
 }
