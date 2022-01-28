DROP TABLE IF EXISTS cars;

CREATE TABLE cars (`car_id` SMALLINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
					`vin` VARCHAR(17) NOT NULL, 
                    `manufacturer` VARCHAR(20) NOT NULL, 
                    `model` VARCHAR(20) NOT NULL, 
                    `car_year` SMALLINT NOT NULL, -- YEAR
                    `color` VARCHAR(10) NOT NULL CHECK (color in ("Blue",
																	"Red",
                                                                    "White",
                                                                    "Silver",
                                                                    "Gray")));

INSERT INTO cars (vin, manufacturer, model, car_year, color) VALUES 			('3K096I98581DHSNUP', 'Volkswagen', 'Tiguan', 2019, 'Blue'),
																				('ZM8G7BEUQZ97IH46V', 'Peugeot', 'Rifter', 2019, 'Red'),
                                                                                ('RKXVNNIHLVVZOUB4M', 'Ford', 'Fusion', 2018, 'White'),
                                                                                ('HKNDGS7CU31E9Z7JW', 'Toyota', 'RAV4', 2018, 'Silver'),
                                                                                ('DAM41UDN3CHU2WVF6', 'Volvo', 'V60', 2019, 'Gray'),
                                                                                ('DAM41UDN3CHU2WVF6', 'Volvo', 'V60 Cross Country', 2019, 'Gray');
