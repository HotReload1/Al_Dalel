import 'package:al_dalel/core/data/api_endpoints.dart';
import 'package:al_dalel/layers/data/model/service.dart';

class Constants {
  static final String appName = "Al Dalel";

  static const LANG_AR = 'ar';
  static const LANG_EN = 'en';

  static final List<String> government_services = [
    "جواز سفر",
    "بيان حركة",
    "وصاية شرعية",
    "زواج",
    "طلاق",
    "إخراج قيد",
    "بيان وفاة",
    "بيان حركة",
  ];

  static final List<Service> services = [
    Service(
        name: "المطاعم",
        imageUrl:
            "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/18/f7/4d/79/main-dining-room.jpg?w=600&h=-1&s=1",
        endPoint: EndPoints.ALL_RESTAURANTS_ENDPOINT),
    Service(
        name: "محطات النقل",
        imageUrl:
            "https://static.dezeen.com/uploads/2019/12/station-of-being-arctic-bus-stop-rombout-frieling-lab_dezeen_2364_col_6.jpg",
        endPoint: EndPoints.ALL_BUS_STOP_ENDPOINT),
    Service(
        name: "الساعات",
        imageUrl:
            "https://media.istockphoto.com/id/973117190/photo/luxury-watches-at-showcase.jpg?s=612x612&w=0&k=20&c=52ELH-P1f3kiuN1EX8Lex5Dlprl_X9EsPyH_oh5SAkM=",
        endPoint: EndPoints.ALL_WATCH_STORE_ENDPOINT),
    Service(
        name: "الذهب",
        imageUrl: "https://media.timeout.com/images/102035297/image.jpg",
        endPoint: EndPoints.ALL_GOLD_STORE_ENDPOINT),
    Service(
        name: "المفروشات",
        imageUrl:
            "https://tdf-asia.com/wp-content/uploads/2021/09/Website_Blog_Image_2021_1500px-2.jpg",
        endPoint: EndPoints.ALL_EXHIBITION_ENDPOINT),
    Service(
        name: "الملابس",
        imageUrl:
            "https://i0.wp.com/www.sifascorner.com/wp-content/uploads/2020/09/Best-Online-Clothing-Stores-for-Budget-Shopping-Sifas-Corner-2-scaled.jpg?fit=680%2C496&ssl=1",
        endPoint: EndPoints.ALL_CLOTHES_ENDPOINT),
    Service(
        name: "المكاتب",
        imageUrl:
            "https://npr.brightspotcdn.com/dims4/default/d660798/2147483647/strip/true/crop/2016x1512+0+0/resize/880x660!/quality/90/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F54%2Fc5%2F046296df455d958ba14eb189731e%2Fpost-falls-library-2.jpg",
        endPoint: EndPoints.ALL_LIBRARIES_ENDPOINT),
    Service(
        name: "النظارات",
        imageUrl:
            "https://mir-s3-cdn-cf.behance.net/projects/404/c29bb0186945117.657eb9a36224a.png",
        endPoint: EndPoints.ALL_OPTICAL_STORE_ENDPOINT),
    Service(
        name: "المقاهي",
        imageUrl:
            "https://www.upmenu.com/wp-content/uploads/2023/10/7-cafe-names-cafe-linkosuo.jpg",
        endPoint: EndPoints.ALL_CAFES_ENDPOINT)
  ];
}
