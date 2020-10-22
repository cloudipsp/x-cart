<?php

if ( ! defined('XCART_START')) {
    header("Location: ../");
    die("Access denied");
}

function fondy_generate_url($data)
{
    $ch = curl_init('https://api.fondy.eu/api/checkout/url/');

    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-type: application/json'));
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode(array('request' => $data)));

    $result = json_decode(curl_exec($ch));

    if ($result->response->response_status != 'failure') {
        return $result->response->checkout_url;
    }

    curl_close($ch);

    return false;
}

function fondy_payment_valid($settings, $response)
{
    if ($settings['merchant_id'] == $response['merchant_id'] || $response['order_status'] == 'approved') {
        if (fondy_generate_signature($response, $settings['secret_key']) == $response['signature']) {
            return true;
        }
    }

    return false;
}

function fondy_generate_signature($data, $password, $encoded = true)
{
    unset($data['response_signature_string']); // test mode
    unset($data['signature']);

    $data = array_filter(
        $data,
        function ($var) {
            return $var !== '' && $var !== null;
        }
    );

    ksort($data);

    $str = $password . '|' . implode('|', $data);

    return $encoded ? sha1($str) : $str;
}