-- Create relation
CREATE TABLE Store(
    Store_ID NUMBER NOT NULL,
    Address VARCHAR(50) NOT NULL,
    Food_Category VARCHAR(10) NOT NULL,
    Store_Name VARCHAR(20) NOT NULL,
    Phone_Number VARCHAR(13) NOT NULL,
    Description VARCHAR(100),
    Delivery_Fee NUMBER NOT NULL,
    Image VARCHAR(10),
    Business_Hour NUMBER NOT NULL,
    PRIMARY KEY(Store_ID)
    UNIQUE(Address)
);

CREATE TABLE Menu(
    Menu_ID NUMBER NOT NULL,
    Store_ID NUMBER NOT NULL,
    Mname VARCHAR(15) NOT NULL,
    Description VARCHAR(100),
    Image VARCHAR(10),
    Price NUMBER NOT NULL,
    PRIMARY KEY(Menu_ID)
);

CREATE TABLE Department(
    Dname VARCHAR(15) NOT NULL,
    PRIMARY KEY(Dname)
);

CREATE TABLE User(
    User_ID NUMBER NOT NULL,
    User_Name VARCHAR(15) NOT NULL, --추가
    Dname VARCHAR(15) NOT NULL,
    Password VARCHAR(10) NOT NULL,
    Phone_Number VARCHAR(13) NOT NULL,
    Membership_Tier VARCHAR(5) NOT NULL, --이거 derived로 하면?
    PRIMARY KEY(User_ID)
    UNIQUE(Phone_Number)
);

CREATE TABLE User_Address(
    User_ID NUMBER NOT NULL,
    UAddress VARCHAR(50) NOT NULL,
    PRIMARY KEY(User_ID, UAddress)
);

CREATE TABLE Coupon(
    Coupon_ID NUMBER NOT NULL,
    User_ID NUMBER NOT NULL,
    Discount_Amount VARCHAR(5) NOT NULL,
    Expiration_Date DATE NOT NULL,
    Minimum_Order_Amount VARCHAR(10) NOT NULL,
    State VARCHAR(5) NOT NULL,
    PRIMARY KEY(Coupon_ID)
);

CREATE TABLE Review(
    Review_ID NUMBER NOT NULL,
    User_ID NUMBER NOT NULL,
    Store_ID NUMBER NOT NULL,
    Star_Rating NUMBER NOT NULL,
    Comment VARCHAR(100),
    Created_At DATE NOT NULL,
    PRIMARY KEY(Review_ID)
);

CREATE TABLE Order(
    Order_ID NUMBER NOT NULL,
    User_ID NUMBER NOT NULL,
    Store_ID NUMBER NOT NULL,
    Payment VARCHAR(5) NOT NULL,
    State VARCHAR(5) NOT NULL,
    Order_Date DATE NOT NULL,
    PRIMARY KEY(Order_ID)
);

CREATE TABLE Order_Menu(
    Order_Menu_ID NUMBER NOT NULL,
    Order_ID NUMBER NOT NULL,
    Menu_Name VARCHAR(15) NOT NULL,
    Menu_Image VARCHAR(10),
    Menu_Price NUMBER NOT NULL,
    Quantity NUMBER NOT NULL,
    PRIMARY KEY(Order_Menu_ID, Menu_Name)
);

CREATE TABLE Contains(
    Menu_ID NUMBER NOT NULL,
    Review_ID NUMBER NOT NULL,
    PRIMARY KEY(Menu_ID, Review_ID)
);

CREATE TABLE Cooperates(
    Store_ID NUMBER NOT NULL,
    Dname VARCHAR(15) NOT NULL,
    PRIMARY KEY(Store_ID, Dname)
);

-- foreign key
ALTER TABLE Menu ADD FOREIGN KEY (Store_ID) REFERENCES Store(Store_ID)
ON DELETE CASCADE;

ALTER TABLE Cooperates ADD FOREIGN KEY (Store_ID) REFERENCES Store(Store_ID)
ON DELETE CASCADE;

ALTER TABLE Review ADD FOREIGN KEY (Store_ID) REFERENCES Store(Store_ID)
ON DELETE CASCADE;

ALTER TABLE Order ADD FOREIGN KEY (Store_ID) REFERENCES Store(Store_ID)
ON DELETE SET NULL;

ALTER TABLE Contains ADD FOREIGN KEY (Order_Menu_ID) REFERENCES Order_Menu(Order_Menu_ID);

ALTER TABLE User ADD FOREIGN KEY (Dname) REFERENCES Department(Dname)
ON DELETE SET NULL;

ALTER TABLE Cooperates ADD FOREIGN KEY (Dname) REFERENCES Department(Dname)
ON DELETE SET NULL;

ALTER TABLE Order ADD FOREIGN KEY (User_ID) REFERENCES User(User_ID);

ALTER TABLE Review ADD FOREIGN KEY (User_ID) REFERENCES User(User_ID);

ALTER TABLE Coupon ADD FOREIGN KEY (User_ID) REFERENCES User(User_ID);

ALTER TABLE User_Address ADD FOREIGN KEY (User_ID) REFERENCES User(User_ID)
ON DELETE CASCADE;

ALTER TABLE Contains ADD FOREIGN KEY (Review_ID) REFERENCES Review(Review_ID)
ON DELETE CASCADE;

ALTER TABLE Order_Menu ADD FOREIGN KEY (Order_ID) REFERENCES Order(Order_ID)
ON DELETE CASCADE;