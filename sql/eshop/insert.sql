---
--- insert data into the tables
--- 

DELETE FROM order_produkt;
DELETE FROM `order`;
DELETE FROM kategori;
DELETE FROM produkt_lager;
DELETE FROM lager;
DELETE FROM kund;
DELETE FROM produkt_kod;
DELETE FROM produkt;


INSERT INTO kund
    (namn, adress, telefonnummer) 
VALUES 
    ('Naya', 'Kristianstad', 444),
    ('Huda', 'Göteborg', 33333),
    ('Sarah', 'Stockholm', 3355),
    ('Mohamad', 'Helsingborg', 99999);


INSERT INTO produkt
    (namn, pris, beskrivning) 
VALUES
    ('moonstone', 90, 'feminine energy'),
    ('sunstone', 100, 'masculine energy'),
    ('tarot', 300, 'fortune telling cards'),
    ('oracle', 250, 'theme cards');


INSERT INTO produkt_kod
    (produktkod, produktnamn) 
VALUES
    (1, 'moonstone'),
    (2, 'moonstone'),
    (3, 'moonstone'),
    (4, 'moonstone'),
    (5, 'moonstone'),
    (6, 'moonstone'),
    (1, 'sunstone'),
    (2, 'sunstone'),
    (3, 'sunstone'),
    (1, 'tarot'),
    (2, 'tarot'),
    (1, 'oracle'),
    (2, 'oracle'),
    (3, 'oracle');

INSERT INTO kategori VALUES
    ('crystal', 'moonstone'),
    ('crystal', 'sunstone'),
    ('kortlek', 'tarot'),
    ('kortlek', 'oracle'),
    ('spiritual', 'moonstone'),
    ('spiritual', 'sunstone'),
    ('spiritual', 'tarot'),
    ('spiritual', 'oracle');

INSERT INTO lager
    (produktnamn, antal) 
VALUES 
    ('moonstone', 3), 
    ('moonstone', 3), 
    ('sunstone', 2), 
    ('sunstone', 1), 
    ('tarot', 2), 
    ('oracle', 3);


INSERT INTO produkt_lager
    (hyllansnummer, produktkod, produktnamn)
VALUES
    (1, 1, 'moonstone'),
    (1, 2, 'moonstone'),
    (1, 3, 'moonstone'),
    (2, 4, 'moonstone'),
    (2, 5, 'moonstone'),
    (2, 6, 'moonstone'),
    (3, 1, 'sunstone'),
    (3, 2, 'sunstone'),
    (4, 3, 'sunstone'),
    (5, 1, 'tarot'),
    (5, 2, 'tarot'),
    (6, 1, 'oracle'),
    (6, 2, 'oracle'),
    (6, 3, 'oracle');

CALL make_order(1);
CALL make_order(3);

CALL add_product_to_order(3, 2, 'moonstone', 1);
CALL change_order_status(2);

