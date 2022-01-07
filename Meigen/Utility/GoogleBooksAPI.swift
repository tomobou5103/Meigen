
import Foundation
import Alamofire

final class GoogleBooksAPI{
    static let shared = GoogleBooksAPI()
    private init(){}
    
    private let baseUrl = "https://www.googleapis.com/books/v1/volumes?q="
    
    internal func receiveBooksData(textValue:String,completion:@escaping(BooksModel)->Void){
        let encodeKeyword: String = textValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = baseUrl+encodeKeyword
        AF.request(url).response{ response in
            guard let data = response.data else{return}
            let model:BooksModel? = try? JSONDecoder().decode(BooksModel.self,from: data)
            guard let booksModel = model else{return}
            completion(booksModel)
        }
    }
}
