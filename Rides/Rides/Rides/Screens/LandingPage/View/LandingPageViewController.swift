//
//  LandingPageViewController.swift
//  Rides
//
//  Created by Subin Kuriakose on 09/02/23.
// To display Random Vehicle list

import Foundation
import UIKit


final class LandingPageViewController: UIViewController{
    
    // MARK: -  OUTLETS
    @IBOutlet weak var pageTitleLbl: UILabel!
    @IBOutlet weak var activityController: UIActivityIndicatorView!
    @IBOutlet weak var noDataImage: UIImageView!
    @IBOutlet weak var randomVcountTxtField: UITextField!
    @IBOutlet weak var vehicleListTableView: UITableView!
    @IBOutlet weak var sortBySegmentControl: UISegmentedControl!
    @IBOutlet weak var sortControlView: UIView!
    @IBOutlet weak var SearchButtonView: UIView!
    
    static let storyboardName:String = "LandingPageView"
    static let storyBoardId:String = "LandingPageViewController"
    private let viewModel = VehicleListViewModal()
        
    // MARK: -  VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initView()
        self.initVM()
    }
    
    // MARK: - INITIAL VIEW SETTERS
    private func initView(){
        self.registerCharecterCell()
        self.setPageTitle(name: AppConstants.VehicleListpageTitle)
        self.setUpKeyboardGestures()
        self.SetUpVehicleSortSegmentControl()
        self.activityIndicator(hidden: true)
        self.setupPlaceholderTextForSearchTextField()
        self.setupPulltoRefresh()
        self.setSearchButtonRoundView()
        self.setTextFieldDelegate()
    }
    
    // MARK: - METHODS
    private func activityIndicator(hidden:Bool){
        self.activityController.isHidden = hidden
    }
    
    private func setTextFieldDelegate(){
        self.randomVcountTxtField.delegate = self
    }
    
    private func setSearchButtonRoundView(){
        SearchButtonView.layer.cornerRadius = 10.0
    }
    
    private func SetUpVehicleSortSegmentControl() {
        self.setSortNameList()
        sortBySegmentControl.addTarget(self, action: #selector(LandingPageViewController.segmentedControlValueChanged(_:)), for: .allEvents)
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        self.viewModel.sortVehicleListBySegmentControl(value: self.sortBySegmentControl.selectedSegmentIndex)
    }
    
    private func registerCharecterCell(){
        vehicleListTableView.register(VehicleListTableViewCell.nib, forCellReuseIdentifier: VehicleListTableViewCell.identifier)
    }
    
    private func setPageTitle(name:String){
        self.pageTitleLbl.text = name
    }
    
    private func setSortNameList(){
        let sortNameList = viewModel.getSortNameList()
        self.sortBySegmentControl.setTitle(sortNameList[0], forSegmentAt: 0)
        self.sortBySegmentControl.setTitle(sortNameList[1], forSegmentAt: 1)
    }
    
    private func setupPulltoRefresh(){
        vehicleListTableView.refreshControl = UIRefreshControl()
        vehicleListTableView.refreshControl?.addTarget(self,
                                                       action: #selector(pullToRefresh), for: .valueChanged)
    }
    
    @objc func pullToRefresh() {
        self.fetchVehicleDetails()
    }
    
    // MARK: - VIEWMODAL CLOSURE INIT
    private func initVM() {
        
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert( message )
                }
            }
        }
        
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                
                // SHOW ACTIVITY CONTROLL
                if isLoading {
                    self?.activityIndicator(hidden: false)
                    self?.activityController.startAnimating()
                    UIView.animate(withDuration: AppConstants.vehicleListTableViewAnimateDuration, animations: {
                        self?.vehicleListTableView.alpha = vehicleListTableViewAlpha.hide.rawValue
                        self?.sortControlView.alpha = vehicleListTableViewAlpha.hide.rawValue
                    })
                }else {
                    // HIDE ACTIVITY CONTROLL
                    self?.activityController.stopAnimating()
                    UIView.animate(withDuration: AppConstants.vehicleListTableViewAnimateDuration, animations: {
                        self?.vehicleListTableView.alpha = vehicleListTableViewAlpha.show.rawValue
                        self?.sortControlView.alpha = vehicleListTableViewAlpha.show.rawValue
                        self?.activityIndicator(hidden: true)
                    })
                }
            }
        }

        // MARK: RELOAD TABLE VIEW
        //  DATA COMMUNICATE BETWEEN VIEWMODAL TO VIEW USING THIS CLOSURE METHODS
        
        viewModel.reloadTableViewClosure = { [weak self] () in
           
            if let listCount = self?.viewModel.numberOfCells {
                self?.showTableView(isShow: (listCount > 0))
                self?.showSortView(isShow: (listCount > 0))
                self?.showNoDataImage(isShow: (listCount > 0))
            }
            
            DispatchQueue.main.async {
                self?.vehicleListTableView.refreshControl?.endRefreshing()
                self?.vehicleListTableView.reloadData()
            }
        }
    }
    
    // HIDE/SHOW NO DATA IMAGE BASED ON LIST ITEMS
    private func showNoDataImage(isShow:Bool){
        DispatchQueue.main.async {
            self.noDataImage.isHidden = isShow
        }
    }
    
    // HIDE/SHOW TABLEVIEW
    private  func showTableView(isShow:Bool){
        DispatchQueue.main.async {
            self.vehicleListTableView.isHidden = !isShow
        }
    }

    // HIDE/SHOW SORTCONTROLL
    private  func showSortView(isShow:Bool){
        DispatchQueue.main.async {
            self.sortControlView.isHidden = !isShow
        }
        
    }
    
    // SETUP PLACE HOLDER TEXT
    private func setupPlaceholderTextForSearchTextField (){
        self.randomVcountTxtField.attributedPlaceholder =  NSAttributedString(
            string: AppConstants.vehicleCountPlaceholderText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "VehicleTextFieldPlaceHolder") ?? UIColor.gray]
        )
    }
    
    // SETUP KEYBOARD GESTURES
    private func setUpKeyboardGestures(){
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    // SHOW API RESPONSE ALERT
    private  func showAlert( _ message: String ) {
        let alert = UIAlertController(title: AppConstants.appName, message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: AppConstants.alertOk, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - SEARCH BUTTON TAPPED
    @IBAction func searchRandomVehicleTapped(_ sender: Any) {
        self.fetchVehicleDetails()
    }

    // MARK: - FETCH VEHICLE LIST
    private func fetchVehicleDetails(){
        self.view.endEditing(true)
        if let size = randomVcountTxtField.text {
            self.viewModel.getVehicleList(size: size)
        }
    }

    // MARK: -  SHOW LANDING PAGE METHOD
    class func showLandingViewPage(sourceView:UIViewController){
        let storyboard = UIStoryboard(name: LandingPageViewController.storyboardName, bundle: nil)
        let LandingPageVC:LandingPageViewController = storyboard.instantiateViewController(withIdentifier: LandingPageViewController.storyBoardId) as! LandingPageViewController
        // sourceView.navigationController?.isNavigationBarHidden = true
        sourceView.navigationController?.pushViewController(LandingPageVC, animated: true)
    }
}

// MARK: -  TABLEVIEW DELEGATE  DATASOURCE
extension LandingPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VehicleListTableViewCell.identifier, for: indexPath) as? VehicleListTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        let cellVM = viewModel.getCellViewModel( at: indexPath )
        cell.setCellItem(item: cellVM)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedVehicleDetails = self.viewModel.getCellViewModel(at: indexPath)
        
        VehicleDetailPageViewController.showVehicleDetailViewPage(sourceView: self, vehicleDetails: selectedVehicleDetails)
    }

}

extension LandingPageViewController :UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

enum vehicleListTableViewAlpha:Double{
    case show = 1.0
    case hide = 0.0
}
