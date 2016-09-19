<?php
use App\User;
use App\Http\Requests;
use Carbon\Carbon;
use Illuminate\Support\Facades\Cookie;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\Mail;

class MyExamples extends Controller
{
    public function profile($username = null)
    {
        $videoImagePath = 'backend/videoImages/';
        try {
            if ($username != null && session('user') != $username) {
                if (session('user')) {
                    $user = User::where(['username' => $username])->first();
                    if ($user) {
                        $followedVideos = VideoFollower::where(['followerID' => $user->userID])
                            ->join('videoproperties', 'videoproperties.videoID', '=', 'videofollowers.videoID')
                            ->get();
                        return view('backend.user.profile', [
                            'user' => $user,
                            'title' => trans('controllerTranslations.user_profile'),
                            'videoImagePath' => $videoImagePath,
                            'followedVideos' => $followedVideos]);
                    } else {
                        return redirect('/user/login');
                    }
                } else {
                    return redirect('/user/login');
                }
            } else {
                if (session('user')) {
                    $username = session('user');
                    $user = User::where(['username' => $username])->first();
                    $activities = Activity::where(['userID' => $user->userID])->orderBy('activityID', 'desc')->simplePaginate(20);
                    if ($user) {
                        $followedVideos = VideoFollower::where(['followerID' => $user->userID])
                            ->join('videoproperties', 'videoproperties.videoID', '=', 'videofollowers.videoID')
                            ->get();
                        return view('backend.user.profile', [
                            'user' => $user,
                            'activities' => $activities,
                            'title' => trans('controllerTranslations.user_profile'),
                            'videoImagePath' => $videoImagePath,
                            'followedVideos' => $followedVideos]);
                    } else {
                        return redirect('/user/login');
                    }
                } else {
                    return redirect('/user/login');
                }
            }
        } catch (\Exception $ex) {
            return $ex->getMessage();
        }
    }


    public function finishSubtitle($subtitleID){
        $selectFixes=DB::table('subtitlerows')
            ->join('subtitlefixes','subtitlefixes.rowNumber','=','subtitlerows.rowNumber')
            ->select('subtitlefixes.rowNumber','subtitlerows.duration','subtitlefixes.newMean')
            ->where(['subtitlerows.subtitleID'=>$subtitleID])
            ->where(['subtitlefixes.subtitleID'=>$subtitleID])
            ->where(['subtitlefixes.bestTranslate'=>1])
            ->orderBy('subtitlerows.rowNumber')
            ->get();
        $subtitle = Subtitle::find($subtitleID);
        $video = DB::table('subtitle')
            ->join('videoproperties','videoproperties.videoID','=','subtitle.videoID')
            ->where(['subtitle.subtitleID'=>$subtitleID])
            ->select('videoproperties.name','videoproperties.videoID')
            ->first();
        if(!$subtitle || !$video) return redirect()->back();

        $filePath   =   storage_path().'/backend/translatedSrt/'.$subtitle->toLanguage."-hizlialtyazi-".$subtitle->translatingSrtPath;
        $file = fopen($filePath, "w");
        $subtitle->translatedSrtPath=$subtitle->toLanguage."-hizlialtyazi-".$subtitle->translatingSrtPath;
        $subtitle->save();
        foreach($selectFixes as $rows){
            file_put_contents($filePath, $rows->rowNumber."\n", FILE_APPEND | LOCK_EX);
            file_put_contents($filePath, $rows->duration."\n", FILE_APPEND | LOCK_EX);
            file_put_contents($filePath, $rows->newMean."\n\n", FILE_APPEND | LOCK_EX);
        }
        fclose($file);

        $mailToFollowers = DB::table('videofollowers')
            ->where(['videoID'=>$subtitle->videoID])
            ->join('users','users.userID','=','videofollowers.followerID')
            ->select('users.username','users.email')->get();
        $videoLink = 'video/'.\App\Functions::beGoodSeo(stripslashes($video->name)).'/'.$video->videoID;
        $comment="";
        if($subtitle->season){
            $comment = trans('pageTranslations.season').' : '.$subtitle->season.' / '.trans('pageTranslations.part').' : '.$subtitle->part;
        }

        $comment.="\n".$subtitle->translatedSrtPath;
        foreach($mailToFollowers as $user){
            Mail::queue('backend.user.followerInform',[
                'username'  =>  $user->username,
                'comment'   =>  $comment,
                'videoLink' =>  $videoLink
            ],function($message) use ($user,$video){
                $message->from('noreply@hizlialtyazi.com',trans('pageTranslations.domain'))->to($user->email,$user->username)->subject(trans('controllerTranslations.new_subtitle_translate_is_complated').' - '.$video->name);
            });
        }
        return redirect('/video/' . Functions::beGoodSeo($video->name) . '/' . $video->videoID);
    }
}
