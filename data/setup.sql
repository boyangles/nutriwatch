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
    M_ID INTEGER NOT NULL,
    name VARCHAR(100) NOT NULL,
    R_ID INTEGER NOT NULL REFERENCES Restaurant(R_ID),
    PRIMARY KEY(M_ID, R_ID)
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
    M_ID INTEGER NOT NULL REFERENCES RestaurantMenus(M_ID),
    name VARCHAR(100) NOT NULL,
    price double precision NOT NULL,
    rating double precision,
    cuisine VARCHAR(50),
    calories INTEGER NOT NULL
);

CREATE TABLE DishIngredients (
    D_ID INTEGER NOT NULL REFERENCES Dishes(D_ID),
    I_ID INTEGER NOT NULL REFERENCES Ingredients(I_ID)
);

CREATE TABLE DietaryViolations (
    I_ID INTEGER NOT NULL REFERENCES Ingredients(I_ID),
    diet VARCHAR(50) NOT NULL
);


--Insertion of dummy data
INSERT INTO Restaurant(1, 'Cafe Edens');

INSERT INTO RestaurantMenus(1, '24-7 Menu', 1);

INSERT INTO RestaurantCuisines(1, 'American');
INSERT INTO RestauraatCuisines(1, 'Mexican');

INSERT INTO Ingredients(1, 'Dairy');
INSERT INTO Ingredients(2, 'Eggs');
INSERT INTO Ingredients(3, 'Fish');
INSERT INTO Ingredients(4, 'Shellfish');
INSERT INTO Ingredients(5, 'Tree Nuts');
INSERT INTO Ingredients(6, 'Peanuts');
INSERT INTO Ingredients(7, 'Wheat');
INSERT INTO Ingredients(8, 'Soybeans');

INSERT INTO Dishes(1, 1, 'Grilled Cheese and...', 6, 4, 'American', 400);

INSERT INTO DishIngredients(1, 1);
INSERT INTO DishIngredients(1, 8);

INSERT INTO DietaryViolations(1, 'Lactose Intolerant');
INSERT INTO DietaryViolations(1, 'Vegan');
