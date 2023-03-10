//
//  VehicleDetailPageViewController.swift
//  Rides
//
//  Created by Subin Kuriakose on 12/02/23.
/* On the Vehicle Details screen display the following returned from the API:
 
 vin
 make_and_model
 color
 car_type */

import UIKit

class VehicleDetailPageViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var collectionVehicleDetails: UICollectionView!
    @IBOutlet weak var pageTItleLabel: PageHeaderLabel!
    static let storyboardName:String = "VehicleDetail"
    static let storyBoardId:String = "VehicleDetailPageViewController"
    
    var vehicleDetails:VechicleListPresentModal = VechicleListPresentModal() // FROM VEHICLE LIST PAGE
    var viewModel:VehicleDetailsPageViewModal = VehicleDetailsPageViewModal()
    
    // MARK: -  VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
  
        self.initView()
        self.initVM()
    }
    
    // MARK: - INITIAL VIEW LOAD
    
    private func initView(){
        self.enableSwipeBackGesture()
        self.registerVehicleDetailCell()

    }
    
    // MARK: - INITIAL VIEW MODEL
    
    private func initVM(){
        
        
        self.setDataSourceToViewModal()
        self.setPageTitle()
        self.viewModel.showVehicleDetails() //TO GET VEHICLE DETAILS FROM VIEW MODAL
    
        self.viewModel.reloadCollectionViewClosure = { [weak self] () in

            DispatchQueue.main.async {
                self?.collectionVehicleDetails.reloadData()
            }
        }
    }
    
    // MARK: - PRIVATE METHODS
    
    private func enableSwipeBackGesture(){
        navigationController?.interactivePopGestureRecognizer?.delegate = self
           navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    private func registerVehicleDetailCell(){
        collectionVehicleDetails.register(VehicleDetailCollectionViewCell.nib, forCellWithReuseIdentifier: VehicleDetailCollectionViewCell.identifier)
    }
    private func setDataSourceToViewModal(){
        self.viewModel.setDataSource(item: self.vehicleDetails)
    }
    private func setPageTitle(){
        self.pageTItleLabel.text = self.viewModel.getPageHeader()
    }
  
    
    // MARK: - SHOW VEHICLE DETAIL PAGE
    
    
    class func showVehicleDetailViewPage(sourceView:UIViewController,vehicleDetails:VechicleListPresentModal){
        let storyboard = UIStoryboard(name: VehicleDetailPageViewController.storyboardName, bundle: nil)
        let detailViewVC:VehicleDetailPageViewController = storyboard.instantiateViewController(withIdentifier: VehicleDetailPageViewController.storyBoardId) as! VehicleDetailPageViewController
        // sourceView.navigationController?.isNavigationBarHidden = true
        detailViewVC.vehicleDetails = vehicleDetails
        sourceView.navigationController?.pushViewController(detailViewVC, animated: true)
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
// MARK: - COLLECTION VIEW  DATA SOURCE AND DELEGATES

extension VehicleDetailPageViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       
        return self.viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.totalSections
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == VehicleDetailPageSection.vehicleDetails.rawValue {
            
            guard let cell = collectionVehicleDetails.dequeueReusableCell(withReuseIdentifier:VehicleDetailCollectionViewCell.identifier, for: indexPath) as? VehicleDetailCollectionViewCell else {
                fatalError("dequeued wrong cell")
            }
            cell.setCellItem(item: self.viewModel.vehicleDetails)

            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15.0, left: 10.0, bottom: 15.0, right: 10.0)//here your custom value for spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width:self.collectionVehicleDetails.frame.width+100, height:collectionVehicleDetails.frame.height)
    }
    
}


