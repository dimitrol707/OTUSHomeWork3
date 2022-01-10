//
//  InjectedWrapped.swift
//  OTUSHM3
//
//  Created by Дмитрий Мальцев on 09.01.2022.
//

@propertyWrapper
public struct Injected<T: AnyObject> {
    private var service: T?
    private weak var serviceManager = ServiceLocator.shared
   
    public init() {}
    
    public var wrappedValue: T? {
        mutating get {
            if service == nil {
                service =  serviceManager?.getService(type: T.self)
            }
            return service
        }
        mutating set {
            service = newValue
        }
    }
    
    public var projectedValue:Injected<T> {
        get {return self}
        mutating set {self = newValue}
    }
}
