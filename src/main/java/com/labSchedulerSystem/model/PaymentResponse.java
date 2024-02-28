package com.labSchedulerSystem.model;


import com.google.gson.Gson;

public class PaymentResponse {

    private String status;

    public PaymentResponse(String status) {
        this.status = status;
    }

    public String getStatus() {
        return status;
    }

    public String toJSON() {
        return new Gson().toJson(this);
    }
}