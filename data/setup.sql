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

CREATE Table Restaurants (
    R_ID INTEGER NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE Table RestaurantMenus (
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

COPY restaurants from '/home/austinbyliu/Documents/DukeUndergrad/Compsci316/FinalProject/nutriwatch/data/RestaurantsTable.csv' DELIMITER ',' CSV;

COPY RestaurantMenus from '/home/austinbyliu/Documents/DukeUndergrad/Compsci316/FinalProject/nutriwatch/data/RestaurantMenusTable.csv' DELIMITER ',' CSV;

COPY RestaurantCuisines from '/home/austinbyliu/Documents/DukeUndergrad/Compsci316/FinalProject/nutriwatch/data/RestaurantCuisinesTable.csv' DELIMITER ',' CSV;

COPY Ingredients from '/home/austinbyliu/Documents/DukeUndergrad/Compsci316/FinalProject/nutriwatch/data/IngredientsTable.csv' DELIMITER ',' CSV;

COPY Dishes from '/home/austinbyliu/Documents/DukeUndergrad/Compsci316/FinalProject/nutriwatch/data/DishesTable.csv' DELIMITER ',' CSV;

COPY DishIngredients from '/home/austinbyliu/Documents/DukeUndergrad/Compsci316/FinalProject/nutriwatch/data/DishIngredientsTable.csv' DELIMITER ',' CSV;

COPY DietaryViolations from '/home/austinbyliu/Documents/DukeUndergrad/Compsci316/FinalProject/nutriwatch/data/DietaryViolationsTable.csv' DELIMITER ',' CSV;

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
