protocol ReloadTopViewControllerDelegate:AnyObject{
    func reloadTopView(categoryIndex:Int?)
    func renameMeigenModel(categoryId:String,newCategoryId:String)
    func removeMeigenModel(categoryId:String)
}
