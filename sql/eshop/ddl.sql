--- 
--- create tables
---

DROP PROCEDURE IF EXISTS ship_order;
DROP PROCEDURE IF EXISTS skapa_picklist;
DROP PROCEDURE IF EXISTS show_orders_filter;
DROP PROCEDURE IF EXISTS make_order;
DROP PROCEDURE IF EXISTS change_order_status;
DROP PROCEDURE IF EXISTS add_product_to_order;
DROP PROCEDURE IF EXISTS show_order_information;
DROP PROCEDURE IF EXISTS show_orders;
DROP PROCEDURE IF EXISTS show_costumers;

DROP FUNCTION IF EXISTS get_customer_id;
DROP FUNCTION IF EXISTS get_ordernummer;
DROP FUNCTION IF EXISTS order_status;

DROP PROCEDURE IF EXISTS invdel;
DROP PROCEDURE IF EXISTS invadd;
DROP PROCEDURE IF EXISTS inv_filter;
DROP PROCEDURE IF EXISTS inv;
DROP PROCEDURE IF EXISTS invdel;
DROP PROCEDURE IF EXISTS shelf;
DROP PROCEDURE IF EXISTS logg_number;

DROP PROCEDURE IF EXISTS read_produkt;
DROP PROCEDURE IF EXISTS update_produkt;
DROP PROCEDURE IF EXISTS delete_product;
DROP PROCEDURE IF EXISTS add_product;
DROP PROCEDURE IF EXISTS show_product;

DROP TRIGGER IF EXISTS logg_produkt_insert;
DROP TRIGGER IF EXISTS logg_produkt_update;
DROP PROCEDURE IF EXISTS show_kategori;

DROP TABLE IF EXISTS logg;
DROP TABLE IF EXISTS detailed_plocklista;
DROP TABLE IF EXISTS order_produkt;
DROP TABLE IF EXISTS faktora;
DROP TABLE IF EXISTS plocklista;
DROP TABLE IF EXISTS produkt_lager;
DROP TABLE IF EXISTS lager;
DROP TABLE IF EXISTS kategori_produkt;
DROP TABLE IF EXISTS kategori;
DROP TABLE IF EXISTS `order`;
DROP TABLE IF EXISTS kund;
DROP TABLE IF EXISTS produkt_kod;
DROP TABLE IF EXISTS produkt;

CREATE TABLE kund
(
    id INT AUTO_INCREMENT NOT NULL,
    namn VARCHAR(255),
    adress VARCHAR(255),
    telefonnummer INT NOT NULL,

    PRIMARY KEY(id)
);

CREATE TABLE produkt
(
    namn VARCHAR(255) NOT NULL,
    pris INT,
    beskrivning VARCHAR(255),

    PRIMARY KEY(namn)
);

CREATE TABLE produkt_kod
(
    produktkod INT NOT NULL,
    produktnamn VARCHAR(255) NOT NULL,

    PRIMARY KEY(produktkod, produktnamn),
    FOREIGN KEY(produktnamn) REFERENCES produkt(namn) ON DELETE CASCADE
);

CREATE TABLE kategori
(
    kategori VARCHAR(255) NOT NULL,
    produktnamn VARCHAR(255) NOT NULL,

    PRIMARY KEY(kategori, produktnamn),
    FOREIGN KEY(produktnamn) REFERENCES produkt(namn) ON DELETE CASCADE
);

CREATE TABLE lager
(
    hyllansnummer INT AUTO_INCREMENT NOT NULL,
    produktnamn VARCHAR(255) NOT NULL,
    antal INT NOT NULL,

    PRIMARY KEY(hyllansnummer, produktnamn),
    FOREIGN KEY(produktnamn) REFERENCES produkt(namn) ON DELETE CASCADE,
    KEY index_lager_produktnamn (produktnamn)
);

CREATE TABLE `order`
(
    ordernummer INT AUTO_INCREMENT NOT NULL,
    kund_id INT NOT NULL,
    skapad_tid TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    uppdaterad_tid TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    raderad_tid TIMESTAMP NULL DEFAULT NULL,
    bestalld_tid TIMESTAMP NULL DEFAULT NULL,
    skickad_tid TIMESTAMP NULL DEFAULT NULL,

    PRIMARY KEY(ordernummer),
    FOREIGN KEY(kund_id) REFERENCES kund(id) ON DELETE CASCADE,
    KEY index_order_updated (uppdaterad_tid)
); 

CREATE TABLE logg
(
    logg_id INT AUTO_INCREMENT NOT NULL,
    handelse VARCHAR(255) NOT NULL,
    datum_tid TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY(logg_id)
); 

CREATE TABLE plocklista
(
    ordernummer INT NOT NULL,
    plocklistanummer INT AUTO_INCREMENT NOT NULL,

    PRIMARY KEY(plocklistanummer),
    FOREIGN KEY(ordernummer) REFERENCES `order`(ordernummer) ON DELETE CASCADE
);

CREATE TABLE faktora
(
    faktoranummer INT AUTO_INCREMENT NOT NULL,
    ordernummer INT NOT NULL,
    pris INT NOT NULL,

    PRIMARY KEY(faktoranummer),
    FOREIGN KEY(ordernummer) REFERENCES `order`(ordernummer) ON DELETE CASCADE
);

-- mellan tabeller: 

CREATE TABLE order_produkt (
    ordernummer INT NOT NULL,
    produktkod INT NOT NULL,
    produktnamn VARCHAR(255),
    antal INT NOT NULL,

    PRIMARY KEY(ordernummer, produktkod, produktnamn),
    FOREIGN KEY(ordernummer) REFERENCES `order`(ordernummer) ON DELETE CASCADE
);

CREATE TABLE produkt_lager (
    hyllansnummer INT NOT NULL,
    produktkod INT NOT NULL,
    produktnamn VARCHAR(255) NOT NULL,

    PRIMARY KEY(hyllansnummer, produktkod, produktnamn),
    FOREIGN KEY(produktkod) REFERENCES produkt_kod (produktkod) ON DELETE CASCADE,
    FOREIGN KEY(produktnamn) REFERENCES produkt_kod (produktnamn) ON DELETE CASCADE
);


CREATE TABLE detailed_plocklista (
    ordernummer INT NOT NULL,
    produktkod INT,
    produktnamn VARCHAR(255),
    hyllansnummer INT NOT NULL,
    antal INT NOT NULL,

    PRIMARY KEY(ordernummer, produktkod, hyllansnummer, produktnamn),
    FOREIGN KEY(ordernummer, produktkod, produktnamn) REFERENCES order_produkt (ordernummer, produktkod, produktnamn) ON DELETE CASCADE,
    FOREIGN KEY(hyllansnummer) REFERENCES produkt_lager (hyllansnummer) ON DELETE CASCADE
);

---
--- logg tabell trigger
---

CREATE TRIGGER logg_produkt_insert
AFTER INSERT
ON produkt FOR EACH ROW
    INSERT INTO logg (handelse)
    VALUES ('New insert on produkt tabel'); 


CREATE TRIGGER logg_produkt_update
AFTER UPDATE
ON produkt FOR EACH ROW
    INSERT INTO logg (handelse)
    VALUES ('New update on produkt tabel'); 

---
--- webbklient procedurer
---

DELIMITER ;;
CREATE PROCEDURE show_kategori()
BEGIN
SELECT DISTINCT kategori FROM kategori;
END;;

CREATE PROCEDURE show_product()
BEGIN
    SELECT 
        p.namn AS produktnamn, 
        p.pris, 

        (SELECT GROUP_CONCAT(DISTINCT pk.produktkod SEPARATOR ', ') 
            FROM produkt_kod AS pk 
            WHERE pk.produktnamn = p.namn) AS ideer,  

        (SELECT GROUP_CONCAT(DISTINCT k.kategori SEPARATOR ', ') 
            FROM kategori AS k 
            WHERE k.produktnamn = p.namn) AS kategori,  

        (SELECT SUM(l.antal) 
            FROM lager AS l 
            WHERE l.produktnamn = p.namn) AS antal_i_lager  

    FROM produkt p;
END;;

CREATE PROCEDURE add_product(
    IN a_namn VARCHAR(255),
    IN a_pris INT,
    IN a_beskrivning VARCHAR(255)
)
BEGIN
    INSERT INTO produkt
        (namn, pris, beskrivning) 
    VALUES
    (a_namn, a_pris, a_beskrivning);
END;;

CREATE PROCEDURE delete_product(
    IN a_namn VARCHAR(255)
)
BEGIN
    DELETE FROM produkt 
    WHERE namn = a_namn;
END;;

CREATE PROCEDURE update_produkt(
    IN a_namn VARCHAR(255),
    IN a_pris INT,
    IN a_beskrivning VARCHAR(255)
)
BEGIN
    UPDATE produkt
        SET 
            pris = a_pris,
            beskrivning = a_beskrivning
        WHERE 
            namn = a_namn; 
END;; 

CREATE PROCEDURE read_produkt(
    IN a_namn VARCHAR(255)
)
BEGIN 
    SELECT * 
    FROM produkt
    WHERE namn = a_namn;
END;;

---
---terminal klient procedurer
---

CREATE PROCEDURE logg_number(
    IN a_number INT
)
BEGIN 
    SELECT *
    FROM logg 
    ORDER BY datum_tid DESC
    LIMIT a_number;
END;;



CREATE PROCEDURE shelf()
BEGIN
    SELECT * FROM lager;
END;;

CREATE PROCEDURE inv()
BEGIN
    SELECT 
        pl.produktkod,
        pk.produktnamn,
        l.hyllansnummer,
        l.antal
    FROM produkt_lager AS pl
    JOIN produkt_kod AS pk
        ON pl.produktkod = pk.produktkod
    JOIN lager AS l
        ON pl.hyllansnummer = l.hyllansnummer
        AND pk.produktnamn = l.produktnamn;
END;;

CREATE PROCEDURE inv_filter(
    IN filter VARCHAR(255)
)
BEGIN
    SELECT 
        pl.produktkod,
        pk.produktnamn,
        l.hyllansnummer,
        l.antal
    FROM produkt_lager AS pl
    JOIN produkt_kod AS pk
        ON pl.produktkod = pk.produktkod
    JOIN lager AS l
        ON pl.hyllansnummer = l.hyllansnummer
        AND pk.produktnamn = l.produktnamn
    WHERE 
        pl.produktkod LIKE CONCAT('%', filter, '%')
        OR pl.produktnamn LIKE CONCAT('%', filter, '%')
        OR l.hyllansnummer LIKE CONCAT('%', filter, '%');
END;;

CREATE PROCEDURE invadd(
    IN a_produktnamn VARCHAR(255),
    IN a_hyllansnummer INT,
    IN a_antal INT
)
BEGIN
    DECLARE ny_kod INT;

    INSERT INTO produkt(namn)
    VALUES (a_produktnamn)
    ON DUPLICATE KEY UPDATE namn = namn;

    INSERT INTO lager (hyllansnummer, produktnamn, antal)
    VALUES (a_hyllansnummer, a_produktnamn, a_antal)
    ON DUPLICATE KEY UPDATE
        antal = antal + a_antal;

    SELECT MAX(produktkod) INTO ny_kod
    FROM produkt_kod
    WHERE produktnamn = a_produktnamn;

    IF ny_kod IS NULL THEN
        SET ny_kod = 1;
    ELSE
        SET ny_kod = ny_kod + 1;
    END IF;

    INSERT INTO produkt_kod (produktkod, produktnamn)
    VALUES (ny_kod, a_produktnamn);

    INSERT INTO produkt_lager (hyllansnummer, produktkod, produktnamn)
    VALUES (a_hyllansnummer, ny_kod, a_produktnamn)
    ON DUPLICATE KEY UPDATE produktnamn = produktnamn; 
END;;

CREATE PROCEDURE invdel(
    IN a_produktnamn VARCHAR(255),
    IN a_hyllansnummer INT,
    IN a_antal INT
)
BEGIN
    UPDATE lager
    SET antal = antal - a_antal
    WHERE hyllansnummer = a_hyllansnummer
        AND produktnamn = a_produktnamn;
END;;

---
--- eshop2 kmom06
---

CREATE PROCEDURE show_costumers()
BEGIN 
    SELECT * FROM kund;
END;;

CREATE PROCEDURE show_orders()
BEGIN  
    SELECT 
        o.ordernummer,
        o.kund_id,
        CASE
            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Skapad' THEN skapad_tid

            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Uppdaterad' THEN uppdaterad_tid

            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Raderad' THEN raderad_tid

            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Beställd' THEN bestalld_tid

            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Skickad' THEN skickad_tid

            ELSE NULL
        END AS status_tid,
        
        order_status(
            o.skapad_tid,
            o.uppdaterad_tid,
            o.raderad_tid,
            o.bestalld_tid,
            o.skickad_tid
        ) AS status,
        COUNT(op.produktkod) AS antal_produkter
    FROM `order` AS o

    LEFT JOIN order_produkt AS op
        ON o.ordernummer = op.ordernummer
    GROUP BY 
        o.ordernummer,
        o.kund_id,
        o.skapad_tid,
        o.uppdaterad_tid,
        o.raderad_tid,
        o.bestalld_tid,
        o.skickad_tid;
END;;


CREATE PROCEDURE show_order_information(
    IN a_ordernummer INT
)
BEGIN 
    SELECT 
        o.ordernummer,
        o.kund_id,
        CASE
            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Skapad' THEN o.skapad_tid

            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Uppdaterad' THEN o.uppdaterad_tid

            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Raderad' THEN o.raderad_tid

            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Beställd' THEN o.bestalld_tid

            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Skickad' THEN o.skickad_tid

            ELSE NULL
        END AS status_tid,
        order_status(
            o.skapad_tid,
            o.uppdaterad_tid,
            o.raderad_tid,
            o.bestalld_tid,
            o.skickad_tid
        ) AS status,

        op.produktkod,
        op.produktnamn
    FROM `order` AS o
    LEFT JOIN order_produkt AS op
        ON o.ordernummer = op.ordernummer
    WHERE a_ordernummer = o.ordernummer;
    END;;

CREATE PROCEDURE make_order(
    IN a_kund_id INT
)
BEGIN 
    INSERT INTO `order`
        (kund_id)
    VALUES
        (a_kund_id);
END;;

CREATE PROCEDURE add_product_to_order(
    IN a_kund_id INT, 
    IN a_ordernummer INT, 
    IN a_produktnamn VARCHAR(255), 
    IN a_antal INT
)
BEGIN 
    DECLARE a_produktkod INT; 
    DECLARE i INT DEFAULT 1;

    WHILE i <= a_antal DO 
        SELECT produktkod 
        INTO a_produktkod
        FROM produkt_kod 
        WHERE produktnamn = a_produktnamn 
        ORDER BY produktkod ASC
        LIMIT 1 OFFSET i;

        INSERT INTO order_produkt
            (ordernummer, produktkod, produktnamn, antal)
        VALUES 
            (a_ordernummer, a_produktkod, a_produktnamn, 1);

        UPDATE lager
        SET antal = antal - 1
        WHERE produktnamn = a_produktnamn
        LIMIT 1;

        SET i = i + 1;
    END WHILE;
END;


CREATE PROCEDURE change_order_status(
    IN a_ordernummer INT
)
BEGIN 
    UPDATE `order`
    SET bestalld_tid = CURRENT_TIMESTAMP
    WHERE ordernummer = a_ordernummer;
END;;


---
---funktioner 
---

CREATE FUNCTION order_status(
    skapad_tid TIMESTAMP,
    uppdaterad_tid TIMESTAMP,
    raderad_tid TIMESTAMP,
    bestalld_tid TIMESTAMP,
    skickad_tid TIMESTAMP
)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    IF skickad_tid IS NOT NULL THEN
        RETURN 'Skickad';
    ELSEIF bestalld_tid IS NOT NULL THEN
        RETURN 'Beställd';
    ELSEIF raderad_tid IS NOT NULL THEN
        RETURN 'Raderad';
    ELSEIF uppdaterad_tid IS NOT NULL THEN
        RETURN 'Uppdaterad';
    ELSE
        RETURN 'Skapad';
    END IF;
END;; 

CREATE FUNCTION get_ordernummer(
    a_kund_id INT
)
RETURNS INT
NOT DETERMINISTIC 
BEGIN 
    DECLARE a_ordernummer INT;

    SELECT ordernummer 
    INTO a_ordernummer
    FROM `order`
    WHERE kund_id = a_kund_id
    ORDER BY ordernummer DESC 
    LIMIT 1;

    RETURN a_ordernummer;
END;;


CREATE FUNCTION get_customer_id(
    a_ordernummer INT
)
RETURNS INT
NOT DETERMINISTIC 
BEGIN 
    DECLARE a_kund_id INT;

    SELECT kund_id
    INTO a_kund_id
    FROM `order`
    WHERE ordernummer = a_ordernummer;

    RETURN a_kund_id;
END;;

---
---terminal procedurer kmom06
---


CREATE PROCEDURE show_orders_filter(
    IN a_id INT
)
BEGIN  
    SELECT 
        o.ordernummer,
        o.kund_id,
        CASE
            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Skapad' THEN skapad_tid

            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Uppdaterad' THEN uppdaterad_tid

            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Raderad' THEN raderad_tid

            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Beställd' THEN bestalld_tid

            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Skickad' THEN skickad_tid

            ELSE NULL
        END AS status_tid,
        
        order_status(
            o.skapad_tid,
            o.uppdaterad_tid,
            o.raderad_tid,
            o.bestalld_tid,
            o.skickad_tid
        ) AS status,
        COUNT(op.produktkod) AS antal_produkter
    FROM `order` AS o

    LEFT JOIN order_produkt AS op
        ON o.ordernummer = op.ordernummer
    WHERE o.kund_id = a_id OR o.ordernummer = a_id
    GROUP BY 
        o.ordernummer,
        o.kund_id,
        o.skapad_tid,
        o.uppdaterad_tid,
        o.raderad_tid,
        o.bestalld_tid,
        o.skickad_tid;
END;;


CREATE PROCEDURE skapa_picklist(
    IN a_ordernummer INT
)
BEGIN
    INSERT INTO plocklista (ordernummer)
    VALUES (a_ordernummer);

    INSERT INTO detailed_plocklista (ordernummer, produktkod, produktnamn, hyllansnummer, antal)
    SELECT 
        op.ordernummer,
        op.produktkod,
        op.produktnamn,
        pl.hyllansnummer,
        op.antal
    FROM order_produkt op
    JOIN produkt_lager pl
        ON op.produktkod = pl.produktkod AND op.produktnamn = pl.produktnamn
    WHERE op.ordernummer = a_ordernummer;

    SELECT 
        dp.ordernummer,
        dp.produktkod,
        dp.produktnamn,
        dp.hyllansnummer,
        dp.antal AS antal_att_plocka,
        CONCAT("Available because ordering was successfull") AS antal_kvar_i_lager
    FROM detailed_plocklista dp
    JOIN lager l
        ON dp.hyllansnummer = l.hyllansnummer AND dp.produktnamn = l.produktnamn
    WHERE dp.ordernummer = a_ordernummer;
END;;

CREATE PROCEDURE ship_order(
    IN a_ordernummer INT
)
BEGIN
    UPDATE `order`
    SET skickad_tid = CURRENT_TIMESTAMP
    WHERE ordernummer = a_ordernummer;
END;;

DELIMITER ;

