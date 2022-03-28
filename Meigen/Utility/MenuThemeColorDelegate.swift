protocol MenuViewControllerDelegate:AnyObject{
    func reloadTopView(categoryIndex:Int?)
    func renameMeigenModel(categoryId:String,newCategoryId:String)
    func removeMeigenModel(categoryId:String)
}
protocol ThemeColorViewControllerDelegate:AnyObject{
    func reloadTopView()
}
