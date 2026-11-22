/**
 * Route for eshop.
 */
"use strict";

const express = require("express");
const router  = express.Router();
const eshop    = require("../src/eshop.js");

router.get("/about", (req, res) => {
    let data = {
        title: "The working team | MoonStone Eshop"
    };

    res.render("eshop/about", data);
});

router.get("/index", (req, res) => {
    let data = {
        title: "Welcome | MoonStone Eshop"
    };

    res.render("eshop/index", data);
});

router.get("/category", async (req, res) => {
    let data = {
        title: "Product category | MoonStone Eshop"
    };

    data.res = await eshop.showCategory();

    res.render("eshop/category", data);
});

router.get("/product", async (req, res) => {
    let data = {
        title: "Products available | MoonStone Eshop"
    };

    data.res = await eshop.showProduct();

    res.render("eshop/product", data);
});


router.get("/crud", async (req, res) => {
    let data = {
        title: "CRUD functions | MoonStone Eshop"
    };

    res.render("eshop/crud", data);
});


router.get("/create", async (req, res) => {
    let data = {
        title: "Create function | MoonStone Eshop"
    };

    res.render("eshop/create", data);
});

router.post("/create", async (req, res) => {
    let { namn, pris, beskrivning } = req.body;

    await eshop.createProduct(namn, pris, beskrivning);

    res.redirect("/eshop/product");
});

router.get("/delete/:namn", async (req, res) => {
    let data = {
        title: "Delete function | MoonStone Eshop",
        namn: req.params.namn
    };

    res.render("eshop/delete", data);
});

router.post("/delete", async (req, res) => {
    let { namn } = req.body;

    await eshop.deleteProduct(namn);

    res.redirect("/eshop/product");
});

router.get("/update/:namn", async (req, res) => {
    let data = {
        title: "Update function | MoonStone Eshop",
        namn: req.params.namn
    };

    res.render("eshop/update", data);
});

router.post("/update", async (req, res) => {
    let { namn, pris, beskrivning } = req.body;

    await eshop.updateProduct(namn, pris, beskrivning);

    res.redirect("/eshop/product");
});


router.get("/read", async (req, res) => {
    let data = {
        title: "Read function | MoonStone Eshop",
        namn: req.params.namn
    };

    res.render("eshop/read", data);
});

router.post("/read", async (req, res) => {
    let { namn } = req.body;

    res.redirect(`/eshop/read/${namn}`);
});

router.get("/read/:namn", async (req, res) => {
    let namn = req.params.namn;

    let data = {
        title: "Read function | MoonStone Eshop",
    };

    data.res = await eshop.readProduct(namn);

    res.render("eshop/read-product", data);
});

//kmom06

router.get("/order", async (req, res) => {
    let data = {
        title: "Shops customers | MoonStone Eshop"
    };

    data.res = await eshop.showOrders();

    res.render("eshop/order", data);
});

router.get("/orderinformation/:ordernummer", async (req, res) => {
    let data = {
        title: "Order Information | MoonStone Eshop"
    };

    let { ordernummer } = req.params;

    data.res = await eshop.showOrderInformation(ordernummer);

    res.render("eshop/orderinformation", data);
});

router.get("/customer", async (req, res) => {
    let data = {
        title: "Shops customers | MoonStone Eshop"
    };

    data.res = await eshop.showCustomers();

    res.render("eshop/customer", data);
});

router.post("/create-order", async (req, res) => {
    const { kundId } = req.body;

    await eshop.makeOrder(kundId);

    res.redirect(`/eshop/order`);
});

router.get("/orderproducts/:ordernummer", async (req, res) => {
    const ordernummer = req.params.ordernummer;

    const kundId = await eshop.getCustomerIdFromOrder(ordernummer);

    const data = {
        title: "Order products | MoonStone Eshop",
        ordernummer: ordernummer,
        kundId: kundId,
        res: await eshop.showProduct()
    };

    res.render("eshop/orderproducts", data);
});

router.post("/orderproducts/:ordernummer", async (req, res) => {
    const ordernummer = req.params.ordernummer;
    const kundId = req.body.kundId;

    for (const key in req.body) {
        if (key.startsWith("antal_")) {
            const produktnamn = key.split("_")[1];
            const antal = parseInt(req.body[key]);

            if (antal > 0) {
                await eshop.addProductsToOrder(Number(kundId), ordernummer, produktnamn, antal);
            }
        }
    }

    await eshop.changeOrderStatus(ordernummer);

    res.redirect("/eshop/order");
});

module.exports = router;
