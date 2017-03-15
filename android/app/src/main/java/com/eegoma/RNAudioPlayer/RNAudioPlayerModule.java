package com.eegoma.RNAudioPlayer;

import android.media.AudioManager;
import android.media.MediaPlayer;
import android.net.Uri;
import android.support.annotation.Nullable;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;

import java.io.IOException;

public class RNAudioPlayerModule extends ReactContextBaseJavaModule implements MediaPlayer.OnPreparedListener {

    ReactApplicationContext reactContext;
    MediaPlayer mMediaPlayer;

    public RNAudioPlayerModule(ReactApplicationContext reactContext) {
        super(reactContext);

        this.reactContext = reactContext;
        this.mMediaPlayer = new MediaPlayer();
    }

    @Override
    public String getName() {
        return "RNAudioPlayer";
    }

    private void sendEvent(String eventName, @Nullable WritableMap params) {
        this.reactContext
                .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                .emit(eventName, params);
    }

    @ReactMethod
    public void play() {
        Uri uri = Uri.parse("https://api.soundcloud.com/tracks/302064339/stream?client_id=3ed8237e8a4bfc63db818a732c95bc38");

        try {
            mMediaPlayer.reset();
            mMediaPlayer.setAudioStreamType(AudioManager.STREAM_MUSIC);
            mMediaPlayer.setDataSource(uri.toString());
            mMediaPlayer.prepareAsync();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @ReactMethod
    public void pause() {
        mMediaPlayer.pause();

        WritableMap params = Arguments.createMap();
        params.putString("state", "PAUSED");
        sendEvent("onPlaybackStateChanged", params);
    }

    @ReactMethod
    public void isPlaying(Callback cb) {
        cb.invoke(mMediaPlayer.isPlaying());
    }

    @Override
    public void onPrepared(MediaPlayer mp) {
        mMediaPlayer.start();

        WritableMap params = Arguments.createMap();
        params.putString("state", "PLAYING");
        sendEvent("onPlaybackStateChanged", params);
    }
}