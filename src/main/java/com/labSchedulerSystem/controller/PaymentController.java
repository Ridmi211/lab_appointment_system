/*
 * package com.labSchedulerSystem.controller;
 * 
 * import java.io.IOException; import javax.servlet.ServletException; import
 * javax.servlet.http.HttpServlet; import javax.servlet.http.HttpServletRequest;
 * import javax.servlet.http.HttpServletResponse; import
 * com.labSchedulerSystem.model.PaymentResponse; import
 * com.labSchedulerSystem.service.PaymentService; import
 * com.stripe.exception.StripeException; import com.stripe.model.PaymentIntent;
 * import javax.servlet.http.HttpServlet; import
 * javax.servlet.http.HttpServletRequest; import
 * javax.servlet.http.HttpServletResponse; import java.io.IOException;
 * 
 * 
 *//**
	 * Servlet implementation class PaymentController
	 *//*
		 * public class PaymentController extends HttpServlet { private static final
		 * long serialVersionUID = 1L;
		 * 
		 * 
		 * protected void doPost(HttpServletRequest request, HttpServletResponse
		 * response) throws IOException { try { // Retrieve amount and currency from
		 * request (you need to pass these from frontend) int amount =
		 * Integer.parseInt(request.getParameter("amount")); String currency =
		 * request.getParameter("currency");
		 * 
		 * // Create a Payment Intent PaymentIntent paymentIntent =
		 * PaymentService.createPaymentIntent(amount, currency);
		 * 
		 * // Send Payment Intent ID back to frontend
		 * response.getWriter().print(paymentIntent.getId()); } catch (StripeException
		 * e) { // Handle Stripe exception response.getWriter().print(e.getMessage()); }
		 * }
		 * 
		 * protected void doGet(HttpServletRequest request, HttpServletResponse
		 * response) throws IOException { try { // Retrieve Payment Intent ID from
		 * request String paymentIntentId = request.getParameter("paymentIntentId");
		 * 
		 * // Process payment using Payment Intent ID PaymentIntent paymentIntent =
		 * PaymentService.processPayment(paymentIntentId);
		 * 
		 * // Send PaymentResponse back to frontend PaymentResponse paymentResponse =
		 * new PaymentResponse(paymentIntent.getStatus());
		 * response.getWriter().print(paymentResponse.toJSON()); } catch
		 * (StripeException e) { // Handle Stripe exception
		 * response.getWriter().print(e.getMessage()); } } }
		 */