//
//  PhotoMapViewController.swift
//  Photo Map
//
//  Created by Aditya Jayaraman on 3/11/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, LocationsViewControllerDelegate {

    var originalPicture : UIImage?
    var editedPicture: UIImage?
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onCameraButtonTap(sender: UIButton) {
    
        var vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
  
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
            self.originalPicture = info[UIImagePickerControllerOriginalImage] as UIImage
            self.editedPicture = info[UIImagePickerControllerEditedImage] as UIImage
            
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                let locationVC = self.storyboard?.instantiateViewControllerWithIdentifier("LocationsViewController") as LocationsViewController
                locationVC.delegate = self
                self.presentViewController(locationVC, animated: true, completion: nil)
            })
    }
    
    func didFindLocationInfo(sender : LocationsViewController, venue: NSDictionary, lat: NSNumber, lng: NSNumber) {
        
        println("did call delegate")
        sender.dismissViewControllerAnimated(true, completion: { () -> Void in
            let locationCoordinate = CLLocationCoordinate2D(latitude: lat as Double, longitude: lng as Double)
            
            var location = MKPointAnnotation()
            location.coordinate = locationCoordinate
            location.title = "Picture!"
            self.mapView.addAnnotation(location)
            //self.mapView.setCenterCoordinate(locationCoordinate, animated: true)
            let region = MKCoordinateRegionMakeWithDistance(locationCoordinate, 2000, 2000)
            self.mapView.setRegion(region, animated: true)
        })
    }
    

}
