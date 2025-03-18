package entity;

public class OrderRes {
    private int orderId;
    private String customerName;
    private String orderDate;
    private double totalPrice;
    private String status;

    public OrderRes(int orderId, String customerName, String orderDate, double totalPrice, String status) {
        this.orderId = orderId;
        this.customerName = customerName;
        this.orderDate = orderDate;
        this.totalPrice = totalPrice;
        this.status = status;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "OrderRes [orderId=" + orderId + ", customerName=" + customerName + ", orderDate=" + orderDate
                + ", totalPrice=" + totalPrice + ", status=" + status + "]";
    }

    
}
