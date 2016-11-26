--DROP TABLE Restaurant CASCADE;
--DROP TABLE RestaurantMenus CASCADE;
--DROP TABLE Ingredients CASCADE;
--DROP TABLE Dishes CASCADE;
--DROP TABLE RestaurantCuisines;
--DROP TABLE DishIngredients;
--DROP TABLE DietaryViolations;

CREATE Table Restaurant (
    R_ID INTEGER NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE Table RestaurantMenus (
    R_ID INTEGER NOT NULL REFERENCES Restaurant(R_ID),
    M_ID INTEGER NOT NULL,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (M_ID, R_ID)
);

CREATE TABLE RestaurantCuisines (
    R_ID INTEGER NOT NULL REFERENCES Restaurant(R_ID),
    cuisine VARCHAR(50) NOT NULL
);

CREATE TABLE Ingredients (
    I_ID INTEGER NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE Dishes (
    D_ID INTEGER NOT NULL PRIMARY KEY,
    R_ID INTEGER NOT NULL,
    M_ID INTEGER NOT NULL,
    name VARCHAR(100) NOT NULL,
    price double precision NOT NULL CHECK (price > 0),
    rating double precision CHECK (rating >= 0 AND rating <= 5),
    cuisine VARCHAR(50),
    calories INTEGER,
    FOREIGN KEY (M_ID, R_ID) REFERENCES RestaurantMenus(M_ID, R_ID)
);

CREATE TABLE DishIngredients (
    D_ID INTEGER NOT NULL REFERENCES Dishes(D_ID),
    ingredient VARCHAR(50)
);

CREATE TABLE DietaryViolations (
    ingredient VARCHAR(50) NOT NULL,
    diet VARCHAR(50) NOT NULL
);


--Insertion of dummy data
INSERT INTO Restaurant VALUES(1, 'Cafe Edens');

INSERT INTO RestaurantMenus VALUES(1, 1, '24-7 Menu');

INSERT INTO RestaurantCuisines VALUES(1, 'American');
INSERT INTO RestaurantCuisines VALUES(1, 'Mexican');

INSERT INTO Ingredients VALUES(1, 'Dairy');
INSERT INTO Ingredients VALUES(2, 'Eggs');
INSERT INTO Ingredients VALUES(3, 'Fish');
INSERT INTO Ingredients VALUES(4, 'Shellfish');
INSERT INTO Ingredients VALUES(5, 'Tree Nuts');
INSERT INTO Ingredients VALUES(6, 'Peanuts');
INSERT INTO Ingredients VALUES(7, 'Wheat');
INSERT INTO Ingredients VALUES(8, 'Soybeans');

INSERT INTO Dishes VALUES(1, 1, 1, 'Grilled Cheese and...', 6.0, 4.0, 'American', 400);

INSERT INTO DishIngredients VALUES(1, 'Dairy');
INSERT INTO DishIngredients VALUES(1, 'Soybeans');

INSERT INTO DietaryViolations VALUES('Dairy', 'Lactose Intolerant');
INSERT INTO DietaryViolations VALUES('Soybeans', 'Vegan');
