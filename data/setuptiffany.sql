DROP TABLE IF EXISTS Restaurants CASCADE;
DROP TABLE IF EXISTS RestaurantMenus CASCADE;
DROP TABLE IF EXISTS Ingredients CASCADE;
DROP TABLE IF EXISTS Dishes CASCADE;
DROP TABLE IF EXISTS RestaurantCuisines;
DROP TABLE IF EXISTS DishIngredients;
DROP TABLE IF EXISTS DietaryViolations;
DROP FUNCTION IF EXISTS TG_Restaurants_R_ID();
DROP FUNCTION IF EXISTS TG_RestaurantMenus_R_ID_M_ID();
DROP FUNCTION IF EXISTS TG_RestaurantMenus_M_ID_Name();
DROP FUNCTION IF EXISTS TG_Dishes_cuisine_conformation();
DROP FUNCTION IF EXISTS TG_Restaurants_cascade_RestMenus();
DROP FUNCTION IF EXISTS TG_Restaurants_cascade_RestCuisines();
DROP FUNCTION IF EXISTS TG_Restaurants_cascade_Dishes();
DROP FUNCTION IF EXISTS TG_Dishes_cascade_DishIngredients();

CREATE TABLE Restaurants (
    R_ID INTEGER NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE RestaurantMenus (
    R_ID INTEGER NOT NULL REFERENCES Restaurants(R_ID),
    M_ID INTEGER NOT NULL,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE RestaurantCuisines (
    R_ID INTEGER NOT NULL REFERENCES Restaurants(R_ID),
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
    calories INTEGER
    
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
INSERT INTO Restaurants VALUES(1, 'Cafe Edens');
INSERT INTO Restaurants VALUES(2, 'The Loop');

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
INSERT INTO Ingredients VALUES(9, 'Cheese');

INSERT INTO Dishes VALUES(1, 1, 1, 'Grilled Cheese and...', 6.0, 4.0, 'American', 400);

INSERT INTO DishIngredients VALUES(1, 'Dairy');
INSERT INTO DishIngredients VALUES(1, 'Soybeans');

INSERT INTO DietaryViolations VALUES('Dairy', 'Lactose Intolerant');
INSERT INTO DietaryViolations VALUES('Soybeans', 'Vegan');

/*
COPY restaurants from '/home/tiffanyho1995/project/nutriwatch/data/RestaurantsTable.csv' DELIMITER ',' CSV;

COPY RestaurantMenus from '/home/tiffanyho1995/project/nutriwatch/data/RestaurantMenusTable.csv' DELIMITER ',' CSV;

COPY RestaurantCuisines from '/home/tiffanyho1995/project/nutriwatch/data/RestaurantCuisinesTable.csv' DELIMITER ',' CSV;

COPY Ingredients from '/home/tiffanyho1995/project/nutriwatch/data/IngredientsTable.csv' DELIMITER ',' CSV;

COPY Dishes from '/home/tiffanyho1995/project/nutriwatch/data/DishesTable.csv' DELIMITER ',' CSV;

COPY DishIngredients from '/home/tiffanyho1995/project/nutriwatch/data/DishIngredientsTable.csv' DELIMITER ',' CSV;

COPY DietaryViolations from '/home/tiffanyho1995/project/nutriwatch/data/DietaryViolationsTable.csv' DELIMITER ',' CSV;
*/
-- TABLE: Restaurant
-- R_ID
CREATE FUNCTION TG_Restaurants_R_ID() RETURNS TRIGGER AS $$ 
BEGIN
    IF NEW.R_ID IN (SELECT R_ID FROM Restaurants) OR NEW.R_ID IS NULL
    THEN 
        RAISE EXCEPTION 'R_ID % has to be unique and cannot be NULL ', NEW.R_ID;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TG_Rest_R_ID
    BEFORE INSERT OR UPDATE ON Restaurants
    FOR EACH ROW
    EXECUTE PROCEDURE TG_Restaurants_R_ID();

CREATE FUNCTION TG_Restaurants_cascade_RestMenus() RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM RestaurantMenus WHERE RestaurantMenus.M_ID = OLD.M_ID;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER TG_Rest_cascade_RestMenus AFTER DELETE ON Restaurants
    FOR EACH STATEMENT
    EXECUTE PROCEDURE TG_Restaurants_cascade_RestMenus();

CREATE FUNCTION TG_Restaurants_cascade_RestCuisines() RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM RestaurantCuisines WHERE RestaurantCuisines.M_ID = OLD.M_ID;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER TG_Rest_cascade_RestCuisines AFTER DELETE ON Restaurants
    FOR EACH STATEMENT
    EXECUTE PROCEDURE TG_Restaurants_cascade_RestCuisines();

CREATE FUNCTION TG_Restaurants_cascade_Dishes() RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM Dishes WHERE Dishes.M_ID = OLD.M_ID;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER TG_Rest_cascade_Dishes AFTER DELETE ON Restaurants
    FOR EACH STATEMENT
    EXECUTE PROCEDURE TG_Restaurants_cascade_Dishes();

--Triggers for RestaurantMenus
-- Ensure (R_ID, M_ID) is unique in RestaurantMenus
CREATE FUNCTION TG_RestaurantMenus_R_ID_M_ID() RETURNS TRIGGER AS $$
BEGIN
	IF (NEW.R_ID, NEW.M_ID) IN (SELECT R_ID, M_ID FROM RestaurantMenus) 
	THEN 
		RAISE EXCEPTION '(R_ID, M_ID) has to be unique and cannot be NULL';
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TG_RestMenus_R_ID_M_ID
	BEFORE INSERT OR UPDATE ON RestaurantMenus
	FOR EACH ROW
	EXECUTE PROCEDURE TG_RestaurantMenus_R_ID_M_ID();

-- Ensure (M_ID, name) is unique in the context of restaurant
CREATE FUNCTION TG_RestaurantMenus_M_ID_Name() RETURNS TRIGGER AS $$
BEGIN
	IF (NEW.M_ID, NEW.Name) IN (SELECT M_ID, Name FROM RestaurantMenus WHERE R_ID == NEW.R_ID) 
	THEN 
		RAISE EXCEPTION '(M_ID, Name) has to be unique within the context of R_ID ';
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TG_RestMenus_M_ID_Name
	BEFORE INSERT OR UPDATE ON RestaurantMenus
	FOR EACH ROW
	EXECUTE PROCEDURE TG_RestaurantMenus_M_ID_Name();

--Dishes
--the cuisine type of the dish must conform with RestaurantCuisine
--D_ID: cascade update/delete onto DishIngredients
-- (D_ID, cuisine) does not need to be unique

CREATE FUNCTION TG_Dishes_cuisine_conformation() RETURNS TRIGGER AS $$
BEGIN
        IF NEW.cuisine NOT IN (SELECT cuisine FROM RestaurantCuisines WHERE R_ID == NEW.R_ID)
        THEN
                RAISE EXCEPTION 'the cuisine type of the dish must conform with that of the restaurant';
        END IF;
        RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER TG_Dishes_cuisine_conform
        BEFORE INSERT OR UPDATE ON Dishes
        FOR EACH ROW
        EXECUTE PROCEDURE TG_Dishes_cuisine_conformation();

CREATE FUNCTION TG_Dishes_cascade_DishIngredients() RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM DishIngredients WHERE DishIngredients.D_ID = OLD.D_ID;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER TG_Dishes_cascade_DishIngred 
    AFTER DELETE ON Dishes
    FOR EACH STATEMENT
    EXECUTE PROCEDURE TG_Dishes_cascade_DishIngredients();
-- TESTS
-- INSERT INTO Restaurants VALUES(NULL, 'Ginger');
