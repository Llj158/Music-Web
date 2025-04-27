package com.example.music.model;

import lombok.Data;


@Data
public class Result {

    private int code;

    private String message;

    private String type;

    private Boolean success;

    private Object data;

    public static Result success(String message) {
        Result result = new Result();
        result.setCode(200);
        result.setMessage(message);
        result.setSuccess(true);
        result.setType("success");
        result.setData(null);
        return result;
    }

    public static Result success(String message, Object data) {
        Result result = success(message);
        result.setData(data);
        return result;
    }

    public static Result warning(String message) {
        Result result = error(message);
        result.setType("warning");
        return result;
    }

    public static Result error(String message) {
        Result result = success(message);
        result.setSuccess(false);
        result.setType("error");
        return result;
    }

    public static Result fatal(String message) {
        Result result = error(message);
        result.setCode(500);
        return result;
    }
}
