<link rel="stylesheet" href="https://pay.fondy.eu/latest/checkout.css">
<link href="https://fonts.googleapis.com/css2?family=Raleway&display=swap" rel="stylesheet">
<style>
    html, body {
        font-family: 'Raleway', sans-serif;
    }

    .f-container {
        padding-top: 50px !important;
    }
</style>
<div id="app"></div>
<script src="https://pay.fondy.eu/latest/checkout.js"></script>
<script>
    var maxOptions = {
        options: {
            methods: ['card', 'banklinks_eu', 'wallets'],
            cardIcons: ['mastercard', 'visa', 'diners-club', 'american-express'],
            fields: true,
            title: 'Fondy Payments',
            fullScreen: true,
            button: true,
            locales: ['en'],
            email: true,
            tooltip: true,
            fee: false
        },
        params: {
            merchant_id: {$iframe_data.merchant_id},
            currency: '{$iframe_data.currency}',
            amount: {$iframe_data.amount},
            order_desc: '{$iframe_data.order_desc}',
            response_url: '{$iframe_data.response_url}',
            email: '{$iframe_data.sender_email}',
            order_id: '{$iframe_data.order_id}',
            lang: 'en'
        },
        messages: {
            ru: {
                card_number: 'Номер карты',
                my_amount: 'Сума к оплате',
                my_email: 'Эл. адрес',
                my_title: 'Назначение платежа',
                my_desc: 'Тестовый платеж'
            },
            en: {
                UAH: 'hrivnya',
                card_number_p: 'Card number',
                pay: 'Pay now {1} {0}',
                card_number: 'Card number',
                my_amount: 'Amount',
                my_email: 'Email',
                my_title: 'Order description',
                my_desc: 'Test payment'
            },
            uk: {
                my_amount: 'Сума до cплати',
                my_email: 'Електронна пошта',
                my_title: 'Призначення платежу',
                my_desc: 'Тестова оплата'
            }
        },
        validate: {
            ru: {
                credit_card: function (field) {
                    return 'Поле ' + field + ' должно быть действительным номером карты'
                }
            },
            uk: {
                credit_card: function (field) {
                    return 'Поле ' + field + ' має бути дійсним номером карти'
                }
            }
        }
    }

    document.querySelector('.payment-wait-title').style.display='none'
    fondy('#app', maxOptions)
</script>