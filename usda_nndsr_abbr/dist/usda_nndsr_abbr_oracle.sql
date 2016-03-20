-- ===============================================================================================================================
-- USDA National Nutrient Database for Standard Reference (Abbreviated Version), Release 28 (http://www.ars.usda.gov/ba/bhnrc/ndl)
-- This file was generated by http://github.com/m5n/nutriana
-- Run this SQL with an account that has admin priviledges, e.g.: sqlplus "/as sysdba" < usda_nndsr_abbr_oracle.sql
-- ===============================================================================================================================

-- This script assumes you've already set up a database when you installed Oracle and that $ORACLE_HOME/bin is in your path.

-- Needed since Oracle 12c.
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

BEGIN EXECUTE IMMEDIATE 'CREATE USER food IDENTIFIED BY food'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -01920 THEN RAISE; END IF; END;
/

-- Needed since Oracle 12c.
ALTER USER food QUOTA 100M ON USERS;

-- Needed since Oracle 12c.
ALTER SESSION SET "_ORACLE_SCRIPT"=FALSE;

GRANT CONNECT, RESOURCE TO food;
CONNECT food/food;

-- Abbreviated
BEGIN EXECUTE IMMEDIATE 'DROP TABLE ABBREV CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -00942 THEN RAISE; END IF; END;
/
CREATE TABLE ABBREV (
    NDB_No VARCHAR2(5) NOT NULL,   -- 5-digit Nutrient Databank number. If this field is defined as numeric, the leading zero will be lost.
    Shrt_Desc VARCHAR2(60),   -- 60-character abbreviated description of food item. (For a 200-character description and other descriptive information, link to the Food Description file.)
    Water NUMBER(10, 2),   -- Water (g/100 g)
    Energ_Kcal NUMBER(10),   -- Food energy (kcal/100 g)
    Protein NUMBER(10, 2),   -- Protein (g/100 g)
    Lipid_Tot NUMBER(10, 2),   -- Total lipid (fat) (g/100 g)
    Ash NUMBER(10, 2),   -- Ash (g/100 g)
    Carbohydrt NUMBER(10, 2),   -- Carbohydrate, by difference (g/100 g)
    Fiber_TD NUMBER(10, 1),   -- Total dietary fiber (g/100 g)
    Sugar_Tot NUMBER(10, 2),   -- Total sugars (g/100 g)
    Calcium NUMBER(10),   -- Calcium (mg/100 g)
    Iron NUMBER(10, 2),   -- Iron (mg/100 g)
    Magnesium NUMBER(10),   -- Magnesium (mg/100 g)
    Phosphorus NUMBER(10),   -- Phosphorus (mg/100 g)
    Potassium NUMBER(10),   -- Potassium (mg/100 g)
    Sodium NUMBER(10),   -- Sodium (mg/100 g)
    Zinc NUMBER(10, 2),   -- Zinc (mg/100 g)
    Copper NUMBER(10, 3),   -- Copper (mg/100 g)
    Manganese NUMBER(10, 3),   -- Manganese (mg/100 g)
    Selenium NUMBER(10, 1),   -- Selenium (mcg/100 g)
    Vit_C NUMBER(10, 1),   -- Vitamin C (mg/100 g)
    Thiamin NUMBER(10, 3),   -- Thiamin (mg/100 g)
    Riboflavin NUMBER(10, 3),   -- Riboflavin (mg/100 g)
    Niacin NUMBER(10, 3),   -- Niacin (mg/100 g)
    Panto_acid NUMBER(10, 3),   -- Pantothenic acid (mg/100 g)
    Vit_B6 NUMBER(10, 3),   -- Vitamin B6 (mg/100 g)
    Folate_Tot NUMBER(10),   -- Folate, total (mcg/100 g)
    Folic_acid NUMBER(10),   -- Folic acid (mcg/100 g)
    Food_Folate NUMBER(10),   -- Food folate (mcg/100 g)
    Folate_DFE NUMBER(10),   -- Folate (mcg dietary folate equivalents/100 g)
    Choline_Tot NUMBER(10),   -- Choline, total (mg/100 g)
    Vit_B12 NUMBER(10, 2),   -- Vitamin B12 (mcg/100 g)
    Vit_A_IU NUMBER(10),   -- Vitamin A (IU/100 g)
    Vit_A_RAE NUMBER(10),   -- Vitamin A (mcg retinol activity equivalents/100g)
    Retinol NUMBER(10),   -- Retinol (mcg/100 g)
    Alpha_Carot NUMBER(10),   -- Alpha-carotene (mcg/100 g)
    Beta_Carot NUMBER(10),   -- Beta-carotene (mcg/100 g)
    Beta_Crypt NUMBER(10),   -- Beta-cryptoxanthin (mcg/100 g)
    Lycopene NUMBER(10),   -- Lycopene (mcg/100 g)
    Lut_Zea NUMBER(10),   -- Lutein+zeazanthin (mcg/100 g)
    Vit_E NUMBER(10, 2),   -- Vitamin E (alpha-tocopherol) (mg/100 g)
    Vit_D_mcg NUMBER(10, 1),   -- Vitamin D (mcg/100 g)
    Vit_D_IU NUMBER(10),   -- Vitamin D (IU/100 g)
    Vit_K NUMBER(10, 1),   -- Vitamin K (phylloquinone) (mcg/100 g)
    FA_Sat NUMBER(10, 3),   -- Saturated fatty acid (g/100 g)
    FA_Mono NUMBER(10, 3),   -- Monounsaturated fatty acids (g/100 g)
    FA_Poly NUMBER(10, 3),   -- Polyunsaturated fatty acids (g/100 g)
    Cholestrl NUMBER(10, 3),   -- Cholesterol (mg/100 g)
    GmWt_1 NUMBER(9, 2),   -- First household weight for this item from the Weight file. (For the complete list and description of the measure, link to the Weight file.)
    GmWt_Desc1 VARCHAR2(120),   -- Description of household weight number 1.
    GmWt_2 NUMBER(9, 2),   -- Second household weight for this item from the Weight file. (For the complete list and description of the measure, link to the Weight file.)
    GmWt_Desc2 VARCHAR2(120),   -- Description of household weight number 2.
    Refuse_Pct NUMBER(2)   -- Percent refuse. (For a description of refuse, link to the Food Description file.)
);

-- Load data into ABBREV
HOST sqlldr food/food CONTROL=../sqlldr/ABBREV.ctl LOG=../sqlldr/ABBREV.log;
-- Assert all 8789 records were loaded
CREATE TABLE tmp (c NUMBER PRIMARY KEY);
INSERT INTO tmp (c) VALUES (2);
INSERT INTO tmp (SELECT COUNT(*) FROM ABBREV);
DELETE FROM tmp WHERE c = 8789;
INSERT INTO tmp (SELECT COUNT(*) FROM tmp);
DROP TABLE tmp;

-- Correct data inconsistencies, if any

-- Add primary keys
ALTER TABLE ABBREV ADD PRIMARY KEY (NDB_No);

-- Add foreign keys
