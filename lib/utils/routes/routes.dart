import 'package:digitalsaathi/ui/more/content/content.dart';
import 'package:digitalsaathi/ui/more/logout/logout_screen.dart';
import 'package:digitalsaathi/ui/more/meeting/meeting_screen/meeting_screen.dart';
import 'package:digitalsaathi/ui/more/meeting_report/meeting_report_screen.dart';
import 'package:digitalsaathi/ui/more/poster/poster.dart';
import 'package:digitalsaathi/ui/more/progress/progress_screen.dart';
import 'package:digitalsaathi/ui/more/suggestions/suggestion_screen.dart';
import 'package:digitalsaathi/ui/more/task/task.dart';
import 'package:digitalsaathi/ui/more/worker_report/worker_report_screen.dart';
import 'package:digitalsaathi/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

import '../../ui/more/complaint_screen/complaint/complaint_screen.dart';
import '../../ui/more/profile/profile_screen/profile.dart';

class Routes {

  static Route<dynamic>  generateRoute(RouteSettings settings){


    switch(settings.name){
      // case RoutesName.splash:
      //   return MaterialPageRoute(builder: (BuildContext context) =>  Container());
      // case RoutesName.intro:
      //   return MaterialPageRoute(builder: (BuildContext context) => const IntroScreen());
      // case RoutesName.welcome:
      //   return MaterialPageRoute(builder: (BuildContext context) => const WelcomeScreen());
      // case RoutesName.privacypolicy:
      //   return MaterialPageRoute(builder: (BuildContext context) => const PrivacyPolicyScreen());
      // case RoutesName.login:
      //   var id =  settings.arguments;
      //   return MaterialPageRoute(builder: (BuildContext context) =>  LoginScreen(Openfrompayment: id.toString(),));
      // case RoutesName.createpassword:
      //   return MaterialPageRoute(builder: (BuildContext context) => const CreatenewpassScreen());
      // case RoutesName.bottomBar:
      //    var id =  settings.arguments;
      //   return MaterialPageRoute(builder: (BuildContext context) =>  BottombaarWidget(selectedpostion:int.parse(id.toString())));
      // case RoutesName.home:
      //   return MaterialPageRoute(builder: (BuildContext context) => const HomeScreen());
      // case RoutesName.notificationScreen:
      //   return MaterialPageRoute(builder: (BuildContext context) => const NotificationScreen());
      // case RoutesName.derailhomescren:
      //   return MaterialPageRoute(builder: (BuildContext context) => const HomeScreenDetails());
      // case RoutesName.booknow:
      //   return MaterialPageRoute(builder: (BuildContext context) => const Bookdetaiil());
      // case RoutesName.registerscreen:
      //   return MaterialPageRoute(builder: (BuildContext context) => const RegisterWidget());
      // case RoutesName.editProfile:
      //   return MaterialPageRoute(builder: (BuildContext context) => const EditProfile());
      // case RoutesName.cardStripe:
      //   return MaterialPageRoute(builder: (BuildContext context) =>  const Stripepayment());
      // case RoutesName.aboutUs:
      //   return MaterialPageRoute(builder: (BuildContext context) =>  const AboutUsScreen());
      // case RoutesName.termcondition:
      //   return MaterialPageRoute(builder: (BuildContext context) =>  const TermConditionScreen());
      // case RoutesName.bookinglist:
      //   return MaterialPageRoute(builder: (BuildContext context)=> const RoomBookingListUser());
      // case RoutesName.FAQ:
      //   return MaterialPageRoute(builder: (BuildContext context)=> const FaqScreen());
      // case RoutesName.contactUscScreen:
      //   return MaterialPageRoute(builder: (BuildContext context)=> const ContactUsScreen());
      // case RoutesName.chatscreen:
      //   return MaterialPageRoute(builder: (BuildContext context)=> const ChatScreen());
      // case RoutesName.bookingDetailInfo:
      //  var id =  settings.arguments;
      //   return MaterialPageRoute(builder: (BuildContext context)=>  BookingRoomInfo(bookingNum: id.toString(),));
      // case RoutesName.blogScreenGo:
      //  var mapData = settings.arguments as Map;
      //
      //
      //   return MaterialPageRoute(builder: (BuildContext context)=>  BlogDetailsListScreen(slugName: mapData['slugName'].toString(), title: mapData['title'].toString(),));

      case RoutesName.taskScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const TaskScreen(initialTabIndex: 0,));
      case RoutesName.content:
        return MaterialPageRoute(builder: (BuildContext context) => const ContentScreen());
      case RoutesName.poster:
        return MaterialPageRoute(builder: (BuildContext context) => const PosterScreen());
      case RoutesName.profile:
        return MaterialPageRoute(builder: (BuildContext context) => const ProfileScreen());
      case RoutesName.progress:
        return MaterialPageRoute(builder: (BuildContext context) => const ProgressScreen());
      case RoutesName.workerReport:
        return MaterialPageRoute(builder: (BuildContext context) => const WorkerReportScreen());
      case RoutesName.meeting:
        return MaterialPageRoute(builder: (BuildContext context) => const MeetingScreen());
      case RoutesName.meetingReport:
        return MaterialPageRoute(builder: (BuildContext context) => const MeetingReportScreen());
      case RoutesName.complaint:
        return MaterialPageRoute(builder: (BuildContext context) => const ComplaintScreen(createType: "",));
      case RoutesName.suggestions:
        return MaterialPageRoute(builder: (BuildContext context) => const SuggestionScreen());
      case RoutesName.logout:
        return MaterialPageRoute(builder: (BuildContext context) => const LogoutScreen());

      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });

    }
  }
}