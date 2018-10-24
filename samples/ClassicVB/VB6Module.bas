Attribute VB_Name = "VB6Module"
' <summary>VB6 Module Example</summary>
' <remarks>The original unfiltered source of this file: <A HREF="http://trac.sevo.org/projects/doxyvb/browser/trunk/samples/ClassicVB/VB6Module.bas">VB6Module.bas</A></remarks>

' <summary>
' simple VB6 Public Enum
' </summary>
Public Enum SampleEnum1
    [_First] = 1
    ''' First enum item
    First_Item = 1
    Second_Item = 2 'Second enum item
    Third_Item = 3 'Third enum item
    [_Last] = 3
End Enum

' <summary>
' simple VB6 Private Enum
' </summary>
Private Enum SampleEnum2
    [_First] = 1
    First_Item = 1 'First enum item
    ''' Second emum item
    Second_Item = 2
    Third_Item = 3 'Third enum item
    [_Last] = 3
End Enum

' <summary>
' simple VB6 Type
' </summary>
Public Type SampleVB6Type

    Private someInteger As Integer ' simple private integer value
    Public someString As String    ' simple public string value

End Type

' <summary>
' function with parameter
' </summary>
' <param name="pFirst">simple parameter</param>
' <returns>some double value</returns>
' <remarks></remarks>
Public Function SampleModuleFunction(ByVal pFirst As Double) As Double
    SampleFunction = pFirst
End Function

' <summary>
' simple method
' </summary>
' <remarks></remarks>
Sub SampleModuleMethod()

End Sub


