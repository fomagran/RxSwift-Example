//
//  RxJsonApiTableViewController.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/20.
//

import UIKit
import RxSwift
import RxCocoa

let PERSON_LIST_URL = "https://my.api.mockaroo.com/members_with_avatar.json?key=44ce18f0"

class RxJsonApiTableViewController: UITableViewController {

    
    var people:[Person] = []
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPeople()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ [weak self] people in
                
                self?.people = people
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    func loadPeople() -> Observable<[Person]> {
        return Observable.create { emitter -> Disposable in
            let task = URLSession.shared.dataTask(with: URL(string: PERSON_LIST_URL)!) {data,_,error in
                if let error = error {
                    emitter.onError(error)
                    return
                }
                guard let data = data,
                      let people = try? JSONDecoder().decode([Person].self, from: data) else {
                    emitter.onCompleted()
                    return
                }
                emitter.onNext(people)
                emitter.onCompleted()
            }
            task.resume()
            return Disposables.create{
                task.cancel()
            }
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        people.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RxJsonApiTableViewCell") as! RxJsonApiTableViewCell
        
        let item = people[indexPath.row]
        cell.setData(item)
        
        return cell
    }
}


