//
//  DataService.swift
//  OTUSHM3
//
//  Created by Дмитрий Мальцев on 09.01.2022.
//

import CoreData

public class DataService<Entity: NSManagedObject> {
    private let container: NSPersistentContainer
    private var containerName: String
    private var entityName: String
    
    public init(containerName: String, entityName: String) {
        self.containerName = containerName
        self.entityName = entityName
        
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
        }
    }
    
    // MARK: PUBLIC
    public func add(operation: (Entity) -> ()) {
        let entity = Entity(context: container.viewContext)
        operation(entity)
        save()
    }
    
    public func update(entity: Entity, operation: (Entity) -> ()) {
        operation(entity)
        save()
    }
    
    public func remove(entity: Entity) {
        container.viewContext.delete(entity)
        save()
    }
    
    public func fetch() -> [Entity] {
        let request = NSFetchRequest<Entity>(entityName: entityName)
        var savedEntities: [Entity] = []
        do {
            savedEntities =  try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Entity. \(error)")
        }
        return savedEntities
    }
    
    // MARK: PRIVATE
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data. \(error)")
        }
    }

}
