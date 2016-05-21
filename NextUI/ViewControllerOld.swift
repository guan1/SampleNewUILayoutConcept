import UIKit




class ViewControllerOld: UIViewController {
    
    var label : UILabel!
    var label2 : UILabel!
    var parent : UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        parent = UIView()
        view.addSubview(parent)
        
        
        label = UILabel()
        label.frame = CGRectZero
        label.backgroundColor = UIColor.blueColor()
        label.text = "xxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxxxxx xxx xxx"
        label.numberOfLines=0
        label.sizeToFit()
        parent.addSubview(label)
        
        label2 = UILabel()
        label2.frame = CGRectZero
        label2.backgroundColor = UIColor.redColor()
        label2.text = "xxx222"
        label2.sizeToFit()
        parent.addSubview(label2)
        
        
      
        
        // Do anyvarditional setup after loading the view, typically from a nib.
    }
    
    
    
    enum RealEstateStyles : String {
        case Container = "Container"
        case ScrollView = "ScrollView"
        case Title = "Title"
        case Description = "Description"
        case Separator = "Separator"
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        //basicFlexbox()
        //simpleNewUI()
        
        
        
    }
   
    
    
    
    
    func simpleNewUI() {
        
        
        let node1 = Node(size: CGSizeMake(300, 500),
                         childAlignment: .Center,
                         direction: .Row,
                         
                         children: [
                            Node(flex: 1,
                                children: [
                                    Node(flex: 1,
                                        size: CGSizeMake(100, 50)),
                                    Node(flex: 1,
                                        measure: {
                                            (f: CGFloat) -> CGSize in
                                            return CGSizeMake(f, 1)
                                    }),
                                    Node(flex: 1, size: CGSizeMake(100, 50))]
                            )
            ])
        
        let layout1 = node1.layout()
        
        let parent1 = UIView(style: "Container", height: 200, children: [
            UIScrollView(style: "ScrollView", children: [
                UILabel(style: "Title", title: "Text"),
                UIView(style: "Separator", height: 1),
                UILabel(style: "Description", title: "Description")
                
                ])
            ])
        
        self.view.addSubview(parent1)
        
        parent1.backgroundColor = UIColor.lightGrayColor()
        
        layout1.apply(parent1)
    }
    
    func basicFlexbox() {
        let node = Node(size: CGSizeMake(300, 500),
                        childAlignment: .Center,
                        padding: Edges(right: 5),
                        margin: Edges(left: 5),
                        direction: .Row,
                        
                        children: [
                            Node(flex: 1,
                                padding: Edges(right: 5),
                                margin: Edges(right: 5),
                                measure: {
                                    (f: CGFloat) -> CGSize in
                                    return CGSizeMake(f, self.label.frame.size.height)
                            }),
                            Node(flex: 1, measure: {
                                (f: CGFloat) -> CGSize in
                                return CGSizeMake(f, self.label2.frame.size.height)
                            }),
            ])
        
        let layout = node.layout()
        
        print(layout)
        
        parent.backgroundColor=UIColor.lightGrayColor()
        
        //  layout.apply(self.parent)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}