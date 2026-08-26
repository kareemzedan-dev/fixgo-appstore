// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i25;
import '../../features/auth/data/data_sources_impl/auth_remote_data_source_impl.dart'
    as _i154;
import '../../features/auth/data/repos/auth_repo_impl.dart' as _i152;
import '../../features/auth/domain/repos/auth_repo.dart' as _i877;
import '../../features/auth/domain/use_cases/check_user_state_usecase.dart'
    as _i931;
import '../../features/auth/domain/use_cases/delete_account_use_case.dart'
    as _i353;
import '../../features/auth/domain/use_cases/login_use_case.dart' as _i1038;
import '../../features/auth/domain/use_cases/login_with_phone_use_case.dart'
    as _i452;
import '../../features/auth/domain/use_cases/register_use_case.dart' as _i1010;
import '../../features/auth/domain/use_cases/resend_password_reset_otp_use_case.dart'
    as _i1060;
import '../../features/auth/domain/use_cases/reset_password_use_case.dart'
    as _i169;
import '../../features/auth/domain/use_cases/send_otp_use_case.dart' as _i569;
import '../../features/auth/domain/use_cases/send_password_reset_otp_use_case.dart'
    as _i1015;
import '../../features/auth/domain/use_cases/sign_out_use_case.dart' as _i131;
import '../../features/auth/domain/use_cases/update_user_image_use_case.dart'
    as _i238;
import '../../features/auth/domain/use_cases/update_user_location_use_case.dart'
    as _i136;
import '../../features/auth/domain/use_cases/update_user_use_case.dart'
    as _i274;
import '../../features/auth/domain/use_cases/verify_otp_use_case.dart' as _i908;
import '../../features/auth/domain/use_cases/verify_password_reset_otp_use_case.dart'
    as _i566;
import '../../features/auth/domain/use_cases/verify_sign_in_otp_use_case.dart'
    as _i8;
import '../../features/auth/domain/use_cases/verify_update_phone_otp_use_case.dart'
    as _i637;
import '../../features/auth/presentation/manager/auth_cubit/auth_cubit.dart'
    as _i343;
import '../../features/chat/data/data_sources/chat_remote_data_source.dart'
    as _i773;
import '../../features/chat/data/data_sources_impl/chat_remote_data_source_impl.dart'
    as _i1048;
import '../../features/chat/data/repos/chat_repo_impl.dart' as _i415;
import '../../features/chat/domain/repos/chat_repo.dart' as _i1044;
import '../../features/chat/domain/use_cases/delete_chat_use_case.dart'
    as _i716;
import '../../features/chat/domain/use_cases/get_chats_use_case.dart' as _i62;
import '../../features/chat/domain/use_cases/get_messages_use_case.dart'
    as _i529;
import '../../features/chat/domain/use_cases/mark_as_read_use_case.dart'
    as _i811;
import '../../features/chat/domain/use_cases/send_document_use_case.dart'
    as _i877;
import '../../features/chat/domain/use_cases/send_image_use_case.dart' as _i354;
import '../../features/chat/domain/use_cases/send_message_use_case.dart'
    as _i460;
import '../../features/chat/presentation/manager/chat_details_cubit/chat_details_cubit.dart'
    as _i538;
import '../../features/chat/presentation/manager/chats_cubit/chats_cubit.dart'
    as _i209;
import '../../features/favorite/data/data_sources/favorite_remote_data_source.dart'
    as _i749;
import '../../features/favorite/data/data_sources_impl/favorite_remote_data_source_impl.dart'
    as _i805;
import '../../features/favorite/data/repos/favorite_repo_impl.dart' as _i487;
import '../../features/favorite/domain/repos/favorite_repo.dart' as _i308;
import '../../features/favorite/domain/use_cases/get_favorite_offers_use_case.dart'
    as _i421;
import '../../features/favorite/domain/use_cases/get_user_favorites_use_case.dart'
    as _i614;
import '../../features/favorite/domain/use_cases/toggle_favorite_use_case.dart'
    as _i528;
import '../../features/favorite/presentation/manager/favorite_cubit/favorite_cubit.dart'
    as _i906;
import '../../features/home/presentation/tabs/account/data/data_sources/plans_remote_data_source.dart'
    as _i964;
import '../../features/home/presentation/tabs/account/data/data_sources_impl/plans_remote_data_source_impl.dart'
    as _i926;
import '../../features/home/presentation/tabs/account/data/repos/plans_repo_impl.dart'
    as _i346;
import '../../features/home/presentation/tabs/account/domain/repos/plans_repo.dart'
    as _i90;
import '../../features/home/presentation/tabs/account/domain/use_cases/get_plans_use_case.dart'
    as _i887;
import '../../features/home/presentation/tabs/account/presentation/manager/plans/plans_cubit.dart'
    as _i176;
import '../../features/notifications/data/data_sources/notifications_remote_data_source.dart'
    as _i362;
import '../../features/notifications/data/data_sources_impl/notifications_remote_data_source_impl.dart'
    as _i153;
import '../../features/notifications/data/repos/notifications_repo_impl.dart'
    as _i70;
import '../../features/notifications/domain/repos/notifications_repo.dart'
    as _i948;
import '../../features/notifications/domain/use_cases/delete_all_notifications_use_case.dart'
    as _i563;
import '../../features/notifications/domain/use_cases/delete_notification_use_case.dart'
    as _i938;
import '../../features/notifications/domain/use_cases/listen_notifications_use_case.dart'
    as _i323;
import '../../features/notifications/domain/use_cases/mark_all_notifications_as_read_use_case.dart'
    as _i297;
import '../../features/notifications/domain/use_cases/mark_notification_as_read_use_case.dart'
    as _i24;
import '../../features/notifications/presentation/manager/notifications_cubit.dart'
    as _i986;
import '../../features/offers/data/data_sources/offers_remote_data_source.dart'
    as _i584;
import '../../features/offers/data/data_sources_impl/offers_remote_data_source_impl.dart'
    as _i870;
import '../../features/offers/data/repos/offers_repo_impl.dart' as _i159;
import '../../features/offers/domain/repos/offers_repo.dart' as _i1063;
import '../../features/offers/domain/use_cases/add_service_use_case.dart'
    as _i2;
import '../../features/offers/domain/use_cases/count_offer_view_use_case.dart'
    as _i423;
import '../../features/offers/domain/use_cases/get_following_offers_use_case.dart'
    as _i156;
import '../../features/offers/domain/use_cases/get_following_users_data_use_case.dart'
    as _i655;
import '../../features/offers/domain/use_cases/get_following_users_use_case.dart'
    as _i83;
import '../../features/offers/domain/use_cases/get_my_services_use_case.dart'
    as _i611;
import '../../features/offers/domain/use_cases/get_nearby_offers_use_case.dart'
    as _i492;
import '../../features/offers/domain/use_cases/get_offer_details_use_case.dart'
    as _i281;
import '../../features/offers/domain/use_cases/get_offers_by_category_use_case.dart'
    as _i981;
import '../../features/offers/domain/use_cases/get_offers_use_case.dart'
    as _i165;
import '../../features/offers/domain/use_cases/get_provider_data_usecase.dart'
    as _i926;
import '../../features/offers/domain/use_cases/get_provider_services_usecase.dart'
    as _i707;
import '../../features/offers/domain/use_cases/get_recommended_offers_use_case.dart'
    as _i706;
import '../../features/offers/domain/use_cases/get_similar_offers_use_case.dart'
    as _i920;
import '../../features/offers/domain/use_cases/search_offers_use_case.dart'
    as _i606;
import '../../features/offers/domain/use_cases/toggle_favorite_use_case.dart'
    as _i33;
import '../../features/offers/domain/use_cases/toggle_follow_use_case.dart'
    as _i362;
import '../../features/offers/domain/use_cases/update_offer_use_case.dart'
    as _i387;
import '../../features/offers/domain/use_cases/upload_offer_image_use_case.dart'
    as _i160;
import '../../features/offers/domain/use_cases/upload_offer_images_use_case.dart'
    as _i499;
import '../../features/offers/domain/use_cases/watch_boost_offer_status_use_case.dart'
    as _i624;
import '../../features/offers/presentation/manager/add_service_cubit/add_service_cubit.dart'
    as _i308;
import '../../features/offers/presentation/manager/boost_offer_cubit/boost_offer_cubit.dart'
    as _i383;
import '../../features/offers/presentation/manager/offer_details_cubit/offer_details_cubit.dart'
    as _i672;
import '../../features/offers/presentation/manager/offers_cubit/offers_cubit.dart'
    as _i412;
import '../../features/offers/presentation/manager/provider_cubit/provider_cubit.dart'
    as _i905;
import '../../features/offers/presentation/manager/search_cubit/search_cubit.dart'
    as _i327;
import '../../features/offers/presentation/manager/service_category_cubit/service_category_cubit.dart'
    as _i368;
import '../../features/offers/presentation/manager/update_offer_cubit/update_offer_cubit.dart'
    as _i54;
import '../../features/onboarding/data/data_sources/onboarding_local_data_source.dart'
    as _i1057;
import '../../features/onboarding/domain/use_cases/get_onboarding_finished_use_case.dart'
    as _i21;
import '../../features/onboarding/domain/use_cases/set_onboarding_finished_use_case.dart'
    as _i180;
import '../../features/onboarding/presentation/manager/onboarding_cubit.dart'
    as _i1012;
import '../../features/onboarding/presentation/manager/onboarding_view_model.dart'
    as _i914;
import '../../features/reviews/data/data_sources/reviews_remote_data_source.dart'
    as _i293;
import '../../features/reviews/data/data_sources_impl/reviews_remote_data_source_impl.dart'
    as _i867;
import '../../features/reviews/data/repos/reviews_repo_impl.dart' as _i914;
import '../../features/reviews/domain/repos/reviews_repo.dart' as _i28;
import '../../features/reviews/domain/use_cases/add_review_use_case.dart'
    as _i1069;
import '../../features/reviews/domain/use_cases/create_review_notification_use_case.dart'
    as _i35;
import '../../features/reviews/domain/use_cases/delete_review_use_case.dart'
    as _i817;
import '../../features/reviews/domain/use_cases/get_reviews_use_case.dart'
    as _i414;
import '../../features/reviews/domain/use_cases/get_user_review_use_case.dart'
    as _i1020;
import '../../features/reviews/domain/use_cases/update_review_use_case.dart'
    as _i322;
import '../../features/reviews/presentation/manager/reviews_cubit/reviews_cubit.dart'
    as _i229;
import '../../features/splash/presentation/manager/splash_cubit.dart' as _i478;
import '../../features/stories/data/data_sources/stories_remote_data_source.dart'
    as _i584;
import '../../features/stories/data/data_sources_impl/stories_remote_data_source_impl.dart'
    as _i899;
import '../../features/stories/data/repos/stories_repo_impl.dart' as _i177;
import '../../features/stories/domain/repos/stories_repo.dart' as _i65;
import '../../features/stories/domain/use_cases/add_story_use_case.dart'
    as _i996;
import '../../features/stories/domain/use_cases/delete_story_use_case.dart'
    as _i139;
import '../../features/stories/domain/use_cases/get_stories_use_case.dart'
    as _i690;
import '../../features/stories/domain/use_cases/has_viewed_story_use_case.dart'
    as _i162;
import '../../features/stories/domain/use_cases/increment_story_view_use_case.dart'
    as _i500;
import '../../features/stories/domain/use_cases/upload_story_image_use_case.dart'
    as _i693;
import '../../features/stories/presentation/manager/stories_cubit/stories_cubit.dart'
    as _i387;
import '../../features/verification/data/data_sources/verification_remote_data_source.dart'
    as _i615;
import '../../features/verification/data/data_sources_impl/verification_remote_data_source_impl.dart'
    as _i790;
import '../../features/verification/data/repos/verification_repo_impl.dart'
    as _i763;
import '../../features/verification/domain/repos/verification_repo.dart'
    as _i115;
import '../../features/verification/domain/use_cases/get_verification_status_use_case.dart'
    as _i880;
import '../../features/verification/domain/use_cases/pick_verification_image_use_case.dart'
    as _i719;
import '../../features/verification/domain/use_cases/submit_verification_use_case.dart'
    as _i89;
import '../../features/verification/presentation/manager/verification_cubit/verification_cubit.dart'
    as _i388;
import '../../features/view_packages/data/data_sources/remote/boost_package_remote_data_source.dart'
    as _i874;
import '../../features/view_packages/data/data_sources_impl/remote/boost_package_remote_data_source_impl.dart'
    as _i285;
import '../../features/view_packages/data/repos/boost_package_repository_impl.dart'
    as _i635;
import '../../features/view_packages/domain/repos/boost_package_repository.dart'
    as _i192;
import '../../features/view_packages/domain/use_cases/add_boost_package_use_case.dart'
    as _i886;
import '../../features/view_packages/domain/use_cases/delete_boost_package_use_case.dart'
    as _i709;
import '../../features/view_packages/domain/use_cases/get_boost_packages_use_case.dart'
    as _i804;
import '../../features/view_packages/domain/use_cases/toggle_boost_package_use_case.dart'
    as _i475;
import '../../features/view_packages/domain/use_cases/update_boost_package_use_case.dart'
    as _i568;
import '../../features/view_packages/presentation/manager/get_all_boost_package_view_model/get_all_boost_package_view_model.dart'
    as _i572;
import '../services/firebase_services/firebase_auth_services.dart' as _i933;
import '../services/firebase_services/firebase_storage_service.dart' as _i255;
import '../services/firebase_services/view_sponsorship_service.dart' as _i155;
import '../session/app_session_cubit.dart' as _i472;
import '../session/session_local_data_source.dart' as _i332;
import 'firebase_module.dart' as _i616;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final firebaseModule = _$FirebaseModule();
    gh.singleton<_i933.FirebaseAuthServices>(
      () => _i933.FirebaseAuthServices(),
    );
    gh.singleton<_i332.SessionLocalDataSource>(
      () => _i332.SessionLocalDataSource(),
    );
    gh.singleton<_i1057.OnboardingLocalDataSource>(
      () => _i1057.OnboardingLocalDataSource(),
    );
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(
      () => firebaseModule.firebaseFirestore,
    );
    gh.lazySingleton<_i457.FirebaseStorage>(
      () => firebaseModule.firebaseStorage,
    );
    gh.lazySingleton<_i255.FirebaseStorageService>(
      () => _i255.FirebaseStorageService(),
    );
    gh.lazySingleton<_i155.ViewSponsorshipService>(
      () => _i155.ViewSponsorshipService(),
    );
    gh.lazySingleton<_i584.StoriesRemoteDataSource>(
      () => _i899.StoriesRemoteDataSourceImpl(
        firestore: gh<_i974.FirebaseFirestore>(),
        auth: gh<_i59.FirebaseAuth>(),
        storageService: gh<_i255.FirebaseStorageService>(),
      ),
    );
    gh.lazySingleton<_i584.OffersRemoteDataSource>(
      () => _i870.OffersRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
        gh<_i332.SessionLocalDataSource>(),
        gh<_i155.ViewSponsorshipService>(),
        gh<_i255.FirebaseStorageService>(),
      ),
    );
    gh.lazySingleton<_i615.VerificationRemoteDataSource>(
      () => _i790.VerificationRemoteDataSourceImpl(
        firestore: gh<_i974.FirebaseFirestore>(),
        auth: gh<_i59.FirebaseAuth>(),
        storageService: gh<_i255.FirebaseStorageService>(),
      ),
    );
    gh.factory<_i21.GetOnboardingFinishedUseCase>(
      () => _i21.GetOnboardingFinishedUseCase(
        gh<_i1057.OnboardingLocalDataSource>(),
      ),
    );
    gh.factory<_i180.SetOnboardingFinishedUseCase>(
      () => _i180.SetOnboardingFinishedUseCase(
        gh<_i1057.OnboardingLocalDataSource>(),
      ),
    );
    gh.factory<_i874.BoostPackageRemoteDataSource>(
      () => _i285.BoostPackageRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i115.VerificationRepo>(
      () => _i763.VerificationRepoImpl(
        remoteDataSource: gh<_i615.VerificationRemoteDataSource>(),
      ),
    );
    gh.factory<_i964.PlansRemoteDataSource>(
      () => _i926.PlansRemoteDataSourceImpl(),
    );
    gh.factory<_i880.GetVerificationStatusUseCase>(
      () => _i880.GetVerificationStatusUseCase(gh<_i115.VerificationRepo>()),
    );
    gh.factory<_i719.PickVerificationImageUseCase>(
      () => _i719.PickVerificationImageUseCase(gh<_i115.VerificationRepo>()),
    );
    gh.factory<_i89.SubmitVerificationUseCase>(
      () => _i89.SubmitVerificationUseCase(gh<_i115.VerificationRepo>()),
    );
    gh.factory<_i90.PlansRepo>(
      () => _i346.PlansRepoImpl(gh<_i964.PlansRemoteDataSource>()),
    );
    gh.factory<_i1012.OnboardingCubit>(
      () => _i1012.OnboardingCubit(
        gh<_i180.SetOnboardingFinishedUseCase>(),
        gh<_i21.GetOnboardingFinishedUseCase>(),
      ),
    );
    gh.lazySingleton<_i65.StoriesRepo>(
      () => _i177.StoriesRepoImpl(gh<_i584.StoriesRemoteDataSource>()),
    );
    gh.factory<_i887.GetPlansUseCase>(
      () => _i887.GetPlansUseCase(gh<_i90.PlansRepo>()),
    );
    gh.factory<_i192.BoostPackageRepository>(
      () => _i635.BoostPackageRepositoryImpl(
        gh<_i874.BoostPackageRemoteDataSource>(),
      ),
    );
    gh.factory<_i1063.OffersRepo>(
      () => _i159.OffersRepoImpl(gh<_i584.OffersRemoteDataSource>()),
    );
    gh.factory<_i914.OnboardingViewModel>(
      () => _i914.OnboardingViewModel(gh<_i180.SetOnboardingFinishedUseCase>()),
    );
    gh.factory<_i25.AuthRemoteDataSource>(
      () => _i154.AuthRemoteDataSourceImpl(gh<_i332.SessionLocalDataSource>()),
    );
    gh.factory<_i388.VerificationCubit>(
      () => _i388.VerificationCubit(
        gh<_i880.GetVerificationStatusUseCase>(),
        gh<_i89.SubmitVerificationUseCase>(),
        gh<_i719.PickVerificationImageUseCase>(),
      ),
    );
    gh.lazySingleton<_i773.ChatRemoteDataSource>(
      () => _i1048.ChatRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
        gh<_i457.FirebaseStorage>(),
      ),
    );
    gh.lazySingleton<_i362.NotificationsRemoteDataSource>(
      () => _i153.NotificationsRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.factory<_i749.FavoriteRemoteDataSource>(
      () => _i805.FavoriteRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.factory<_i478.SplashCubit>(
      () => _i478.SplashCubit(gh<_i21.GetOnboardingFinishedUseCase>()),
    );
    gh.factory<_i886.AddBoostPackageUseCase>(
      () => _i886.AddBoostPackageUseCase(gh<_i192.BoostPackageRepository>()),
    );
    gh.factory<_i709.DeleteBoostPackageUseCase>(
      () => _i709.DeleteBoostPackageUseCase(gh<_i192.BoostPackageRepository>()),
    );
    gh.factory<_i804.GetBoostPackagesUseCase>(
      () => _i804.GetBoostPackagesUseCase(gh<_i192.BoostPackageRepository>()),
    );
    gh.factory<_i475.ToggleBoostPackageUseCase>(
      () => _i475.ToggleBoostPackageUseCase(gh<_i192.BoostPackageRepository>()),
    );
    gh.factory<_i568.UpdateBoostPackageUseCase>(
      () => _i568.UpdateBoostPackageUseCase(gh<_i192.BoostPackageRepository>()),
    );
    gh.lazySingleton<_i293.ReviewsRemoteDataSource>(
      () => _i867.ReviewsRemoteDataSourceImpl(
        firestore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i28.ReviewsRepo>(
      () => _i914.ReviewsRepoImpl(
        remoteDataSource: gh<_i293.ReviewsRemoteDataSource>(),
      ),
    );
    gh.factory<_i926.GetProviderDataUseCase>(
      () => _i926.GetProviderDataUseCase(gh<_i1063.OffersRepo>()),
    );
    gh.factory<_i707.GetProviderServicesUseCase>(
      () => _i707.GetProviderServicesUseCase(gh<_i1063.OffersRepo>()),
    );
    gh.factory<_i572.GetAllBoostPackageViewModel>(
      () => _i572.GetAllBoostPackageViewModel(
        gh<_i804.GetBoostPackagesUseCase>(),
      ),
    );
    gh.factory<_i176.PlansCubit>(
      () => _i176.PlansCubit(gh<_i887.GetPlansUseCase>()),
    );
    gh.lazySingleton<_i1044.ChatRepo>(
      () => _i415.ChatRepoImpl(gh<_i773.ChatRemoteDataSource>()),
    );
    gh.factory<_i996.AddStoryUseCase>(
      () => _i996.AddStoryUseCase(gh<_i65.StoriesRepo>()),
    );
    gh.factory<_i139.DeleteStoryUseCase>(
      () => _i139.DeleteStoryUseCase(gh<_i65.StoriesRepo>()),
    );
    gh.factory<_i690.GetStoriesUseCase>(
      () => _i690.GetStoriesUseCase(gh<_i65.StoriesRepo>()),
    );
    gh.factory<_i162.HasViewedStoryUseCase>(
      () => _i162.HasViewedStoryUseCase(gh<_i65.StoriesRepo>()),
    );
    gh.factory<_i500.IncrementStoryViewUseCase>(
      () => _i500.IncrementStoryViewUseCase(gh<_i65.StoriesRepo>()),
    );
    gh.factory<_i693.UploadStoryImageUseCase>(
      () => _i693.UploadStoryImageUseCase(gh<_i65.StoriesRepo>()),
    );
    gh.factory<_i905.ProviderCubit>(
      () => _i905.ProviderCubit(
        gh<_i707.GetProviderServicesUseCase>(),
        gh<_i926.GetProviderDataUseCase>(),
      ),
    );
    gh.factory<_i2.AddServiceUseCase>(
      () => _i2.AddServiceUseCase(gh<_i1063.OffersRepo>()),
    );
    gh.factory<_i423.CountOfferViewUseCase>(
      () => _i423.CountOfferViewUseCase(gh<_i1063.OffersRepo>()),
    );
    gh.factory<_i156.GetFollowingOffersUseCase>(
      () => _i156.GetFollowingOffersUseCase(gh<_i1063.OffersRepo>()),
    );
    gh.factory<_i655.GetFollowingUsersDataUseCase>(
      () => _i655.GetFollowingUsersDataUseCase(gh<_i1063.OffersRepo>()),
    );
    gh.factory<_i83.GetFollowingUsersUseCase>(
      () => _i83.GetFollowingUsersUseCase(gh<_i1063.OffersRepo>()),
    );
    gh.factory<_i611.GetMyServicesUseCase>(
      () => _i611.GetMyServicesUseCase(gh<_i1063.OffersRepo>()),
    );
    gh.factory<_i492.GetNearbyOffersUseCase>(
      () => _i492.GetNearbyOffersUseCase(gh<_i1063.OffersRepo>()),
    );
    gh.factory<_i281.GetOfferDetailsUseCase>(
      () => _i281.GetOfferDetailsUseCase(gh<_i1063.OffersRepo>()),
    );
    gh.factory<_i981.GetOffersByCategoryUseCase>(
      () => _i981.GetOffersByCategoryUseCase(gh<_i1063.OffersRepo>()),
    );
    gh.factory<_i165.GetOffersUseCase>(
      () => _i165.GetOffersUseCase(gh<_i1063.OffersRepo>()),
    );
    gh.factory<_i706.GetRecommendedOffersUseCase>(
      () => _i706.GetRecommendedOffersUseCase(gh<_i1063.OffersRepo>()),
    );
    gh.factory<_i920.GetSimilarOffersUseCase>(
      () => _i920.GetSimilarOffersUseCase(gh<_i1063.OffersRepo>()),
    );
    gh.factory<_i606.SearchOffersUseCase>(
      () => _i606.SearchOffersUseCase(gh<_i1063.OffersRepo>()),
    );
    gh.factory<_i33.ToggleFavoriteUseCase>(
      () => _i33.ToggleFavoriteUseCase(gh<_i1063.OffersRepo>()),
    );
    gh.factory<_i362.ToggleFollowUseCase>(
      () => _i362.ToggleFollowUseCase(gh<_i1063.OffersRepo>()),
    );
    gh.factory<_i387.UpdateOfferUseCase>(
      () => _i387.UpdateOfferUseCase(gh<_i1063.OffersRepo>()),
    );
    gh.factory<_i160.UploadOfferImageUseCase>(
      () => _i160.UploadOfferImageUseCase(gh<_i1063.OffersRepo>()),
    );
    gh.factory<_i499.UploadOfferImagesUseCase>(
      () => _i499.UploadOfferImagesUseCase(gh<_i1063.OffersRepo>()),
    );
    gh.factory<_i624.WatchBoostOfferStatusUseCase>(
      () => _i624.WatchBoostOfferStatusUseCase(gh<_i1063.OffersRepo>()),
    );
    gh.factory<_i672.OfferDetailsCubit>(
      () => _i672.OfferDetailsCubit(gh<_i281.GetOfferDetailsUseCase>()),
    );
    gh.factory<_i1069.AddReviewUseCase>(
      () => _i1069.AddReviewUseCase(gh<_i28.ReviewsRepo>()),
    );
    gh.factory<_i35.CreateReviewNotificationUseCase>(
      () => _i35.CreateReviewNotificationUseCase(gh<_i28.ReviewsRepo>()),
    );
    gh.factory<_i817.DeleteReviewUseCase>(
      () => _i817.DeleteReviewUseCase(gh<_i28.ReviewsRepo>()),
    );
    gh.factory<_i414.GetReviewsUseCase>(
      () => _i414.GetReviewsUseCase(gh<_i28.ReviewsRepo>()),
    );
    gh.factory<_i1020.GetUserReviewUseCase>(
      () => _i1020.GetUserReviewUseCase(gh<_i28.ReviewsRepo>()),
    );
    gh.factory<_i322.UpdateReviewUseCase>(
      () => _i322.UpdateReviewUseCase(gh<_i28.ReviewsRepo>()),
    );
    gh.lazySingleton<_i948.NotificationsRepo>(
      () =>
          _i70.NotificationsRepoImpl(gh<_i362.NotificationsRemoteDataSource>()),
    );
    gh.factory<_i387.StoriesCubit>(
      () => _i387.StoriesCubit(
        gh<_i690.GetStoriesUseCase>(),
        gh<_i996.AddStoryUseCase>(),
        gh<_i139.DeleteStoryUseCase>(),
        gh<_i500.IncrementStoryViewUseCase>(),
        gh<_i162.HasViewedStoryUseCase>(),
        gh<_i693.UploadStoryImageUseCase>(),
      ),
    );
    gh.factory<_i308.AddServiceCubit>(
      () => _i308.AddServiceCubit(
        gh<_i2.AddServiceUseCase>(),
        gh<_i499.UploadOfferImagesUseCase>(),
      ),
    );
    gh.factory<_i308.FavoriteRepo>(
      () => _i487.FavoriteRepoImpl(gh<_i749.FavoriteRemoteDataSource>()),
    );
    gh.factory<_i877.AuthRepo>(
      () => _i152.AuthRepoImpl(gh<_i25.AuthRemoteDataSource>()),
    );
    gh.factory<_i229.ReviewsCubit>(
      () => _i229.ReviewsCubit(
        gh<_i414.GetReviewsUseCase>(),
        gh<_i1069.AddReviewUseCase>(),
        gh<_i817.DeleteReviewUseCase>(),
        gh<_i1020.GetUserReviewUseCase>(),
        gh<_i322.UpdateReviewUseCase>(),
        gh<_i35.CreateReviewNotificationUseCase>(),
      ),
    );
    gh.factory<_i383.BoostOfferCubit>(
      () => _i383.BoostOfferCubit(gh<_i624.WatchBoostOfferStatusUseCase>()),
    );
    gh.factory<_i931.CheckUserStateUsecase>(
      () => _i931.CheckUserStateUsecase(gh<_i877.AuthRepo>()),
    );
    gh.factory<_i353.DeleteAccountUseCase>(
      () => _i353.DeleteAccountUseCase(gh<_i877.AuthRepo>()),
    );
    gh.factory<_i1038.LoginUseCase>(
      () => _i1038.LoginUseCase(gh<_i877.AuthRepo>()),
    );
    gh.factory<_i452.LoginWithPhoneUseCase>(
      () => _i452.LoginWithPhoneUseCase(gh<_i877.AuthRepo>()),
    );
    gh.factory<_i1010.RegisterUseCase>(
      () => _i1010.RegisterUseCase(gh<_i877.AuthRepo>()),
    );
    gh.factory<_i1060.ResendPasswordResetOtpUseCase>(
      () => _i1060.ResendPasswordResetOtpUseCase(gh<_i877.AuthRepo>()),
    );
    gh.factory<_i169.ResetPasswordUseCase>(
      () => _i169.ResetPasswordUseCase(gh<_i877.AuthRepo>()),
    );
    gh.factory<_i569.SendOtpUseCase>(
      () => _i569.SendOtpUseCase(gh<_i877.AuthRepo>()),
    );
    gh.factory<_i1015.SendPasswordResetOtpUseCase>(
      () => _i1015.SendPasswordResetOtpUseCase(gh<_i877.AuthRepo>()),
    );
    gh.factory<_i131.SignOutUseCase>(
      () => _i131.SignOutUseCase(gh<_i877.AuthRepo>()),
    );
    gh.factory<_i908.VerifyOtpUseCase>(
      () => _i908.VerifyOtpUseCase(gh<_i877.AuthRepo>()),
    );
    gh.factory<_i566.VerifyPasswordResetOtpUseCase>(
      () => _i566.VerifyPasswordResetOtpUseCase(gh<_i877.AuthRepo>()),
    );
    gh.factory<_i8.VerifySignInOtpUseCase>(
      () => _i8.VerifySignInOtpUseCase(gh<_i877.AuthRepo>()),
    );
    gh.factory<_i472.AppSessionCubit>(
      () => _i472.AppSessionCubit(
        gh<_i332.SessionLocalDataSource>(),
        gh<_i931.CheckUserStateUsecase>(),
      ),
    );
    gh.factory<_i238.UpdateUserImageUseCase>(
      () => _i238.UpdateUserImageUseCase(gh<_i877.AuthRepo>()),
    );
    gh.factory<_i136.UpdateUserLocationUseCase>(
      () => _i136.UpdateUserLocationUseCase(gh<_i877.AuthRepo>()),
    );
    gh.factory<_i274.UpdateUserUseCase>(
      () => _i274.UpdateUserUseCase(gh<_i877.AuthRepo>()),
    );
    gh.factory<_i637.VerifyUpdatePhoneOtpUseCase>(
      () => _i637.VerifyUpdatePhoneOtpUseCase(gh<_i877.AuthRepo>()),
    );
    gh.factory<_i716.DeleteChatUseCase>(
      () => _i716.DeleteChatUseCase(gh<_i1044.ChatRepo>()),
    );
    gh.factory<_i421.GetFavoriteOffersUseCase>(
      () => _i421.GetFavoriteOffersUseCase(gh<_i308.FavoriteRepo>()),
    );
    gh.factory<_i614.GetUserFavoritesUseCase>(
      () => _i614.GetUserFavoritesUseCase(gh<_i308.FavoriteRepo>()),
    );
    gh.factory<_i528.ToggleFavoriteUseCase>(
      () => _i528.ToggleFavoriteUseCase(gh<_i308.FavoriteRepo>()),
    );
    gh.factory<_i563.DeleteAllNotificationsUseCase>(
      () => _i563.DeleteAllNotificationsUseCase(gh<_i948.NotificationsRepo>()),
    );
    gh.factory<_i938.DeleteNotificationUseCase>(
      () => _i938.DeleteNotificationUseCase(gh<_i948.NotificationsRepo>()),
    );
    gh.factory<_i323.ListenNotificationsUseCase>(
      () => _i323.ListenNotificationsUseCase(gh<_i948.NotificationsRepo>()),
    );
    gh.factory<_i297.MarkAllNotificationsAsReadUseCase>(
      () => _i297.MarkAllNotificationsAsReadUseCase(
        gh<_i948.NotificationsRepo>(),
      ),
    );
    gh.factory<_i24.MarkNotificationAsReadUseCase>(
      () => _i24.MarkNotificationAsReadUseCase(gh<_i948.NotificationsRepo>()),
    );
    gh.factory<_i54.UpdateOfferCubit>(
      () => _i54.UpdateOfferCubit(
        gh<_i387.UpdateOfferUseCase>(),
        gh<_i160.UploadOfferImageUseCase>(),
      ),
    );
    gh.factory<_i62.GetChatsUseCase>(
      () => _i62.GetChatsUseCase(gh<_i1044.ChatRepo>()),
    );
    gh.factory<_i529.GetMessagesUseCase>(
      () => _i529.GetMessagesUseCase(gh<_i1044.ChatRepo>()),
    );
    gh.factory<_i811.MarkAsReadUseCase>(
      () => _i811.MarkAsReadUseCase(gh<_i1044.ChatRepo>()),
    );
    gh.factory<_i877.SendDocumentUseCase>(
      () => _i877.SendDocumentUseCase(gh<_i1044.ChatRepo>()),
    );
    gh.factory<_i354.SendImageUseCase>(
      () => _i354.SendImageUseCase(gh<_i1044.ChatRepo>()),
    );
    gh.factory<_i460.SendMessageUseCase>(
      () => _i460.SendMessageUseCase(gh<_i1044.ChatRepo>()),
    );
    gh.factory<_i412.OffersCubit>(
      () => _i412.OffersCubit(
        gh<_i165.GetOffersUseCase>(),
        gh<_i492.GetNearbyOffersUseCase>(),
        gh<_i706.GetRecommendedOffersUseCase>(),
        gh<_i920.GetSimilarOffersUseCase>(),
        gh<_i362.ToggleFollowUseCase>(),
        gh<_i83.GetFollowingUsersUseCase>(),
        gh<_i156.GetFollowingOffersUseCase>(),
        gh<_i472.AppSessionCubit>(),
        gh<_i611.GetMyServicesUseCase>(),
        gh<_i655.GetFollowingUsersDataUseCase>(),
      ),
    );
    gh.factory<_i906.FavoriteCubit>(
      () => _i906.FavoriteCubit(
        gh<_i421.GetFavoriteOffersUseCase>(),
        gh<_i528.ToggleFavoriteUseCase>(),
        gh<_i614.GetUserFavoritesUseCase>(),
      ),
    );
    gh.factory<_i368.ServiceCategoryCubit>(
      () => _i368.ServiceCategoryCubit(gh<_i981.GetOffersByCategoryUseCase>()),
    );
    gh.factory<_i343.AuthCubit>(
      () => _i343.AuthCubit(
        loginWithPhoneUseCase: gh<_i452.LoginWithPhoneUseCase>(),
        sendOtpUseCase: gh<_i569.SendOtpUseCase>(),
        verifyOtpUseCase: gh<_i908.VerifyOtpUseCase>(),
        verifySignInOtpUseCase: gh<_i8.VerifySignInOtpUseCase>(),
        signOutUseCase: gh<_i131.SignOutUseCase>(),
        updateUserUseCase: gh<_i274.UpdateUserUseCase>(),
        registerUseCase: gh<_i1010.RegisterUseCase>(),
        loginUseCase: gh<_i1038.LoginUseCase>(),
        sendPasswordResetOtpUseCase: gh<_i1015.SendPasswordResetOtpUseCase>(),
        verifyPasswordResetOtpUseCase:
            gh<_i566.VerifyPasswordResetOtpUseCase>(),
        resendPasswordResetOtpUseCase:
            gh<_i1060.ResendPasswordResetOtpUseCase>(),
        resetPasswordUseCase: gh<_i169.ResetPasswordUseCase>(),
        deleteAccountUseCase: gh<_i353.DeleteAccountUseCase>(),
        updateUserImageUseCase: gh<_i238.UpdateUserImageUseCase>(),
        updateUserLocationUseCase: gh<_i136.UpdateUserLocationUseCase>(),
        verifyUpdatePhoneOtpUseCase: gh<_i637.VerifyUpdatePhoneOtpUseCase>(),
      ),
    );
    gh.factory<_i327.SearchCubit>(
      () => _i327.SearchCubit(
        gh<_i606.SearchOffersUseCase>(),
        gh<_i423.CountOfferViewUseCase>(),
        gh<_i472.AppSessionCubit>(),
      ),
    );
    gh.factory<_i538.ChatDetailsCubit>(
      () => _i538.ChatDetailsCubit(
        gh<_i529.GetMessagesUseCase>(),
        gh<_i460.SendMessageUseCase>(),
        gh<_i354.SendImageUseCase>(),
        gh<_i877.SendDocumentUseCase>(),
        gh<_i811.MarkAsReadUseCase>(),
      ),
    );
    gh.factory<_i209.ChatsCubit>(
      () => _i209.ChatsCubit(
        gh<_i62.GetChatsUseCase>(),
        gh<_i716.DeleteChatUseCase>(),
      ),
    );
    gh.factory<_i986.NotificationsCubit>(
      () => _i986.NotificationsCubit(
        gh<_i323.ListenNotificationsUseCase>(),
        gh<_i24.MarkNotificationAsReadUseCase>(),
        gh<_i297.MarkAllNotificationsAsReadUseCase>(),
        gh<_i938.DeleteNotificationUseCase>(),
        gh<_i563.DeleteAllNotificationsUseCase>(),
      ),
    );
    return this;
  }
}

class _$FirebaseModule extends _i616.FirebaseModule {}
