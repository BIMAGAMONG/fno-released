class StepEvent{
    public var step:Int = 0;
    public var callback:Void -> Void;
    public function new(leStep:Int = 0, leCallback:Void -> Void = null){
        step = leStep;
        callback = leCallback;
    }
}