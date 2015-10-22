require "spec_helper"

describe FarMar::Sale do
  before :each do
    @sale = FarMar::Sale.new("1", "120", "2013-11-11 11:29:52 -0800", "2", "123")
    @all_sales = FarMar::Sale.all
  end
  describe ".new" do
    it "creates a new instance of sale" do
      expect(@sale).to be_an_instance_of FarMar::Sale
    end
  end
  describe "#id" do
    it "returns unique id for the sale" do
      expect(@sale.id).to eq 1
    end
  end
  describe "#amount" do
    it "returns the amount for the sale" do
      expect(@sale.amount).to eq 120
    end
  end
  describe "#purchase_time" do
    it "returns the purchase time for the sale that is a Datetime" do
      expect(@sale.purchase_time).to be_a(DateTime)
    end
  end
  describe "#vendor_id" do
    it "returns the vendor id for the sale" do
      expect(@sale.vendor_id).to eq 2
    end
  end
  describe "#product_id" do
    it "returns the product id for the sale" do
      expect(@sale.product_id).to eq 123
    end
  end
  describe "self.all" do
    it "creates an array" do
      expect(@all_sales).to be_an Array
    end
    it "elements are instances of FarMar::Sale" do
      expect(@all_sales[0]).to be_an_instance_of FarMar::Sale
    end
    it "creates a product for each row in the csv file" do
      expect(@all_sales.length).to eq 12798
    end
  end
  describe "self.find(id)" do
    it "returns an instance of sale with the passed id" do
      sale_100 = FarMar::Sale.find(100)
      expect(sale_100).to be_an_instance_of FarMar::Sale
      expect(sale_100.id).to eq 100
    end
  end
  describe "#vendor" do
    it "returns the vendor associated with the sale" do
      sale = FarMar::Sale.new("25","4951","2013-11-09 23:42:41 -0800","5","9")
      expect(sale.vendor).to be_an_instance_of FarMar::Vendor
      expect(sale.vendor.id).to be 5
    end
  end
  describe "#product" do
    it "returns the product associated with the sale" do
      sale = FarMar::Sale.new("27","2851","2013-11-13 04:14:40 -0800","5","10")
      expect(sale.product).to be_an_instance_of FarMar::Product
      expect(sale.product.id).to be 10
    end
  end
  describe "self.between(beginning_time, end_time)" do
    it "returns a collection of sales in the given time range" do
      sales_range = FarMar::Sale.between("2013-11-06 14:55:25 -0800", "2013-11-08 06:49:47 -0800")
      expect(sales_range).to be_an Array
      expect(sales_range[2]).to be_an_instance_of FarMar::Sale
      expect(sales_range.min_by { |sale| sale.purchase_time }.purchase_time).to eq DateTime.parse("2013-11-06 14:55:25 -0800")
      expect(sales_range.max_by { |sale| sale.purchase_time }.purchase_time).to eq DateTime.parse("2013-11-08 06:49:47 -0800")
    end
  end
end
