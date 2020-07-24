<?php

require(__DIR__ . '/auth.php');

x_load('order');

if ($json = json_decode(file_get_contents('php://input'), true)) {
    if (isset($json['order_id']) && isset($json['signature'])) {
        $order_id   = explode('_', $json['order_id'])[0];
        $order_data = func_order_data($order_id);

        if ($order_data['order']['status'] != 'C') { // not completed
            func_pm_load('cc_fondy'); // load fondy functions

            if ($fondy = func_get_pm_params('fondy_payment.php')) {
                if (fondy_payment_valid(
                    array('merchant_id' => $fondy['param01'], 'secret_key' => $fondy['param02']),
                    $json
                )) {
                    func_change_order_status($order_id, 'C'); // complete
                }
            }
        }
    }
}