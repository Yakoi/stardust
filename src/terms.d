module terms;


static class Terms{
    static class MetaInformation{
	static immutable string PROGRAM_NAME_JP = "ＳＴＡＲ　ＤＵＳＴ";
	static immutable string PROGRAM_NAME_EN = "STAR DUST";
	static immutable string PROGRAM_NAME    = PROGRAM_NAME_EN;
	//static immutable string TEAM_NAME_JP    = "ＫＥＥＰ　ＭＯＶＩＮＧ";
	static immutable string TEAM_NAME_JP    = "エネルギーが足りない";
	//static immutable string TEAM_NAME_JP    = "Ｅｅｒｇｙ　Ｓｈｏｒｔａｇｅ";
	//static immutable string TEAM_NAME_EN    = "KEEP MOVING";
	static immutable string TEAM_NAME_EN    = "Energy Shortage";
	static immutable string TEAM_NAME       = TEAM_NAME_JP;
    }
    static class TitleMenu{
        static immutable string START_GAMES = "ゲームを開始する";
        static immutable string SEE_SCORE = "スコアを見る";
        static immutable string SELECT_MUSIC = "音楽を選ぶ";
        static immutable string EXIT_GAMES = "ゲームを終了する";
    }
    static class TitleHeader{
        static immutable string MAX_SCORE = "HIGHEST SCORE";
        static immutable string STARS_SUM = " ★ ";
    }
    static class TitleHelp{
        static class DecisionButton{
            static immutable string NAME = "Z";
            static immutable string DESCRIPTION = "決定";
        }
        static class CancelButton{
            static immutable string NAME = "X";
            static immutable string DESCRIPTION = "戻る";
        }
	static class Description{
            static immutable string PLAY_REPLAY = "リプレイを再生する";
	    static immutable string RETURN_TO_TITLE = "タイトルに戻る";
	}
    }
    static class Result{
        static immutable string BOUND_NUMBER = "BOUNDS";
        static immutable string STAR_NUMBER  = "STARS ";
        static immutable string SCORE        = "SCORE ";
        static immutable string TIME         = "TIME  ";
    }
}
