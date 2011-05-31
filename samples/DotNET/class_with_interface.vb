' <summary>example file demonstrating interfaces and classes</summary>
' <remarks>detailed file description comes here<BR><BR>
' The original unfiltered source of this file : <A HREF="http://trac.sevo.org/projects/doxyvb/browser/trunk/samples/DotNET/class_with_interface.vb">class_with_interface.vb</A></remarks>

Imports System.IO
Imports System.Threading
Imports System.Runtime.Serialization

''' <summary>
''' simple enumeration
''' </summary>
''' <remarks>description of the simple enumeration</remarks>
Public Enum SampleEnum As Short
    Value1         ' first value
	''' <summary>
	''' second value
	''' </summary>
	Value2
    Value3 = 1234  ' third assigned value
    Value4         ' fourth value
End Enum

''' <summary>
''' sample interface
''' </summary>
''' <remarks>interface inherits IDisposable</remarks>
Public Interface ISample
    Inherits IDisposable

    ''' <summary>
    ''' simple property
    ''' </summary>
    ''' <value>returns a string value</value>
    Property StringProperty() As String

    ''' <summary>
    ''' read only property
    ''' </summary>
    ''' <value>returns an Integer value</value>
    ReadOnly Property IntegerProperty() As Integer

    ''' <summary>
    ''' simple method
    ''' </summary>
    ''' <remarks>no remarks</remarks>
    Sub SampleMethod()

    ''' <summary>
    ''' simple method with parameters
    ''' </summary>
    ''' <param name="pFirst">first parameter is a String</param>
    ''' <param name="pPointer">second parameter is a pointer to an Integer</param>
    ''' <remarks></remarks>
    Sub SampleMethodWithParams(ByVal pFirst As String, ByRef pPointer As Integer)

    ''' <summary>
    ''' simple function with a parameter
    ''' </summary>
    ''' <param name="pFirst">Double parameter</param>
    ''' <returns>a Double value</returns>
    ''' <remarks></remarks>
    Function SampleFunction(ByVal pFirst As Double) As Double

    ''' <summary>
    ''' simple event with a parameter
    ''' </summary>
    ''' <param name="Sender">event sender object</param>
    Event OnSomeEvent(ByVal Sender As Object)

End Interface

''' <summary>
''' simple class implementing an interface
''' </summary>
''' <remarks>Implements ISample</remarks>
Public Class SampleClass
    Implements ISample

    Private someInteger As Integer ' simple private integer value
    Public longArray() As Long     ' long array
    Public someString As String    ' simple public string value
	

    ''' <summary>
    ''' simple property
    ''' </summary>
    ''' <value>some string</value>
    ''' <returns>some string</returns>
    Public Property StringProperty() As String Implements ISample.StringProperty
        Get
            Return someString
        End Get
        Set(ByVal value As String)
            someString = value
        End Set
    End Property

    ''' <summary>
    ''' readonly property
    ''' </summary>
    ''' <value>integer value</value>
    ''' <returns>same interger value</returns>
    Public ReadOnly Property IntegerProperty() As Integer Implements ISample.IntegerProperty
        Get
            Return someInteger
        End Get
    End Property

    ''' <summary>
    ''' function with parameter
    ''' </summary>
    ''' <param name="pFirst">simple parameter</param>
    ''' <returns>some double value</returns>
    ''' <remarks></remarks>
    Public Function SampleFunction(ByVal pFirst As Double) As Double Implements ISample.SampleFunction

    End Function

    ''' <summary>
    ''' function with arrays
    ''' </summary>
    ''' <param name="pFirst">double array as parameter</param>
    ''' <returns>double array</returns>
    ''' <remarks></remarks>
    Public Function SampleFunction2(ByVal pFirst As Double()) As Double()

    End Function

    ''' <summary>
    ''' simple operator
    ''' </summary>
    ''' <param name="Obj1">first simple object</param>
    ''' <param name="Obj2">second simple object</param>
    ''' <returns>True if Obj1 equal to, or bigger than Obj2</returns>
    Public Shared Operator +(ByVal Obj1 As SampleClass, _
                             ByVal Obj2 As SampleClass) As Boolean
    End Operator

    ''' <summary>
    ''' shared/static function
    ''' </summary>
    ''' <returns>a String value</returns>
    Shared Function SampleFunction() As String

    End Function

    ''' <summary>
    ''' simple method
    ''' </summary>
    ''' <remarks></remarks>
    Public Sub SampleMethod() Implements ISample.SampleMethod

    End Sub

    ''' <summary>
    ''' method with parameters
    ''' </summary>
    ''' <param name="pFirst">simple param</param>
    ''' <param name="pPointer">pinter</param>
    ''' <remarks></remarks>
    Public Sub SampleMethodWithParams(ByVal pFirst As String, ByRef pPointer As Integer) Implements ISample.SampleMethodWithParams

    End Sub
	
    ''' <summary>
    ''' method with an array as param
    ''' </summary>
    ''' <param name="pArr">integer array</param>
    ''' <param name="pArg">simple parameter</param>
    ''' <remarks></remarks>
    Public Sub MethodWithArrayParams(ByVal pArr() As Integer, ByVal pArg As Integer)

    End Sub

    ''' <summary>
    ''' some event
    ''' </summary>
    ''' <param name="Sender">sender of object type</param>
    ''' <remarks></remarks>
    Public Event OnSomeEvent(ByVal Sender As Object) Implements ISample.OnSomeEvent

    Private disposedValue As Boolean = False        ' generated by VS class designer

    ''' <summary>
    ''' IDisposable implementation
    ''' </summary>
    ''' <param name="disposing"></param>
    ''' <remarks>Is called from default Dispose method.</remarks>
    Protected Overridable Sub Dispose(ByVal disposing As Boolean)
        If Not Me.disposedValue Then
            If disposing Then
            End If

        End If
        Me.disposedValue = True
    End Sub

    ''' <summary>
    ''' IDisposable implementation
    ''' </summary>
    ''' <remarks></remarks>
    Public Sub Dispose() Implements IDisposable.Dispose
        Dispose(True)
        GC.SuppressFinalize(Me)
    End Sub

End Class
