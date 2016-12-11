
-- TABLE: Restaurant
-- R_ID
CREATE FUNCTION TG_Restaurants_R_ID() RETURNS TRIGGER AS $$
BEGIN
	IF NEW.R_ID IN (SELECT R_ID FROM Restaurants) OR NEW.R_ID IS NULL
	THEN 
		RAISE EXCEPTION 'R_ID % has to be unique and cannot be NULL ', NEW.R_ID;
	END IF;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TG_Restaurants_R_ID
	BEFORE INSERT OR UPDATE ON Restaurants[
	FOR EACH ROW
	EXECUTE PROCEDURE TG_Restaurants_R_ID()];
-- update R_ID for cascading effect to other 3 tables 
-- (enforced as part of the foreign key constraint, not in trigger)
ALTER TABLE Restaurants
ADD CONSTRAINT ensure_cascade FOREIGN KEY (R_ID)
REFERENCES RestaurantMenus(R_ID), RestaurantCuisines(R_ID), Dishes(R_ID) -- might need 3 tables instead
ON DELETE CASCADE 
ON UPDATE CASCADE;

-- TABLE: RestaurantMenus
-- (RID, MID)old != (RID, MID)new
CREATE FUNCTION TG_RestaurantMenus_R_ID_M_ID() RETURNS TRIGGER AS $$
BEGIN
	IF (NEW.R_ID, NEW.M_ID) IN (SELECT R_ID, M_ID FROM RestaurantMenus) -- how to select two fields from NEW??
	THEN 
		RAISE EXCEPTION '(R_ID, M_ID) has to be unique and cannot be NULL';
	END IF;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TG_RestaurantMenus_R_ID_M_ID
	BEFORE INSERT OR UPDATE ON Restaurants[
	FOR EACH ROW
	EXECUTE PROCEDURE TG_RestaurantMenus_R_ID_M_ID()];

-- (M_ID, name) is unique in the context of restaurant 
CREATE FUNCTION TG_RestaurantMenus_M_ID_Name() RETURNS TRIGGER AS $$
BEGIN
	IF IN (SELECT M_ID, Name FROM RestaurantMenus WHERE R_ID == NEW.R_ID) 
	THEN 
		RAISE EXCEPTION '(M_ID, Name) has to be unique within the context of R_ID ', NEW.R_ID;
	END IF;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TG_RestaurantMenus_M_ID_Name
	BEFORE INSERT OR UPDATE ON Restaurants[
	FOR EACH ROW
	EXECUTE PROCEDURE TG_RestaurantMenus_M_ID_Name()];


