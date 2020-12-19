package com.example.androidclient.utils;

import android.util.Log;

import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Optional;
import java.util.concurrent.Callable;

public class HTTPRequestCallable implements Callable<Optional<JSONObject>> {
    private URL url;
    private JSONObject json;

    public HTTPRequestCallable(URL url, JSONObject json) {
        this.url = url;
        this.json = json;
    }

    @Override
    public Optional<JSONObject> call() {
        Optional<JSONObject> response = Optional.empty();
        try {
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");

            connection.setRequestProperty("Content-Type", "application/json; utf-8");
            connection.setRequestProperty("Accept", "application/json");
            connection.setConnectTimeout(1000);

            connection.setDoOutput(true);


            try (OutputStream outputStream = connection.getOutputStream()) {
                byte[] input = json.toString().getBytes(StandardCharsets.UTF_8);
                outputStream.write(input, 0, input.length);
            }

            int code = connection.getResponseCode();

            try (BufferedReader bufferedReader = new BufferedReader(new
                    InputStreamReader(connection.getInputStream(), StandardCharsets.UTF_8))) {
                StringBuilder stringBuilder = new StringBuilder();
                String responseLine = null;
                while ((responseLine = bufferedReader.readLine()) != null) {
                    stringBuilder.append(responseLine.trim());
                }
                response = Optional.of(new JSONObject(stringBuilder.toString()));
            }
        } catch (Exception e) {
            Log.i("json", "===========================================================");
            e.printStackTrace();
            Log.i("json", "error");
        }

        return response;
    }
}
