"use strict";

const db= require("./src/eshop.js");
const readline = require("readline-sync");

(async function () {
    let menu = "Database eshop information:\n"

    + "- about\n"
    + "- log <number>\n"
    + "- product\n"
    + "- shelf\n"
    + "- inv\n"
    + "- inv <str>\n"
    + "- invadd <productid (produktnamn)> <shelf> <number>\n"
    + "- invdel <productid (produktnamn)> <shelf> <number>\n"
    + "- order\n"
    + "- order <search>\n"
    + "- picklist <orderid>\n"
    + "- ship <orderid>\n"
    + "- exit\n";

    let stop = false;

    while (!stop) {
        console.log(menu);
        let choice = readline.question("Enter your choice (type the commando): ");

        if (choice === "about") {
            console.log("The working team: \n"
                + "Naya Mathbout\n");
        } else if (choice.startsWith("log")) {
            let choiceArray = choice.split(" ");

            let numStr = choiceArray[1];

            let num = Number(numStr);

            try {
                let rows = await db.loggNumber(num);

                console.table(rows);
            } catch (err) {
                console.error(err.message);
            }
        } else if (choice === "product") {
            try {
                let rows = await db.showProduct();

                console.table(rows);
            } catch (err) {
                console.error(err.message);
            }
        } else if (choice === "shelf") {
            try {
                let rows = await db.shelf();

                console.table(rows);
            } catch (err) {
                console.error(err.message);
            }
        } else if (choice === "inv") {
            try {
                let rows = await db.inv();

                console.table(rows);
            } catch (err) {
                console.error(err.message);
            }
        } else if (choice.startsWith("invadd")) {
            let choiceArray = choice.split(" ");

            let produktnamn = choiceArray[1];

            let hyllannr = choiceArray[2];

            let antal = choiceArray[3];

            try {
                await db.invadd(produktnamn, hyllannr, antal);

                console.log("Adding opporation succeded");
            } catch (err) {
                console.error(err.message);
            }
        } else if (choice.startsWith("invdel")) {
            let choiceArray = choice.split(" ");

            let produktnamn = choiceArray[1];

            let hyllannr = choiceArray[2];

            let antal = choiceArray[3];

            try {
                await db.invdel(produktnamn, hyllannr, antal);

                console.log("deleting oporation succeded");
            } catch (err) {
                console.error(err.message);
            }
        } else if (choice.startsWith("inv")) {
            let choiceArray = choice.split(" ");

            let filterWord = choiceArray[1];

            try {
                let rows = await db.invFilter(filterWord);

                console.table(rows);
            } catch (err) {
                console.error(err.message);
            }
        } else if (choice === "order") {
            try {
                let rows = await db.showOrders();

                console.table(rows);
            } catch (err) {
                console.error(err.message);
            }
        } else if (choice.startsWith("order")) {
            let choiceArray = choice.split(" ");

            let filterWord = choiceArray[1];

            try {
                let rows = await db.showOrdersFilter(Number(filterWord));

                console.table(rows);
            } catch (err) {
                console.error(err.message);
            }
        } else if (choice.startsWith("picklist")) {
            let choiceArray = choice.split(" ");

            let orderId = choiceArray[1];

            try {
                let rows = await db.picklist(Number(orderId));

                console.table(rows);
            } catch (err) {
                console.error(err.message);
            }
        } else if (choice.startsWith("ship")) {
            let choiceArray = choice.split(" ");

            let orderId = choiceArray[1];

            try {
                await db.ship(Number(orderId));
                let rows = await db.showOrders();

                console.table(rows);
            } catch (err) {
                console.error(err.message);
            }
        } else if (choice === "exit") {
            break;
        } else {
            console.log("This choice is not valid.");
        }
    }
}());
