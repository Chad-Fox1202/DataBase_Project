SELECT version();
/*Owner: Chad Fox*/
CREATE TABLE costumer(
    name            varchar(25),
    phone_number    numeric(10,0),
    email           varchar(25),
    street          varchar(25) NOT NULL,
    city            varchar(25) NOT NULL,
    state           varchar(25) NOT NULL,
    PRIMARY KEY (name, phone_number)
);

CREATE TABLE vehicle(
    VIN             varchar(4),
    make            varchar(15) NOT NULL ,
    model           varchar(15) NOT NULL,
    year            numeric(4,0) NOT NULL,
    license_plate   varchar(10) NOT NULL ,
    PRIMARY KEY (VIN)
);

CREATE TABLE owner(
    name            varchar(25),
    phone_number    numeric(10,0),
    VIN             varchar(4),
    FOREIGN KEY (name, phone_number) REFERENCES costumer(name,phone_number),
    FOREIGN KEY (VIN) REFERENCES vehicle(VIN)
);

CREATE TABLE appointment(
    app_ID          varchar(8),
    costumer_rep    varchar(25) NOT NULL,
    VIN             varchar(4),
    date            DATE NOT NULL,
    mileage         numeric(6,0) NOT NULL,
    PRIMARY KEY (app_ID),
    FOREIGN KEY (VIN) REFERENCES vehicle(VIN)
);

CREATE TABLE gas_powered(
    VIN     varchar(4),
    FOREIGN KEY (VIN) REFERENCES vehicle(VIN)
);

CREATE TABLE hybrid(
    VIN     varchar(4),
    FOREIGN KEY (VIN) REFERENCES vehicle(VIN)
);

/* 1 for if service type was done 0 if not done */
CREATE TABLE service_type(
    engine_diagnosis    numeric(1,0),
    oil_change          numeric(1,0),
    brake_repair        numeric(1,0),
    app_ID              varchar(8),
    FOREIGN KEY (app_ID) REFERENCES appointment(app_ID)
);

CREATE TABLE service(
    service_ID      varchar(8),
    mechanic        varchar(25),
    labor_hours     numeric(4,1),
    PRIMARY KEY (service_ID)
);

CREATE TABLE repairment(
    app_ID      varchar(8),
    service_ID  varchar(8),
    FOREIGN KEY (app_ID) REFERENCES appointment(app_ID),
    FOREIGN KEY (service_ID) REFERENCES service(service_ID)
);

CREATE TABLE parts(
    part_ID     varchar(8),
    cost        numeric(7,2),
    PRIMARY KEY (part_ID)
);

CREATE TABLE service_parts(
    service_ID      varchar(8),
    part_ID         varchar(8),
    FOREIGN KEY (service_ID) REFERENCES service(service_ID),
    FOREIGN KEY (part_ID) REFERENCES  parts(part_ID)
);

/* 1 if certified 0 if not */
CREATE TABLE mechanic(
    name            varchar(25),
    certification   numeric(1,0),
    rate            numeric(7,2),
    PRIMARY KEY (name,certification)
);

CREATE TABLE card(
    card_number numeric(8,0),
    expiration_date DATE NOT NULL,
    PRIMARY KEY (card_number)
);

CREATE TABLE pay(
    card_number numeric(8,0),
    app_ID      varchar(8),
    FOREIGN KEY (card_number) REFERENCES card(card_number),
    FOREIGN KEY (app_ID) REFERENCES appointment(app_ID)
);

CREATE TABLE credit(
    card_number numeric(8,0),
    FOREIGN KEY (card_number) REFERENCES card(card_number)
);

CREATE TABLE debit(
    card_number numeric(8,0),
    FOREIGN KEY (card_number) REFERENCES card(card_number)
);





INSERT INTO costumer (name, phone_number, email, street, city, state)
VALUES
    ('John Doe', 1234567890, 'john.doe@example.com', '123 Main St', 'Anytown', 'NY'),
    ('Jane Smith', 9876543210, 'jane.smith@example.com', '456 Elm St', 'Otherville', 'CA'),
    ('Bob Johnson', 4567890123, 'bob.johnson@example.com', '789 Oak St', 'Smalltown', 'TX');

-- Sample data for vehicle table
INSERT INTO vehicle (VIN, make, model, year, license_plate)
VALUES
    ('ABC1', 'Toyota', 'Camry', 2018, 'ABC123'),
    ('DEF2', 'Honda', 'Civic', 2019, 'DEF456'),
    ('GHI3', 'Ford', 'F-150', 2020, 'GHI789');

-- Sample data for owner table
INSERT INTO owner (name, phone_number, VIN)
VALUES
    ('John Doe', 1234567890, 'ABC1'),
    ('Jane Smith', 9876543210, 'DEF2'),
    ('Bob Johnson', 4567890123, 'GHI3');

-- Sample data for appointment table
INSERT INTO appointment (app_ID, costumer_rep, VIN, date, mileage)
VALUES
    ('APP001', 'Service Rep 1', 'ABC1', '2024-04-19', 50000),
    ('APP002', 'Service Rep 2', 'DEF2', '2024-04-20', 60000),
    ('APP003', 'Service Rep 3', 'GHI3', '2024-04-21', 70000);

-- Sample data for gas_powered table
INSERT INTO gas_powered (VIN)
VALUES
    ('ABC1'),
    ('DEF2');

-- Sample data for hybrid table
INSERT INTO hybrid (VIN)
VALUES ('GHI3');

-- Sample data for service_type table
INSERT INTO service_type (engine_diagnosis, oil_change, brake_repair, app_ID)
VALUES
    (1, 0, 1, 'APP001'),
    (0, 1, 1, 'APP002'),
    (1, 1, 0, 'APP003');

-- Sample data for service table
INSERT INTO service (service_ID, mechanic, labor_hours)
VALUES
    ('SRV001', 'Mechanic 1', 2.5),
    ('SRV002', 'Mechanic 1', 3.0),
    ('SRV003', 'Mechanic 2', 1.0),
    ('SRV004', 'Mechanic 2', 2.0),
    ('SRV005', 'Mechanic 3', 1.5),
    ('SRV006', 'Mechanic 3', 2.5);

-- Sample data for repairment table
INSERT INTO repairment (app_ID, service_ID)
VALUES
    ('APP001', 'SRV001'),
    ('APP001', 'SRV002'),
    ('APP002', 'SRV003'),
    ('APP002', 'SRV004'),
    ('APP003', 'SRV005'),
    ('APP003', 'SRV006');

-- Sample data for parts table
INSERT INTO parts (part_ID, cost)
VALUES
    ('PART001', 50.00),
    ('PART002', 75.00),
    ('PART003', 100.00);

-- Sample data for service_parts table
INSERT INTO service_parts (service_ID, part_ID)
VALUES
    ('SRV001', 'PART001'),
    ('SRV005', 'PART001'),
    ('SRV003', 'PART002'),
    ('SRV006', 'PART002'),
    ('SRV002', 'PART003'),
    ('SRV004', 'PART003');

-- Sample data for mechanic table
INSERT INTO mechanic (name, certification, rate)
VALUES
    ('Mechanic 1', 1, 50.00),
    ('Mechanic 2', 1, 60.00),
    ('Mechanic 3', 0, 40.00);

-- Sample data for card table
INSERT INTO card (card_number, expiration_date)
VALUES
    (12345678, '2025-06-30'),
    (87654321, '2024-12-31'),
    (55555555, '2023-09-30');

-- Sample data for pay table
INSERT INTO pay (card_number, app_ID)
VALUES
    (12345678, 'APP001'),
    (87654321, 'APP002'),
    (55555555, 'APP003');

-- Sample data for credit table
INSERT INTO credit (card_number)
VALUES
    (12345678),
    (87654321);

-- Sample data for debit table
INSERT INTO debit (card_number)
VALUES
    (55555555);

SELECT vehicle.VIN, vehicle.make, vehicle.model, vehicle.year, owner.name, engine_diagnosis, oil_change, brake_repair,
       SUM(service.labor_hours * mechanic.rate) + SUM(parts.cost) AS total_cost
FROM appointment
NATURAL JOIN vehicle
NATURAL JOIN owner
NATURAL JOIN service_type
LEFT JOIN repairment ON appointment.app_ID = repairment.app_ID
LEFT JOIN service ON repairment.service_ID = service.service_ID
LEFT JOIN mechanic ON service.mechanic = mechanic.name
LEFT JOIN service_parts ON service.service_ID = service_parts.service_ID
LEFT JOIN parts ON service_parts.part_ID = parts.part_ID
WHERE appointment.app_ID = 'APP001'
GROUP BY vehicle.VIN, vehicle.make, vehicle.model, vehicle.year, owner.name, engine_diagnosis, oil_change, brake_repair;

SELECT DISTINCT vehicle.VIN, vehicle.make, vehicle.model, vehicle.year, mechanic.name
FROM appointment
JOIN vehicle ON appointment.VIN = vehicle.VIN
JOIN repairment ON appointment.app_ID = repairment.app_ID
JOIN service ON repairment.service_ID = service.service_ID
JOIN mechanic ON service.mechanic = mechanic.name
WHERE mechanic.name = 'Mechanic 1'
AND EXTRACT(MONTH FROM appointment.date) = 04
AND EXTRACT(YEAR FROM appointment.date) = 2024;

/*composite index - looking up vehicles make and model will be a frequent occurrence */
CREATE INDEX idx_vehicle_make_model ON vehicle (make, model);

/*single column index - vin will be common thing to lookup and any query with vehicle included will be aided by the index */
CREATE INDEX idx_vehicle_VIN ON vehicle (VIN);

/*single column index - it is likely that the employer will like to see the what services each mechanic is doing */
CREATE INDEX idx_service_mechanic ON service (mechanic);

/*single column index - each appointment will have a list of services attached to it and will be frequent for employer to see what services were done at each appointment */
CREATE INDEX idx_repairment_app_ID ON repairment (app_ID);

/*single column index - each services uses parts and employer will likely look up what parts are used throughout the day so they can be stocked properly */
CREATE INDEX idx_service_parts_service_ID ON service_parts (service_ID);

/*single column index - employer will like to see payment info for each appointment*/
CREATE INDEX idx_pay_app_ID ON pay (app_ID);

/*all of these indexes will be well suited for a B+ tree*/