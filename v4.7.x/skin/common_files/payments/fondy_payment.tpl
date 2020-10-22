{if $usertype eq 'A'}
    <h1>Fondy Payments</h1>
    {$lng.txt_ch_configure_top_text}
    <br/>
    <br/>
    {capture name=dialog}
        <form action="cc_processing.php?cc_processor={$smarty.get.cc_processor|escape:"url"}" method="post">
            <table cellspacing="10">
                <tr>
                    <td><span style="color: red;">*</span> Merchand ID:</td>
                    <td><input type="text" name="param01" size="24" value="{$module_data.param01|escape}" required/>
                    </td>
                </tr>
                <tr>
                    <td><span style="color: red;">*</span> Secret Key:</td>
                    <td><input type="text" name="param02" size="24" value="{$module_data.param02|escape}" required/>
                    </td>
                </tr>
                <tr>
                    <td>Mode:</td>
                    <td>
                        <select name="param03">
                            <option value="redirect"{if $module_data.param03 eq "redirect"} selected="selected"{/if}>
                                Redirect
                            </option>
                            <option value="embedded"{if $module_data.param03 eq "embedded"} selected="selected"{/if}>
                                Embedded
                            </option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Currency:</td>
                    <td>
                        <select name="param04">
                            <option value="USD"{if $module_data.param04 eq "USD"} selected="selected"{/if}>
                                USD — US Dollar
                            </option>

                            <option value="EUR"{if $module_data.param04 eq "EUR"} selected="selected"{/if}>
                                EUR — Euro
                            </option>

                            <option value="GBP"{if $module_data.param04 eq "GBP"} selected="selected"{/if}>
                                GBP — Pound sterling mandatory
                            </option>

                            <option value="CZK"{if $module_data.param04 eq "CZK"} selected="selected"{/if}>
                                CZK — Czech Republic Koruna
                            </option>

                            <option value="UAH"{if $module_data.param04 eq "UAH"} selected="selected"{/if}>
                                UAH — Ukrainian Hryvnia
                            </option>
                            <option value="RUB"{if $module_data.param04 eq "RUB"} selected="selected"{/if}>
                                RUB — Russian Rouble
                            </option>
                        </select>
                    </td>
                </tr>
            </table>
            <br/><br/>
            <input type="submit" value="{$lng.lbl_update|strip_tags:false|escape}"/>
        </form>
    {/capture}
    {include file="dialog.tpl" title=$lng.lbl_ch_settings content=$smarty.capture.dialog extra='width="100%"'}
{else}
    Payment Gateway FONDY is an online merchant service provider that helps you accept credit cards
{/if}