package com.example.androidclient.ui;

import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.example.androidclient.R;
import com.example.androidclient.utils.HTTPRequest;

import org.json.JSONException;
import org.json.JSONObject;

import java.net.MalformedURLException;
import java.net.URL;
import java.time.LocalDateTime;
import java.util.Objects;
import java.util.Optional;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.ExecutionException;

public class OrdersActivity extends AppCompatActivity {

    private String ip;
    private String login;
    private String password;
    private String orderId = null;
    private String orderAddress = null;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_orders);

        Bundle bundle = getIntent().getExtras();
        ip = bundle.getString("ip");
        login = bundle.getString("login");
        password = bundle.getString("password");

        Objects.requireNonNull(getSupportActionBar()).setDisplayHomeAsUpEnabled(false);

        try {
            requestNewOrder();
        } catch (MalformedURLException | JSONException | ExecutionException | InterruptedException e) {
            e.printStackTrace();
        }

        final Handler handler = new Handler(Looper.getMainLooper());
        updateUi();

        Timer timer = new Timer();
        TimerTask task = new TimerTask(){
            @Override
            public void run() {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    Log.i("test", LocalDateTime.now().toString());
                }
                try {
                    requestNewOrder();
                    handler.post(new Runnable() {
                        @Override
                        public void run() {
                            updateUi();
                        }
                    });
                } catch (MalformedURLException | JSONException | ExecutionException | InterruptedException e) {
                    e.printStackTrace();
                }
            }
        };
        timer.schedule(task, 0, 60_000);
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

        Optional<JSONObject> response = HTTPRequest.request(url, json);

        if (response.isPresent()) {
            JSONObject jsonResponse = response.get();
            if (!jsonResponse.has("status")) {
                orderId = jsonResponse.getString("id");
                orderAddress = jsonResponse.getString("delivery_address");
            }
        }
    }

    public void updateUi() {
        TextView textView = findViewById(R.id.textOrder);
        if (orderId != null) {
            textView.setText(
                    String.format("Номер заказа: %s\nАдрес: %s", orderId, orderAddress));
        } else {
            textView.setText("Нет актиыных заказов");
        }
        Button completeButton = findViewById(R.id.buttonOrderDelvired);
        completeButton.setClickable(orderId != null);
    }

    public void onCompleteBtnClick(View view) throws JSONException, MalformedURLException, ExecutionException, InterruptedException {

        URL url = new URL("http://" + ip + "/orders/complete/");

        JSONObject json = new JSONObject();
        json.put("id", orderId);

        Optional<JSONObject> response = HTTPRequest.request(url, json);

        if (response.isPresent()) {
            JSONObject jsonResponse = response.get();
            if (((String) jsonResponse.get("status")).equals("ok")) {
                Toast.makeText(getApplicationContext(), "Заказ завершен", Toast.LENGTH_SHORT).show();
                requestNewOrder();
                orderId = null;
                orderAddress = null;
            } else {
                Toast.makeText(getApplicationContext(), "Ошибка", Toast.LENGTH_SHORT).show();
            }
        } else {
            Toast.makeText(getApplicationContext(), "Ошибка соединения", Toast.LENGTH_SHORT).show();
        }
    }

    public void onRefreshBtnClick(View view) throws InterruptedException, MalformedURLException, ExecutionException, JSONException {
        requestNewOrder();
        updateUi();
    }

    public void onLogoutBtnClick(View view) throws MalformedURLException, JSONException, ExecutionException, InterruptedException {

        URL url = new URL("http://" + ip + "/couriers/logout/");

        JSONObject json = new JSONObject();
        json.put("login", login);
        json.put("password", password);

        Optional<JSONObject> response = HTTPRequest.request(url, json);

        if (response.isPresent()) {
            JSONObject jsonResponse = response.get();
            if (((String) jsonResponse.get("status")).equals("logout successfully")) {
                Toast.makeText(getApplicationContext(), "Выход", Toast.LENGTH_SHORT).show();
                onBackPressed();
            } else {
                Toast.makeText(getApplicationContext(), "Ошибка", Toast.LENGTH_SHORT).show();
            }
        } else {
            Toast.makeText(getApplicationContext(), "Ошибка соединения", Toast.LENGTH_SHORT).show();
        }
    }
}
