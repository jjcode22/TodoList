
import UIKit
import RealmSwift
 
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
 
    var window: UIWindow?
 
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        print(Realm.Configuration.defaultConfiguration.fileURL)
//        print(Realm.Configuration.defaultConfiguration.encryptionKey)
        
      
        do{
            _ = try Realm()
            
        }catch{
            print("Error initalizing new realm: \(error)")
        }
        
        return true
    }
 
 

}
