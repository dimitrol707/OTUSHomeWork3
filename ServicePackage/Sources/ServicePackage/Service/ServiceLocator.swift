//
//  ServiceLocator.swift
//  OTUSHM3
//
//  Created by Дмитрий Мальцев on 28.12.2021.
//

public class ServiceLocator {
    public static var shared = ServiceLocator()
    
    public lazy var services: [String: AnyObject] = {
        return [String:AnyObject]()
    }()
    
    public func addServices<T:AnyObject>(service: T) {
        let key = String(describing: T.self)
        if services[key] == nil {
            services[key] = service
        }
    }
    
    public func getService<T:AnyObject>(type: T.Type)->T? {
        let key = String(describing: type)
        return services[key] as? T
    }
}
