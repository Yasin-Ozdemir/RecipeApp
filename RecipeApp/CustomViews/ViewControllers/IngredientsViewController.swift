//
//  IngredientsViewController.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 30.09.2024.
//

import UIKit
import SnapKit
class IngredientsViewController: UIViewController {
  // var stackViews = [UIStackView]()
    var items = [IngredientItem]()
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    convenience init(meal : [String : String?]) {
        self.init(nibName: nil, bundle: nil)
        self.setupVC(with: meal)
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupVC(with meal : [String : String?]){
        
        SizeConstants.ingredientHeiht = 0
        for i in 1...20 {
            
            if meal["strIngredient\(i)"] != "" , let ingredient = meal["strIngredient\(i)"] as? String , let measure = meal["strMeasure\(i)"] as? String{
               /* let label = BodyLabel(align: .left, size: 13, color: .label)
                
                label.text = "\(measure) \(ingredient)"
                let image = FoodImageView(frame: .zero)
                image.downloadImage(url: "https://www.themealdb.com/images/ingredients/\(ingredient)-Small.png")
                
              
                stackViews.append(UIStackView(arrangedSubviews: [image , label]))
                */
                
                let item = IngredientItem(imageUrl: "https://www.themealdb.com/images/ingredients/\(ingredient)-Small.png", ingredientName: measure + "  " + ingredient)
                self.items.append(item)
            }
        }
        self.view.layer.cornerRadius = 10
        self.view.backgroundColor = .secondarySystemBackground
        SizeConstants.ingredientHeiht = 10  + items.count * 5 + items.count * 20
        applyConstraints()
    }
    func applyConstraints(){
        /*
        var padding = 5

        for stackView in stackViews {
            stackView.axis = .horizontal
         
            stackView.distribution = .fillProportionally
            stackView.alignment = .center
            self.view.addSubview(stackView)
            stackView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(padding)
                make.leading.equalToSuperview().inset(10)
                make.trailing.equalToSuperview().inset(10)
                make.height.equalTo(15)
            }
            padding += 19
        }
        
        self.stackViews.removeAll()*/
        var padding = 5
        for item in items {
            self.view.addSubview(item)
            item.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(10)
                make.trailing.equalToSuperview().inset(10)
                make.top.equalToSuperview().offset(padding)
                make.height.equalTo(20)
            }
            padding += 25
        }
    }
}


