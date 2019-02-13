

import UIKit

class ViewController: UITableViewController {
    //property declared outside of viewDidLoad  so that it will exist as long as our screen exists
    var pictures = [String]()
    
    
    //method w/ override means we want to change Apple's default behavior from UIViewController
    //viewDidLoad is called when the screen has loaded and is ready for you to customize
    override func viewDidLoad() {
        super.viewDidLoad()
        //super means "tell Apple's UIViewController to run its own code before mine
        
        title = "Storm Viewer"
        
        let fm = FileManager.default
        //FileManager is a data type that lets us work with the filesystem
        let path = Bundle.main.resourcePath!
        //constant path that is set to the resource path of our app's bundle
        //can use optional unwrapping b/c we are sure this will never return nil 
        let items  = try! fm.contentsOfDirectory(atPath: path)
        //items is set to the contents of the directory at a path (in this case the path we declared above)
        
        for item in items {
            if item.hasPrefix("nssl"){
                pictures.append(item)
            }
        }
        
       navigationController?.navigationBar.prefersLargeTitles = true
        
    print(pictures) //print here used for testing 
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    //if didnt use override then it would say there are no rows
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        //above line allows iOS to recycle existing cells
        cell.textLabel?.text = pictures[indexPath.row]
        //this gives the text label of the cell the same text as a picture in our array
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            //2: success! set its selectedImage property
            vc.selectedImage = pictures[indexPath.row]
            
            //3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}

