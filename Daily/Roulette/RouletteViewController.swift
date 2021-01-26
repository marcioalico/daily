//
//  RoulletteViewController.swift
//  Daily
//
//  Created by Marcio Alico on 1/26/21.
//

import Foundation
import UIKit

class RouletteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var counter: UILabel!
    @IBOutlet weak var choseNextButton: UIButton!
    
    var rouletteables: [Rouletteable] = []
    var indexSelected = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setUpUI()
        addMockData()
        setUpTableView()
    }
    
    private func setUpUI() {
        loaderView.isHidden = true
        container.rounded()
        tableView.rounded()
        loaderView.rounded()
        loaderView.layer.borderWidth = 0.3
        loaderView.layer.borderColor = UIColor.systemBlue.cgColor
        choseNextButton.rounded()
    }
    
    private func addMockData() {
        let marie: Rouletteable = Rouletteable.init(name: "Marie")
        let paulo: Rouletteable = Rouletteable.init(name: "Paulo")
        let eze: Rouletteable = Rouletteable.init(name: "Eze")
        let coco: Rouletteable = Rouletteable.init(name: "Coco")
        let diablo: Rouletteable = Rouletteable.init(name: "Diablo")
        let marcio: Rouletteable = Rouletteable.init(name: "Marcio")
        let guille: Rouletteable = Rouletteable.init(name: "Guille")
        let fede: Rouletteable = Rouletteable.init(name: "Fede")
        rouletteables.append(eze)
        rouletteables.append(coco)
        rouletteables.append(diablo)
        rouletteables.append(marie)
        rouletteables.append(guille)
        rouletteables.append(marcio)
        rouletteables.append(fede)
        rouletteables.append(paulo)
        
        rouletteables.shuffle()
    }
    
    @IBAction func addRouletteable() {
        let alertController = UIAlertController(title: "Disculpá!", message: "Nos habíamos olvidado de vos..", preferredStyle: UIAlertController.Style.alert)
        
        let saveAction = UIAlertAction(title: "Guardar", style: UIAlertAction.Style.default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            guard let newName = firstTextField.text else { return }
            let newRoulettable: Rouletteable = Rouletteable.init(name: newName)
            self.rouletteables.append(newRoulettable)
            self.reloadTableView()
        })
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.default, handler: {
                                            (action : UIAlertAction!) -> Void in })
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Tu nombre?"
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func chooseNext() {
        startAnimation() { flag in
            self.removeSelected()
            if self.rouletteables.count == 0 {
                self.goToParroquiales()
            } else {
                let number = Int.random(in: 0..<self.rouletteables.count)
                self.indexSelected = number
                self.reloadTableView()
            }
        }
    }
    
    private func removeSelected() {
        if indexSelected != -1 {
            rouletteables.remove(at: indexSelected)
        }
    }
    
    private func startAnimation(completion: @escaping (Bool) -> Void) {
        self.counter.text = "3"
        self.loaderView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.counter.text = "2"
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.counter.text = "1"
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.loaderView.isHidden = true
                    completion(true)
                }
            }
        }
    }
    
    private func goToParroquiales() {
        let alertController = UIAlertController(title: "Momento de Parroquiales", message: "", preferredStyle: UIAlertController.Style.alert)
        
        let parroquialesAction = UIAlertAction(title: "Listo!", style: UIAlertAction.Style.default, handler: { alert -> Void in
            self.goToAtomos()
        })
        alertController.addAction(parroquialesAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func goToAtomos() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AtomosViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func setUpTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "RouletteableTableViewCell", bundle: nil), forCellReuseIdentifier: "RouletteableTableViewCell")
    }
    
}

extension RouletteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rouletteables.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rouletteable = rouletteables[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "RouletteableTableViewCell") as! RouletteableTableViewCell
        
        if indexPath.row == indexSelected {
            cell.backgroundColor = .systemBlue
            cell.nameLabel.textColor = .white
        } else {
            cell.backgroundColor = .clear
            cell.nameLabel.textColor = .black
        }
        
        cell.nameLabel.text = rouletteable.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}
