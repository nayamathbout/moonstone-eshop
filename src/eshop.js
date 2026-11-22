/**
 * A module exporting functions to access the bank database.
 */
"use strict";

module.exports = {
    showCategory: showCategory,
    showProduct: showProduct,
    createProduct: createProduct,
    deleteProduct: deleteProduct,
    updateProduct: updateProduct,
    readProduct: readProduct,
    loggNumber: loggNumber,
    shelf: shelf,
    inv: inv,
    invFilter: invFilter,
    invadd: invadd,
    invdel: invdel,
    showCustomers: showCustomers,
    showOrders: showOrders,
    showOrderInformation: showOrderInformation,
    makeOrder: makeOrder,
    getCustomerIdFromOrder,
    addProductsToOrder,
    changeOrderStatus,
    showOrdersFilter,
    picklist,
    ship
};

const mysql  = require("promise-mysql");
const config = require("../config/db/eshop.json");


async function showCategory() {
    let sql = `CALL show_kategori();`;
    const db = await mysql.createConnection(config);
    let res;

    res = await db.query(sql);
    await db.end();
    return res[0];
}


async function showProduct() {
    let sql = `CALL show_product();`;
    const db = await mysql.createConnection(config);
    let res;

    res = await db.query(sql);
    await db.end();

    return res[0];
}

async function createProduct(namn, pris, beskrivning) {
    let sql = `CALL add_product(?, ?, ?);`;
    const db = await mysql.createConnection(config);

    await db.query(sql, [namn, pris, beskrivning]);

    await db.end();
    return "The product is added successfully!";
}

async function deleteProduct(namn) {
    let sql = `CALL delete_product(?);`;
    const db = await mysql.createConnection(config);

    await db.query(sql, [namn]);

    await db.end();
    return "The product is deleted successfully!";
}

async function updateProduct(namn, pris, beskrivning) {
    let sql = `CALL update_produkt(?, ?, ?);`;
    const db = await mysql.createConnection(config);

    await db.query(sql, [namn, pris, beskrivning]);

    await db.end();
    return "The product is updated successfully!";
}


async function readProduct(namn) {
    let sql = `CALL read_produkt(?);`;
    const db = await mysql.createConnection(config);
    let res;

    res = await db.query(sql, [namn]);
    await db.end();

    return res[0];
}

// terminal funktioner

async function loggNumber(number) {
    let sql = `CALL logg_number(?);`;
    const db = await mysql.createConnection(config);
    let res;

    res = await db.query(sql, [number]);
    await db.end();

    return res[0];
}

async function shelf() {
    let sql = `CALL shelf();`;
    const db = await mysql.createConnection(config);
    let res;

    res = await db.query(sql);
    await db.end();

    return res[0];
}

async function inv() {
    let sql = `CALL inv();`;
    const db = await mysql.createConnection(config);
    let res;

    res = await db.query(sql);
    await db.end();

    return res[0];
}

async function invFilter(filter) {
    let sql = `CALL inv_filter(?);`;
    const db = await mysql.createConnection(config);
    let res;

    res = await db.query(sql, [filter, filter, filter]);
    await db.end();

    return res[0];
}

async function invadd(produktnamn, hyllan, antal) {
    let sql = `CALL invadd(?, ?, ?);`;
    const db = await mysql.createConnection(config);
    let res;

    res = await db.query(sql, [produktnamn, hyllan, antal]);
    await db.end();

    return res[0];
}


async function invdel(produktnamn, hyllan, antal) {
    let sql = `CALL invdel(?, ?, ?);`;
    const db = await mysql.createConnection(config);
    let res;

    res = await db.query(sql, [produktnamn, hyllan, antal]);
    await db.end();

    return res[0];
}


async function showCustomers() {
    let sql = `CALL show_costumers();`;
    const db = await mysql.createConnection(config);
    let res;

    res = await db.query(sql);
    await db.end();

    return res[0];
}


async function showOrders() {
    let sql = `CALL show_orders();`;
    const db = await mysql.createConnection(config);
    let res;

    res = await db.query(sql);
    await db.end();

    return res[0];
}


async function showOrderInformation(ordernummer) {
    let sql = `CALL show_order_information(?);`;
    const db = await mysql.createConnection(config);
    let res;

    res = await db.query(sql, [ordernummer]);
    await db.end();

    return res[0];
}

async function makeOrder(kundId) {
    const db = await mysql.createConnection(config);

    await db.query(`CALL make_order(?);`, [kundId]);

    const [result] = await db.query(`SELECT get_ordernummer(?) AS ordernummer;`, [kundId]);

    const ordernummer = result?.ordernummer;


    await db.end();
    return ordernummer;
}

async function getCustomerIdFromOrder(ordernummer) {
    const db = await mysql.createConnection(config);

    let sql = `SELECT get_customer_id(?) AS kund_id;`;

    const [rows] = await db.query(sql, [ordernummer]);
    const customerId = rows.kund_id;

    await db.end();

    return customerId;
}


async function addProductsToOrder(kundId, ordernummer, produktnamn, antal) {
    const db = await mysql.createConnection(config);

    await db.query(
        `CALL add_product_to_order(?, ?, ?, ?);`,
        [Number(kundId), Number(ordernummer), produktnamn, antal]
    );

    await db.end();
}

async function changeOrderStatus(ordernummer) {
    const db = await mysql.createConnection(config);

    await db.query(
        `CALL change_order_status(?);`,
        [ordernummer]
    );
}

// terminal funktioner

async function showOrdersFilter(filter) {
    let sql = `CALL show_orders_filter(?);`;
    const db = await mysql.createConnection(config);
    let res;

    res = await db.query(sql, [filter]);
    await db.end();

    return res[0];
}


async function picklist(orderId) {
    let sql = `CALL skapa_picklist(?);`;
    const db = await mysql.createConnection(config);
    let res;

    res = await db.query(sql, [orderId]);
    await db.end();

    return res[0];
}


async function ship(orderId) {
    let sql = `CALL ship_order(?);`;
    const db = await mysql.createConnection(config);
    let res;

    res = await db.query(sql, [orderId]);
    await db.end();

    return res[0];
}
