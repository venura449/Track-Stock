package admin;

public class Product {
    private int id;
    private String name;
    private String category;
    private String qty;
    private String price;

    // Constructors
    public Product() {}

    public Product(int id, String name, String category) {
        this.id = id;
        this.name = name;
        this.category = category;
    }
    
    //construct to handle AddProduct in ProductServelet
    public Product(String name,String category,String qty,String price) {
        this.name = name;
        this.category = category;
        this.setQty(qty);
        this.setPrice(price);
    }
    
    public Product(int id,String name,String category,String qty,String price) {
        this.id = id;
    	this.name = name;
        this.category = category;
        this.setQty(qty);
        this.setPrice(price);
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    // toString for debugging
    @Override
    public String toString() {
        return "Product [id=" + id + ", name=" + name + ", category=" + category + "]";
    }

	public String getQty() {
		return qty;
	}

	public void setQty(String qty) {
		this.qty = qty;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}
}
