import Foundation
import CoreData


extension Dish {

    static func createDishesFrom(menuItems:[MenuItem],
                                 _ context:NSManagedObjectContext) {
        for menuItem in menuItems {
            guard !dishExists(name: menuItem.title, in: context) else {
                continue
            }

            let dish = Dish(context: context)
            dish.name = menuItem.title
            dish.price = Float(menuItem.price) ?? 0
        }

        guard context.hasChanges else {
            return
        }

        do {
            try context.save()
        } catch {
            context.rollback()
            print("Unable to save dishes: \(error.localizedDescription)")
        }
    }

    static func dishExists(name: String,
                           in context: NSManagedObjectContext) -> Bool {
        let request = Dish.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        request.fetchLimit = 1

        do {
            return try !context.fetch(request).isEmpty
        } catch {
            print("Unable to check for an existing dish: \(error.localizedDescription)")
            return false
        }
    }
}
