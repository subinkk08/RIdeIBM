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

final class VehicleDetailPageViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: -  OUTLETS
    @IBOutlet weak var collectionVehicleDetails: UICollectionView!
    @IBOutlet weak var pageIndicator: UIPageControl!
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
       // self.enableSwipeBackGesture()
        self.registerVehicleDetailCell()
        self.registerEmissionDetailCell()
        self.setupPageIndicatory()
    }
    
    // MARK: - INITIAL VIEW MODEL
    private func initVM(){
        self.setDataSourceToViewModal()
        self.setNavigationBarTitle()
        self.viewModel.showVehicleDetails() //TO GET VEHICLE DETAILS FROM VIEW MODAL
        self.viewModel.reloadCollectionViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.collectionVehicleDetails.reloadData()
            }
        }
    }
    
    // MARK: - PRIVATE METHODS
    private func setNavigationBarTitle(){
        self.navigationItem.title =  self.viewModel.getPageHeaderTitle()
    }
    
    private func setupPageIndicatory(){
        self.pageIndicator.numberOfPages = self.viewModel.getPageIndicatroCount()
        self.pageIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.pageIndicator.currentPageIndicatorTintColor = UIColor.orange
        self.pageIndicator.pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.8)
    }
    
    private func registerVehicleDetailCell(){
        collectionVehicleDetails.register(VehicleDetailCollectionViewCell.nib, forCellWithReuseIdentifier: VehicleDetailCollectionViewCell.identifier)
    }
    
    private func registerEmissionDetailCell(){
        collectionVehicleDetails.register(EmissionDetailsCollectionViewCell.nib, forCellWithReuseIdentifier: EmissionDetailsCollectionViewCell.identifier)
    }
    
    private func setDataSourceToViewModal(){
        self.viewModel.setDataSource(item: self.vehicleDetails)
    }
  
    // MARK: - SHOW VEHICLE DETAIL PAGE
    class func showVehicleDetailViewPage(
        sourceView:UIViewController,
        vehicleDetails:VechicleListPresentModal){
        let storyboard = UIStoryboard(name: VehicleDetailPageViewController.storyboardName, bundle: nil)
        let detailViewVC:VehicleDetailPageViewController = storyboard.instantiateViewController(withIdentifier: VehicleDetailPageViewController.storyBoardId) as! VehicleDetailPageViewController
        // sourceView.navigationController?.isNavigationBarHidden = true
        detailViewVC.vehicleDetails = vehicleDetails
        sourceView.navigationController?.pushViewController(detailViewVC, animated: true)
    }
}

// MARK: - COLLECTION VIEW  DATA SOURCE AND DELEGATES
extension VehicleDetailPageViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.getNumberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == VehicleDetailPageSection.vehicleDetails.rawValue {
            guard let cell = collectionVehicleDetails.dequeueReusableCell(withReuseIdentifier:VehicleDetailCollectionViewCell.identifier, for: indexPath) as? VehicleDetailCollectionViewCell else {
                fatalError("dequeued wrong cell")
            }
            cell.setCellItem(item: self.viewModel.vehicleDetails)
            return cell
        }
        else{
            guard let cell = collectionVehicleDetails.dequeueReusableCell(withReuseIdentifier:EmissionDetailsCollectionViewCell.identifier, for: indexPath) as? EmissionDetailsCollectionViewCell else {
                fatalError("dequeued wrong cell")
            }
            cell.setCellItem(item: self.viewModel.emissionDetails)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15.0, left: 10.0, bottom: 15.0, right: 10.0)//here your custom value for spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == VehicleDetailPageSection.vehicleDetails.rawValue {
        return CGSize(width:self.collectionVehicleDetails.frame.width, height:collectionVehicleDetails.frame.height)
       }
        else{
            return CGSize(width:self.collectionVehicleDetails.frame.width, height:collectionVehicleDetails.frame.height)
        }
    }
}

extension VehicleDetailPageViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.pageIndicator.currentPage = Int(
            (collectionVehicleDetails.contentOffset.x / collectionVehicleDetails.frame.width)
                .rounded(.toNearestOrAwayFromZero)
            )
    }
}
