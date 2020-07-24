<?php

/*
 * Fondy Payment Gateway
 * Author: Rauf Kerimov
 * Version: 1.0.0
 */

if ( ! defined('XCART_START')) { // prevent from direct access
    header("Location: ../");
    die("Access denied");
}

if (is_int($orderids[0])) { // order created
    func_pm_load('cc_fondy'); // load fondy functions

    $data              = array(
        'merchant_id'         => $module_params['param01'],
        'currency'            => $module_params['param04'],
        'amount'              => round($cart['total_cost'] * 100),
        'order_id'            => $orderids[0] . '_' . uniqid(),
        'order_desc'          => 'Payment for order №' . $orderids[0],
        'sender_email'        => $userinfo['email'],
        'response_url'        => $https_location . '/cart.php?mode=order_message&orderids=' . $orderids[0],
        'server_callback_url' => $https_location . '/admin/cc_fondy_process.php',
    );

    if ($module_params['param03'] == 'redirect') { // redirect type
        $data['signature'] = fondy_generate_signature($data, $module_params['param02']);

        if ($url = fondy_generate_url($data)) { // checkout link created
            $cart = ''; // clean cart session

            echo '<h3><strong>Success!</strong> Your order is placed. Now you will redirect to payment page...</h3>';
            func_html_location($url);
        } else {
            $bill_output['code']    = 2;
            $bill_output['billmes'] = 'Can not generate checkout URL.';
        }
    } else { // embedded type
        $smarty->assign('iframe_data', $data);
        func_flush(func_display('payments/fondy_payment_iframe.tpl', $smarty, false));
    }
} else {
    $bill_output['code']    = 2;
    $bill_output['billmes'] = 'Something went wrong.';
}

exit;