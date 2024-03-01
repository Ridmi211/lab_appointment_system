/*
 * package com.labSchedulerSystem.service; import com.stripe.Stripe; import
 * com.stripe.exception.StripeException; import com.stripe.model.PaymentIntent;
 * import java.util.HashMap; import java.util.Map;
 * 
 * public class PaymentService {
 * 
 * 
 * 
 * // Initialize Stripe API with your secret key static { Stripe.apiKey =
 * "sk_test_51OngVEJqNxGdKkQYa9YDIVHUNkh1q8NbvIP36l06C92u9FrwMP70HcqNBgxow045qK25FjnREVl7B4Kasx8n7ast00GBcrAnCL";
 * }
 * 
 * // Create a Payment Intent public static PaymentIntent
 * createPaymentIntent(int amountInCents, String currency) throws
 * StripeException { Map<String, Object> params = new HashMap<>();
 * params.put("amount", amountInCents); params.put("currency", currency);
 * params.put("payment_method_types", "card"); return
 * PaymentIntent.create(params); }
 * 
 * // Process payment for a given Payment Intent ID public static PaymentIntent
 * processPayment(String paymentIntentId) throws StripeException { return
 * PaymentIntent.retrieve(paymentIntentId).confirm(); } }
 */