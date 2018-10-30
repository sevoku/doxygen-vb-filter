Attribute VB_Name = "VB6Module"
Option Explicit
Option Base 0
' <summary>VB6 Module Example</summary>
' <remarks>The original unfiltered source of this file: <A HREF="http://trac.sevo.org/projects/doxyvb/browser/trunk/samples/ClassicVB/VB6Module.bas">VB6Module.bas</A></remarks>

Public Declare Function GetPrivateProfileStringA Lib "kernel32" ( _
    ByVal strSection As String, _
    ByVal strKey As String, _
    ByVal strDefault As String, _
    ByVal strReturnedString As String, _
    ByVal lngSize As Long, _
    ByVal strFileNameName As String) As Long

''' Global variable example
Public gl_test As Double

' <summary>
' simple VB6 Private Enum
' </summary>
Private Enum SampleEnum
    [_First] = 1
    First_Item = 1 'First enum item
    Second_Item = 2 'Second emum item
    Third_Item = 3
    ''' Fourth enum item
    Fourth_Item = 4
    [_Last] = 4
End Enum

' <summary>
' simple VB6 Structure
' </summary>
Public Structure SampleVB6Structure
    ''' simple private integer value
    Private someInteger As Integer
    ''' simple public string value
    Public someString As String
    Public someLong As Long ' simple public long value
End Structure

' <summary>
' simple VBA/VB6 Type
' </summary>
Public Type SampleVBAType
    ''' simple integer value
    someInteger As Integer
    someString As String ' simple string value
    someLong As Long
    ''' simple single value
    someSingle As Single
End Type

' <summary>
' function with parameter
' </summary>
' <param name="pFirst">simple parameter</param>
' <returns>some double value</returns>
' <remarks>Test remark</remarks>
Public Function SampleModuleFunction(ByVal pFirst As Double) As Double
    SampleFunction = pFirst
End Function

' <summary>
' simple method
' </summary>
' <remarks>Test remark</remarks>
Sub SampleModuleMethod()
End Sub
