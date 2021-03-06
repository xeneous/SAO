package com.xeneous.base

import android.app.Activity
import android.content.Intent
import androidx.annotation.NonNull
import com.mercadopago.android.px.core.MercadoPagoCheckout
import com.mercadopago.android.px.model.Payment
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    private val REQUEST_CODE = 1;
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "canalNativo")

        channel.setMethodCallHandler { call, result ->
            val args = call.arguments as HashMap<*, *>;
            val publicKey = args["publicKey"] as String
            val preferenceId = args["preferenceId"] as String;

            when (call.method) {
                "mercadoPago" -> mercadoPago(publicKey, preferenceId, result)
                else -> return@setMethodCallHandler
            }
        }
    }

    private fun mercadoPago(publicKey: String, preferenceId: String, channelResult: MethodChannel.Result) {
        MercadoPagoCheckout.Builder(publicKey, preferenceId).build().startPayment(this@MainActivity, REQUEST_CODE)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        val channelMercadoPagoRespuesta = MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, "canalNativoRespuesta")
        if(resultCode == MercadoPagoCheckout.PAYMENT_RESULT_CODE) {
            val payment = data!!.getSerializableExtra(MercadoPagoCheckout.EXTRA_PAYMENT_RESULT) as Payment
            val paymentStatus = payment.paymentStatus
            val paymentStatusDetails = payment.paymentStatusDetail
            val paymentID = payment.id

            val arrayList = ArrayList<String>()
            arrayList.add(paymentID.toString())
            arrayList.add(paymentStatus)
            arrayList.add(paymentStatusDetails)

            channelMercadoPagoRespuesta.invokeMethod("mercadoPagoOK", arrayList)
        } else if (resultCode == Activity.RESULT_CANCELED) {
            val arrayList = ArrayList<String>()
            arrayList.add("pagoError")
            channelMercadoPagoRespuesta.invokeMethod("mercadoPagoError", arrayList)
        } else {
            val arrayList = ArrayList<String>()
            arrayList.add("pagoCancelado")
            channelMercadoPagoRespuesta.invokeMethod("mercadoPagoError", arrayList)
        }
    }

}

