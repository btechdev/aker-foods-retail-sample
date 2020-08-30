/// Indicates the animation status
/// [showing] CustomSnackBar has been displayed and visible to the user
/// [dismissed] CustomSnackBar has been dismissed and not visible to user
/// and returned any pending values
/// [isHiding] CustomSnackBar is moving towards the state of [dismissed]
/// [isAppearing] CustomSnackBar is moving towards the state of [showing]
enum CustomSnackBarStatus { showing, dismissed, isHiding, isAppearing }

/// Indicates if snack bar being shown is representing [success] or [error]
enum CustomSnackBarType { success, error }

/// Indicates if snack bar is going to be shown at the [top] or [bottom]
enum CustomSnackBarPosition { top, bottom }

const int customSnackBarDefaultTimeDurationInSeconds = 5;
