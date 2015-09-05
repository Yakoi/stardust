module gamelib.collision;

import gamelib.all;
/// ダメージの属性
enum DamageType{
    FIRE, ///炎属性
    PHISICAL, ///物理属性
    MAGICAL, ///魔法的な何か
    WATER, ///水とか
}
/// 状態異常を引き起こす攻撃かどうか
enum BadState{
    NONE, ///状態異常を引き起こさない
    PANIC, ///混乱状態にする
    SLOW, ///鈍足状態にする
    PINSPOT, /// ピンスポ状態にする
}

/// あたったときの状況を記憶するためのクラス
class Collision{
private:
    Vector _pos;
    double _dir;
    int _offence;
    Mover _mover;
    BadState _badState;
    DamageType _type;
    bool _isKnockback;
    bool _isMybullet;
public:
    this(){}
    void init(Vector pos, double dir, int offence, DamageType type,
            BadState badState, Mover mover, bool isKnockback, bool isMybullet){
        this._pos           = pos;
        this._dir           = dir;
        this._offence       = offence;
        this._type          = type;
        this._badState      = badState;
        this._mover         = mover;
        this._isKnockback   = isKnockback;
        this._isMybullet    = isMybullet;
    }
    /// あたった場所
    Vector pos(){return _pos;} 
    /// あたった方向
    double dir(){return _dir;}
    /// お相手の攻撃力
    int offence(){return _offence;}
    /// お相手自身
    Mover mover(){return _mover;}
    /// 属性とか
    DamageType type(){return _type;}
    /// 有効か？
    bool isEnable(){return true;}
    /// 状態異常とかあるかどうか
    BadState badState(){return _badState;}
    /// ノックバックさせるかどうか
    bool isKnockback(){return _isKnockback;}
    /// 相手が自機の弾かどうか
    bool isMybullet(){return _isMybullet;}
}
