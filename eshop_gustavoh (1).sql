CREATE DATABASE eshop;
USE eshop;

-- criação das entidades

CREATE TABLE users(
	-- vantagem: ja altera o valor do último valor na tabela do id
	userID         INT NOT NULL AUTO_INCREMENT,
    name           VARCHAR(40) NOT NULL,
    phoneNumber    VARCHAR(12),
    PRIMARY KEY(userID)
);

CREATE TABLE buyer(
	userId         INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(userID),
    FOREIGN KEY(userID) REFERENCES users(userID)
);

CREATE TABLE seller(
	userId         INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(userID),
    FOREIGN KEY(userID) REFERENCES users(userID)
);

CREATE TABLE bankCard(
	pk_cardNumber    CHAR(16) NOT NULL,
    expiryDate       DATE NOT NULL,
    bank             VARCHAR(20),
    PRIMARY KEY(pk_cardNumber)
);

CREATE TABLE creditCard(
	pk_cardNumber    CHAR(16) NOT NULL,
    fk_userID        INT NOT NULL,
    organization     VARCHAR(50),
    
    PRIMARY KEY(pk_cardNumber, fk_userID),
    FOREIGN KEY(pk_cardNumber) REFERENCES bankCard(pk_cardNumber),
    FOREIGN KEY(fk_userID) REFERENCES users(userID)
);

CREATE TABLE debitCard(
	pk_cardNumber    CHAR(16) NOT NULL,
    fk_userID        INT NOT NULL,
    organization     VARCHAR(50),
    
    PRIMARY KEY(pk_cardNumber, fk_userID),
    FOREIGN KEY(pk_cardNumber) REFERENCES bankCard(pk_cardNumber),
    FOREIGN KEY(fk_userID) REFERENCES users(userID)
);

CREATE TABLE store(
	pk_sid           INT NOT NULL,
    name             VARCHAR(50) NOT NULL,
    province         VARCHAR(50) NOT NULL,
    city             VARCHAR(40) NOT NULL,
    streetaddr       VARCHAR(20),
    customerGrade    INT,
	startTime        DATE,
    
    PRIMARY KEY(pk_sid)
);

CREATE TABLE brand(
	pk_brandName VARCHAR(50) NOT NULL PRIMARY KEY
);

CREATE TABLE Product(
	pk_pid          INT NOT NULL,
    fk_sid          INT NOT NULL,
    fk_brandName    VARCHAR(50) NOT NULL,
    name            VARCHAR(120) NOT NULL,
    type            VARCHAR(50),
    modelNumber     VARCHAR(50) UNIQUE,
    color           VARCHAR(20),
	amount          INT DEFAULT NULL,
	price           DECIMAL(6, 2) NOT NULL,
    
    PRIMARY KEY(pk_pid),
    FOREIGN KEY(fk_sid) REFERENCES store(pk_sid),
    FOREIGN KEY(fk_brandName) REFERENCES brand(pk_brandName)
);

CREATE TABLE orderItem(
	pk_itemID       INT NOT NULL AUTO_INCREMENT,
    fk_pid          INT NOT NULL,
    price           DECIMAL(6, 2),
    creationTime    DATE NOT NULL, 
    
    PRIMARY KEY(pk_itemID),
    FOREIGN KEY(fk_pid) REFERENCES product(pk_pid)
);

CREATE TABLE Orders(
	pk_orderNumber    INT NOT NULL,
    payment_state     ENUM('Paid', 'Unpaid'),
    creation_time     DATE NOT NULL,
    totalAmount       DECIMAL(10, 2),
    PRIMARY KEY(pk_orderNumber)
);


CREATE TABLE address(
	pk_addID INT NOT NULL AUTO_INCREMENT,
    fk_userID INT NOT NULL,
    name VARCHAR(50),
    contactPhoneNumber VARCHAR(20),
    province VARCHAR(100),
    city VARCHAR(100),
	streetaddr varchar(100),
    postcode VARCHAR(12),
    
    PRIMARY KEY(pk_addID),
    FOREIGN KEY(fk_userID) REFERENCES users(userID)
);

CREATE TABLE comments(
	creationTime DATE NOT NULL,
    fk_userID INT NOT NULL,
    fk_pid INT NOT NULL,
    grade float,
    content VARCHAR(500),
    
    PRIMARY KEY(creationTime, fk_userID, fk_pid),
    FOREIGN KEY(fk_userID) REFERENCES users(userID),
    FOREIGN KEY(fk_pid) REFERENCES product(pk_pid)
);

CREATE TABLE servicePoint(
	pk_spid INT NOT NULL,
    streetaddr VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    province VARCHAR(50),
    startTime VARCHAR(20),
    endTime VARCHAR(20),
    
    PRIMARY KEY(pk_spid)
);

CREATE TABLE save_to_Shopping_Cart(
	fk_userID	INT NOT NULL,
    fk_pid 		INT NOT NULL,
    addTime		DATE NOT NULL,
    quantity 	INT,
    
    PRIMARY KEY(fk_userID, fk_pid),
    FOREIGN KEY(fk_userID) REFERENCES buyer(userID),
    FOREIGN KEY(fk_pid) REFERENCES product(pk_pid)
);

CREATE TABLE Contain(
	fk_orderNumber	INT NOT NULL,
    fk_itemID		INT NOT NULL,
    quantity		INT,
    
    PRIMARY KEY(fk_orderNumber, fk_itemID),
    FOREIGN KEY(fk_orderNumber) REFERENCES Orders(pk_orderNumber),
    FOREIGN KEY(fk_itemID) REFERENCES orderItem(pk_itemID)
);

CREATE TABLE payment(
	fk_orderNumber		INT NOT NULL,
    fk_bankCard			VARCHAR(25) NOT NULL,
    payTime				DATE,
    
    PRIMARY KEY(fk_orderNumber, fk_bankCard),
    FOREIGN KEY(fk_orderNumber) REFERENCES Orders(pk_orderNumber),
    FOREIGN KEY(fk_bankCard) REFERENCES bankCard(pk_cardNumber)
);

CREATE TABLE deliver_To(
	fk_addID		INT NOT NULL,
    fk_orderNumber	INT NOT NULL,
    TimeDelivered	DATE,
    
    PRIMARY KEY(fk_addID, fk_orderNumber),
    FOREIGN KEY(fk_addID) REFERENCES address(pk_addID),
    FOREIGN KEY(fk_orderNumber) REFERENCES  Orders(pk_orderNumber)
);

 

CREATE TABLE manage (
    fk_userID             INT NOT NULL,
    fk_sid                 INT NOT NULL,
    setUpTime             DATE,
    
    PRIMARY KEY(fk_userID,fk_sid),
    FOREIGN KEY(fk_userID) REFERENCES seller(userID),
    FOREIGN KEY(fk_sid) REFERENCES store (pk_sid)
);

 

CREATE TABLE After_Sales_Service_At(
    fk_brandName         VARCHAR(20) NOT NULL,
    fk_spid             INT NOT NULL,
    
    PRIMARY KEY(fk_brandName, fk_spid),
    FOREIGN KEY(fk_brandName) REFERENCES brand (pk_brandName),
    FOREIGN KEY(fk_spid) REFERENCES servicePoint(pk_spid)
);