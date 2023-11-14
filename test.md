```mermaid
erDiagram
    CUSTOMER ||--o{ ORDER : places
    ORDER ||--|{ LINE-ITEM : contains
    CUSTOMER ||--o{ ADDRESS : "has"
    ADDRESS ||--o{ ORDER : "sends to"
    PRODUCT ||--o{ LINE-ITEM : "includes"
    PRODUCT {
        int id
        string name
        float price
    }
    CUSTOMER {
        int id
        string name
        string email
    }
    ORDER {
        int id
        date orderDate
        int customerId
    }
    LINE-ITEM {
        int orderId
        int productId
        int quantity
        float totalPrice
    }
    ADDRESS {
        int id
        string street
        string city
        string state
        string country
        string postalCode
    }
