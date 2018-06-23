﻿package kabam.rotmg.account.web.services {
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.services.SendPasswordReminderTask;
import kabam.rotmg.appengine.api.AppEngineClient;

public class WebSendPasswordReminderTask extends BaseTask implements SendPasswordReminderTask {

    [Inject]
    public var email:String;
    [Inject]
    public var client:AppEngineClient;


    override protected function startTask():void {
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/account/forgotPassword", {"guid": this.email});
    }

    private function onComplete(_arg1:Boolean, _arg2:*):void {
        if (_arg1) {
            this.onForgotDone();
        }
        else {
            this.onForgotError(_arg2);
        }
    }

    private function onForgotDone():void {
        completeTask(true);
    }

    private function onForgotError(_arg1:String):void {
        completeTask(false, _arg1);
    }


}
}
