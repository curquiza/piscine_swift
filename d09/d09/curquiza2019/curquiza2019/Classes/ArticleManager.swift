
import CoreData


public class ArticleManager: NSObject {
    
    override public init() {
        super.init()
    }

    let entityName = "Article"
    let modelName = "article"
    
    
    // INIT COREDATA FROM SCRATCH --------------------------------------------------
    
    private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        // Initialize Managed Object Context
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        // Configure Managed Object Context
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        
        return managedObjectContext
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        // Throw fatal error if model does not exist
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }

        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }

        return managedObjectModel
    }()

    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"
        
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: nil)
        } catch {
            fatalError("Unable to Load Persistent Store")
        }
        
        return persistentStoreCoordinator
    }()

    
    // PUBLIC FUNCTIONS -------------------------------------------------------------
    
    public func newArticle() -> Article {
        print("function newArticle")
        let newArticleObject = NSEntityDescription.insertNewObject(forEntityName: self.entityName, into: managedObjectContext) as! Article
        return newArticleObject
    }
    
    public func getAllArticles() -> [Article] {
        print("function getAllArticles")
        let articlesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)
        var fetchedArticles: [Article] = []
        do {
            fetchedArticles = try managedObjectContext.fetch(articlesFetch) as! [Article]
        } catch {
            fatalError("Failed to fetch articles: \(error)")
        }
        return fetchedArticles
    }
    
    public func getArticles(withLang lang : String) -> [Article] {
        print("function getArticles with filter LANG")
        let articlesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)
        articlesFetch.predicate = NSPredicate(format: "language == %@", lang)
        var fetchedArticles: [Article] = []
        do {
            fetchedArticles = try managedObjectContext.fetch(articlesFetch) as! [Article]
        } catch {
            fatalError("Failed to fetch articles: \(error)")
        }
        return fetchedArticles
    }
    
    public func getArticles(containString str : String) -> [Article] {
        print("function getArticles with filter STR")
        let articlesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)
        articlesFetch.predicate = NSPredicate(format: "(content CONTAINS %@) OR (title CONTAINS %@)", str, str)
        var fetchedArticles: [Article] = []
        do {
            fetchedArticles = try managedObjectContext.fetch(articlesFetch) as! [Article]
        } catch {
            fatalError("Failed to fetch articles: \(error)")
        }
        return fetchedArticles
    }
    
    public func removeArticle(article : Article) {
        print("function removeArticle")
        managedObjectContext.delete(article)
    }
    
    public func save() {
        print("function save")
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }

}
