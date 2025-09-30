let strength = 0;
const js_slider = bnb.scene.getAssetManager().findMaterial("shaders/retouch").findParameter("js_slider")


function setMorphingStrength(str){
    bnb.scene.getComponents(bnb.ComponentType.FACE_MORPHING)[0].asFaceMorphing().setWeight(str);
}

function setAll(a = 0){
    strength = a <= 1.5 ? a : 1.5;
    setMorphingStrength(0);
    js_slider.setVector4(new bnb.Vec4(strength/1.5, 0., 0., 0.))
}

require("bnb_js/timers.js")

Background = require('bnb_js/background');
Background.contentMode("fit")
let endTime = 0;
let interval;
let isEnded = false;
let isPaused = false;

function setBgTexture(path){
    Background.texture(path);
}

function clearBgTexture(path){
    Background.texture('');
}

function enableBgBlur(){
    Background.blur(0.9);
}

function disableBgBlur(){
    Background.blur(0);
}

function setBgVideo(path){
    Background.texture(path, false, true);
}

function setBgTextureByFd(fd){
    Background.textureImageByFd(fd);
}

function setBgVideoByFd(fd){
    Background.textureVideoByFd(fd, false, true);
}

function rotateBg(angle){
    Background.rotation(angle);
}

function playVideo(){
    Background.getBackgroundVideo().asMedia().play();
}

function resumeVideo(){
    Background.getBackgroundVideo().asMedia().resume();
    isPaused = false;
}

function playVideoRange(start, end){
    const BG = Background.getBackgroundVideo().asMedia();
    isEnded = false;
    isPaused = false;
    BG.setLooped(false);
    BG.setStartPosition(start);
    BG.setEndPosition(end);
    BG.play();
        interval = setInterval(()=>{
            bnb.log(`isPaused: ${isPaused}, isPlaying: ${BG.isPlaying()}`)
            if(BG.isPlaying() == false && isPaused == false){
                BG.setStartPosition(0);
                BG.setLooped(true);
                BG.play();
                clearInterval(interval);
                isEnded = true;
                bnb.log("clear")
            }
        },100)
}

function updatePreview(time, delay){
    endTime = time;
    Background.getBackgroundVideo().asMedia().setStartPosition(endTime);
    Background.getBackgroundVideo().asMedia().setEndPosition(endTime);
    Background.getBackgroundVideo().asMedia().play();
    setTimeout(()=>{
        Background.getBackgroundVideo().asMedia().pause();
    },delay)
}

function stopVideo(){
    clearInterval(interval);
    setTimeout(()=>{
        Background.getBackgroundVideo().asMedia().stop();
    }, 100)
}

function pauseVideo(){
    bnb.log(isEnded)
    isPaused = true;
    isEnded ?? clearInterval(interval);
    setTimeout(()=>{
        Background.getBackgroundVideo().asMedia().pause();
    }, 100)
}

function setBackgroundClearColor(r, g, b, a){
    Background.clearColor(r, g, b, a);
}

function setCameraVideoOrigin(arg){
    Background.cameraVideoOrigin(arg);
}

function setCameraScale(arg){
    Background.cameraVideoScale(arg);
}

setAll();
Background.useFilter(false);
