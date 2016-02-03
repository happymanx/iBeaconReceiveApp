import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  let locationManager = CLLocationManager()
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    let notificationType:UIUserNotificationType = [UIUserNotificationType.Sound, UIUserNotificationType.Alert]
    let notificationSettings = UIUserNotificationSettings(forTypes: notificationType, categories: nil)
    UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
    
    locationManager.delegate = self
    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSUserDefaults.standardUserDefaults().synchronize()
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
}

// MARK: CLLocationManagerDelegate
extension AppDelegate: CLLocationManagerDelegate {
  func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
    if let beaconRegion = region as? CLBeaconRegion {
      let notification = UILocalNotification()
      notification.alertBody = "Are you forgetting something?"
      notification.soundName = "Default"
      UIApplication.sharedApplication().presentLocalNotificationNow(notification)
        
        load_image("https://cg2010studio.files.wordpress.com/2015/12/stackview.png?w=540&h=545")
        load_data("http://maps.googleapis.com/maps/api/geocode/json?latlng=25.0477709,121.5315472")
    }
  }
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if let beaconRegion = region as? CLBeaconRegion {
            let notification = UILocalNotification()
            notification.alertBody = "Great, Happy Object comes back"
            notification.soundName = "Default"
            UIApplication.sharedApplication().presentLocalNotificationNow(notification)
            
            load_image("https://cg2010studio.files.wordpress.com/2016/01/e59c96e8a7a3e4b88be99baae88887e4b88be99cb0-snow-and-sleet.gif?w=540")
            load_data("http://maps.googleapis.com/maps/api/geocode/json?latlng=25.0477709,121.5315472")
        }
    }
    
    func load_image(urlString:String)
    {
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            var test = UIImage(data: NSData(contentsOfURL: NSURL(string:urlString)!)!)
            print(test)
        })
    }
    
    func load_data(urlString:String)
    {
        let url = NSURL(string: urlString)!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let paramString = ""
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = session.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error")
                return
            }
            
            let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(dataString)
            
        }
        
        task.resume()
    }
}


