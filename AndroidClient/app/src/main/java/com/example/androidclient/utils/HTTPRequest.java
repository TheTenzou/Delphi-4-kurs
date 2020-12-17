package com.example.androidclient.utils;

import android.util.Log;

import org.json.JSONObject;

import java.net.URL;
import java.util.Optional;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.FutureTask;

public class HTTPRequest {
    static public Optional<JSONObject> request(URL url, JSONObject payload) throws ExecutionException, InterruptedException {
        FutureTask<Optional<JSONObject>> futureTask =
                new FutureTask<>(new HTTPRequestCallable(url, payload));
        Thread thread = new Thread(futureTask);
        thread.start();

        return futureTask.get();
    }
}
