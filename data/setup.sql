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
    M_ID INTEGER NOT NULL PRIMARY KEY,
    R_ID INTEGER NOT NULL REFERENCES Restaurant(R_ID)
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
