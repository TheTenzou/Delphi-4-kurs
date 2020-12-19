package com.example.androidclient.ui;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.example.androidclient.R;
import com.example.androidclient.utils.HTTPRequest;

import org.json.JSONException;
import org.json.JSONObject;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.Optional;
import java.util.concurrent.ExecutionException;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void onClickBtnLogin(View view) throws MalformedURLException, JSONException, ExecutionException, InterruptedException {
        final EditText editTextIp = findViewById(R.id.editTextIp);
        final EditText editTextLogin = findViewById(R.id.editTextLogin);
        final EditText editTextPassword = findViewById(R.id.editTextTextPassword);

        URL url = new URL("http://" + editTextIp.getText().toString() + "/couriers/login/");

        JSONObject json = new JSONObject();
        json.put("login", editTextLogin.getText().toString());
        json.put("password", editTextPassword.getText().toString());

        Optional<JSONObject> respose = HTTPRequest.request(url, json);

        if (respose.isPresent()) {
            JSONObject jsonResponse = respose.get();
            if (jsonResponse.get("status").equals("login successfully")) {
                Intent intent = new Intent(this, OrdersActivity.class);
                intent.putExtra("ip", editTextIp.getText().toString());
                intent.putExtra("login", editTextLogin.getText().toString());
                startActivity(intent);
            } else {
                Toast.makeText(getApplicationContext(),
                        "Ошибка в логине или пароле", Toast.LENGTH_SHORT).show();
            }
        } else {
            Toast.makeText(getApplicationContext(), "Ошибка в ip", Toast.LENGTH_SHORT).show();
        }
    }
}