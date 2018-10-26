VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "VB6Class2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
    ''' <summary>
    ''' VB6 class example
    ''' </summary>
    ''' \file VB6Class2.cls
    ''' \remarks The original unfiltered source of this file: <A HREF="https://github.com/sevoku/doxygen-vb-filter/blob/master/samples/ClassicVB/VB6Class2.cls">VB6Class2.cls</A>
    
    Private Type SampleType1
        typeItem1 As Long
        typeItem2 As Long
    End Type
    
    Private Enum SampleEnum
        [_First] = 1
        enumItem1 = 1
        enumItem2 = 2
        enumItem3 = 3
        [_Last] = 3
    End Enum
