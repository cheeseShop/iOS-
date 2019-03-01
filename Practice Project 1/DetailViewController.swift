
import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    //property that has the name of the image to load - needs to be an optional because when the view controller is first created, it wont exist
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedImage
        //dont need to unwrap selectedImage b/c both selectedImage and title are optional strings - assigning one optional to another
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        
        navigationItem.largeTitleDisplayMode = .never
        //ensures only "Storm Viewer" appears big but the detail screen looks normal
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    //used override for both of these b/c they already have defaults defined in UIViewController
    //both use super prefix meaning "tell my parent data type that these methods were called"
    //using navigationController again b/c we were pushed onto the nav controller stack from ViewController
    //accessing the property w/ optional so if somehow we werent in navigation controller hidesBarOnTap will do nothing
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return navigationController?.hidesBarsOnTap ?? false
    }
    //false as the default value if the nav controller isnt present
    //using the nil coalescing operator - if nav controller doesnt exist send back false rather than trying to read its hidesBarsOnTap property
    
    
    
    
    /*

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
