//
//  InitialViewController.swift
//  Rides
//  Created by Subin Kuriakose on 09/02/23.
//

import UIKit

class InitialViewController: UIViewController {
    

    @IBOutlet weak var imgLogo: UIImageView! // To show icon
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpInitialView()
    }
    
    // Setting up the view
    func setUpInitialView(){
       // hideNavbar()
        loadLogo()
    }
    
    //hide Navigation Bar
    func hideNavbar(){
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //Display Logo to the view
    func loadLogo(){
        UIView.animate(withDuration: 1) {
            self.imgLogo.alpha = 1
        } completion: { status in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                UIView.animate(withDuration: 2) {
                    self.imgLogo.alpha = 0
                } completion: { [weak self] status in
                    self?.goToDashboardPage()
                }
            }
        }
        
    }
    
    //Show Dashboard View
    func goToDashboardPage(){
        LandingPageViewController.showLandingViewPage(sourceView: self)
    }
    
   
}
