package com.example.androidclient;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.EditText;

import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void onClickBtnLogin(View view) {
        final EditText editTextIp = findViewById(R.id.editTextIp);
        final EditText editTextLogin = findViewById(R.id.editTextLogin);
        final EditText editTextPassword = findViewById(R.id.editTextTextPassword);
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    URL loginUrl = new URL("http://" + editTextIp.getText().toString() + "/couriers/login/");

                    HttpURLConnection connection = (HttpURLConnection) loginUrl.openConnection();
                    connection.setRequestMethod("POST");

                    connection.setRequestProperty("Content-Type", "application/json; utf-8");
                    connection.setRequestProperty("Accept", "application/json");

                    connection.setDoOutput(true);

                    JSONObject json = new JSONObject();
                    json.put("login", editTextLogin.getText().toString());
                    json.put("password", editTextPassword.getText().toString());

                    try (OutputStream outputStream = connection.getOutputStream()) {
                        byte[] input = json.toString().getBytes(StandardCharsets.UTF_8);
                        outputStream.write(input, 0, input.length);
                    }

                    int code = connection.getResponseCode();

                    Log.i("Json", "" + code);

                    try (BufferedReader bufferedReader = new BufferedReader(new
                            InputStreamReader(connection.getInputStream(), StandardCharsets.UTF_8))) {
                        StringBuilder response = new StringBuilder();
                        String responseLine = null;
                        while ((responseLine = bufferedReader.readLine()) != null) {
                            response.append(responseLine.trim());
                        }
                        Log.i("json", "===========================================================");
                        Log.i("jsonText", response.toString());
                    }

                    Log.i("json", "===========================================================");
                    Log.i("json", "something gone wrong");

                } catch (Exception e) {
                    Log.i("json", "===========================================================");
                    e.printStackTrace();
                    Log.i("json", "error");
                }
            }
        });
        thread.start();
        startActivity(new Intent(this, OrdersActivity.class));
    }
}