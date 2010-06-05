' <summary>example file demonstrating Windows API Declares</summary>

Imports System.IO
Imports System.Threading
Imports System.Runtime.Serialization

''' <summary>
''' simple class with Windows API functions
''' </summary>
''' <remarks>implements some windows api functions</remarks>
Public Class WinAPIClass
 
    ''' <summary>
    ''' Places (posts) a message in the message queue associated with the thread.
    ''' </summary>
    ''' <param name="hWnd">A handle to the window whose window procedure is to receive the message.</param>
    ''' <param name="uMsg">The message to be posted.</param>
    ''' <param name="wParam">Additional message-specific information.</param>
    ''' <param name="lParam">Additional message-specific information.</param>
    ''' <returns>If the function succeeds, the return value is nonzero.</returns>
    Private Declare Function PostMessage Lib "user32.dll" Alias "PostMessageA" _
        (ByVal hWnd As Integer, _
        ByVal uMsg As Integer, _
        ByVal wParam As Integer, _
        ByVal lParam As Integer _
    ) As Boolean

    ''' <summary>
    ''' Brings the thread that created the specified window into the foreground and activates the window
    ''' </summary>
    ''' <param name="handle">A handle to the window that should be activated and brought to the foreground.</param>
    ''' <returns>If the window was brought to the foreground, the return value is nonzero.</returns>
    Private Declare Function SetForegroundWindow Lib "user32.dll" ( _
        ByVal handle As IntPtr _
    ) As Boolean

    ''' <summary>
    ''' Sets the specified window's show state. 
    ''' </summary>
    ''' <param name="hWnd">A handle to the window.</param>
    ''' <param name="nCmdShow">Controls how the window is to be shown</param>
    ''' <returns>If the window was previously visible, the return value is nonzero</returns>
    Private Declare Function ShowWindow Lib "user32.dll" ( _
        ByVal hWnd As IntPtr, _
        ByVal nCmdShow As SHOW_WINDOW _
    ) As Boolean

    ''' <summary>
    ''' Retrieves the show state and the restored, minimized, and maximized positions of the specified window. 
    ''' </summary>
    ''' <param name="hwnd">A handle to the window. </param>
    ''' <param name="lpwndpl">A pointer to the WINDOWPLACEMENT structure that receives the show state and position information.</param>
    ''' <returns>If the function succeeds, the return value is nonzero.</returns>
    ''' <remarks></remarks>
    Private Declare Function GetWindowPlacement Lib "user32" ( _
        ByVal hwnd As IntPtr, _
        ByRef lpwndpl As WINDOWPLACEMENT _
    ) As Integer

    ''' <summary>
    ''' Contains information about the placement of a window on the screen.
    ''' </summary>
    Private Structure WINDOWPLACEMENT
        Public Length As Integer
        Public flags As Integer
        ''' <summary>
        ''' The current show state of the window
        ''' </summary>
        Public showCmd As Integer
        Public ptMinPosition As POINTAPI
        Public ptMaxPosition As POINTAPI
        Public rcNormalPosition As RECT
    End Structure
    ''' <summary>
    ''' The POINT structure defines the x- and y- coordinates of a point
    ''' </summary>
    Private Structure POINTAPI
        Public x As Integer
        Public y As Integer
    End Structure
    ''' <summary>
    ''' The RECT structure defines the coordinates of the upper-left and lower-right corners of a rectangle.
    ''' </summary>
    Private Structure RECT
        Public Left As Integer
        Public Top As Integer
        Public Right As Integer
        Public Bottom As Integer
    End Structure

    ''' <summary>
    ''' default windows message code for communication between applications
    ''' </summary>
    ''' <remarks>WM_USER is outdated and should not be used</remarks>
    Private Const WM_APP = &H8000

    ''' <summary>
    ''' system command windows message
    ''' </summary>
    ''' <remarks>is used to send system events to a window</remarks>
    Private Const WM_SYSCOMMAND = &H112

    ''' <summary>
    ''' cloase parameter for system command windows message
    ''' </summary>
    ''' <remarks>is used to send a close event to a window</remarks>
    Private Const SC_CLOSE = &HF060&

    ''' <summary>
    ''' Enumeration of window status codes
    ''' </summary>
    <Flags()> _
    Private Enum SHOW_WINDOW As Integer
        SW_HIDE = 0
        SW_SHOWNORMAL = 1
        SW_NORMAL = 1
        SW_SHOWMINIMIZED = 2
        SW_SHOWMAXIMIZED = 3
        SW_MAXIMIZE = 3
        SW_SHOWNOACTIVATE = 4
        SW_SHOW = 5
        SW_MINIMIZE = 6
        SW_SHOWMINNOACTIVE = 7
        SW_SHOWNA = 8
        SW_RESTORE = 9
        SW_SHOWDEFAULT = 10
        SW_FORCEMINIMIZE = 11
        SW_MAX = 11
    End Enum

    ''' <summary>
    ''' Retrieves the length, in characters, of the specified window's title bar text
    ''' </summary>
    ''' <param name="hwnd">A handle to the window or control.</param>
    ''' <returns>If the function succeeds, the return value is the length, in characters, of the text.</returns>
    Private Declare Function GetWindowTextLength Lib "user32.dll" _
        Alias "GetWindowTextLengthA" ( _
        ByVal hwnd As Integer _
    ) As Integer

    ''' <summary>
    ''' Copies the text of the specified window's title bar (if it has one) into a buffer
    ''' </summary>
    ''' <param name="hwnd">A handle to the window or control containing the text.</param>
    ''' <param name="lpString">The buffer that will receive the text.</param>
    ''' <param name="cch">The maximum number of characters to copy to the buffer, including the null character.</param>
    ''' <returns>If the function succeeds, the return value is the length, in characters, of the copied string, not including the terminating null character.</returns>
    Private Declare Function GetWindowText Lib "user32" _
        Alias "GetWindowTextA" ( _
        ByVal hwnd As Integer, _
        ByVal lpString As String, _
        ByVal cch As Integer _
    ) As Integer

    ''' <summary>
    ''' Retrieves the identifier of the thread that created the specified window
    ''' </summary>
    ''' <param name="hwnd">A handle to the window.</param>
    ''' <param name="lpdwProcessId">A pointer to a variable that receives the process identifier.</param>
    ''' <returns>The return value is the identifier of the thread that created the window. </returns>
    Public Declare Auto Function GetWindowThreadProcessId Lib "user32" ( _
        ByVal hwnd As Integer, _
        ByRef lpdwProcessId As Integer _
    ) As Integer

    ''' <summary>
    ''' Enumerates all top-level windows on the screen by passing the handle to each window, in turn, to an application-defined callback function.
    ''' </summary>
    ''' <param name="lpEnumFunc">A pointer to an application-defined callback function.</param>
    ''' <param name="lParam">An application-defined value to be passed to the callback function.</param>
    ''' <returns>If the function succeeds, the return value is nonzero.</returns>
    Private Declare Function EnumWindows Lib "user32" ( _
        ByVal lpEnumFunc As EnumWindowsCallBack, _
        ByVal lParam As Integer _
    ) As Integer
End Class
