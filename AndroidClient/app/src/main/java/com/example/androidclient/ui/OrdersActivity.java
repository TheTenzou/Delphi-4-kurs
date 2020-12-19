package com.example.androidclient.ui;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.widget.EditText;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.example.androidclient.R;
import com.example.androidclient.utils.HTTPRequest;

import org.json.JSONException;
import org.json.JSONObject;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.Objects;
import java.util.Optional;
import java.util.concurrent.ExecutionException;

public class OrdersActivity extends AppCompatActivity {

    private String ip;
    private String login;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_orders);

        Bundle bundle = getIntent().getExtras();
        ip = bundle.getString("ip");
        login = bundle.getString("login");

        Objects.requireNonNull(getSupportActionBar()).setDisplayHomeAsUpEnabled(false);

        try {
            requestNewOrder();
        } catch (MalformedURLException | JSONException | ExecutionException | InterruptedException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
        Intent intent = new Intent(Intent.ACTION_MAIN);
        intent.addCategory(Intent.CATEGORY_HOME);
        startActivity(intent);
    }

    public void requestNewOrder() throws MalformedURLException, JSONException, ExecutionException, InterruptedException {
        URL url = new URL("http://" + ip + "/orders/next/");

        JSONObject json = new JSONObject();
        json.put("login", login);

        Optional<JSONObject> respose = HTTPRequest.request(url, json);

        if (respose.isPresent()) {
            TextView textView = findViewById(R.id.textOrder);
            JSONObject jsonResponse = respose.get();
            textView.setText(
                    String.format("Номер заказа: %s\nАдрес: %s",
                            jsonResponse.get("id"),
                            jsonResponse.get("delivery_address")));
        }
    }
}
