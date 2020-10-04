Attribute VB_Name = "Module1"
Sub Stocks():
    
    Dim ws As Worksheet
    Dim Ticker As String
    Dim YearlyChange As Double
    Dim PercentChange As Double
    Dim TotalStockVolume As Double 'Debug Overflow issue. Do not declare as Long.
    Dim StockOpen As Double
    Dim StockClose As Double
    
    For Each ws In Worksheets
    
        ws.Cells(1, 9).Value = "Ticker"
        ws.Cells(1, 10).Value = "Yearly Change"
        ws.Cells(1, 11).Value = "Percent Change"
        ws.Cells(1, 12).Value = "Total Stock Volume"
        
        Range("I1:L1").Columns.AutoFit
    
    m = 2 'row
    
    LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
    
    StockOpen = 0
        
        For i = 2 To LastRow
        
            TotalStockVolume = TotalStockVolume + ws.Cells(i, 7)
        
            If ws.Cells(i, 1).Value <> ws.Cells(i - 1, 1).Value Then
                StockOpen = ws.Cells(i, 3).Value
        
            End If
    
            If ws.Cells(i, 1).Value <> ws.Cells(i + 1, 1).Value Then
                ws.Cells(m, 9).Value = ws.Cells(i, 1).Value
                ws.Cells(m, 12).Value = TotalStockVolume
            
                StockClose = ws.Cells(i, 6).Value

                YearlyChange = StockClose - StockOpen
            
                ws.Cells(m, 10).Value = YearlyChange
        
        
                If YearlyChange >= 0 Then
                    ws.Cells(m, 10).Interior.ColorIndex = 4
            
                Else
                    ws.Cells(m, 10).Interior.ColorIndex = 3
            
                End If
        
            
                If StockOpen = 0 Or StockClose = 0 Then
                    PercentChange = 0
                    ws.Cells(m, 11).Value = PercentChange
                    ws.Cells(m, 11).NumberFormat = "0.00%"
            
                Else
                    PercentChange = YearlyChange / StockOpen
                    ws.Cells(m, 11).Value = PercentChange
                    ws.Cells(m, 11).NumberFormat = "0.00%"
            
                End If
        
                m = m + 1
        
                StockOpen = 0
                StockClose = 0
                TotalStockVolume = 0
                PercentChange = 0
                YearlyChange = 0
        
            End If
        
        Next i
        
        'Solution to Challenge Portion
        
            ws.Cells(2, 15).Value = "Greatest % Increase"
            ws.Cells(3, 15).Value = "Greatest % Decrease"
            ws.Cells(4, 15).Value = "Greatest Total Volume"
            ws.Cells(1, 16).Value = "Ticker"
            ws.Cells(1, 17).Value = "Value"

            LastRowTicker = ws.Cells(Rows.Count, 9).End(xlUp).Row
        
            GreatestIncrease = ws.Cells(2, 11).Value
        
            GreatestDecrease = ws.Cells(2, 11).Value
        
            GreatestVolume = ws.Cells(2, 12).Value
        
                For m = 2 To LastRowTicker
            
                    If ws.Cells(m, 11).Value > GreatestIncrease Then
                        GreatestIncrease = ws.Cells(m, 11).Value
                        TickerIncrease = ws.Cells(m, 9).Value

                    End If
            
                    If ws.Cells(m, 11).Value < GreatestDecrease Then
                        GreatestDecrease = ws.Cells(m, 11).Value
                        TickerDecrease = ws.Cells(m, 9).Value

                    End If
            
                    If ws.Cells(m, 12).Value > GreatestVolume Then
                        GreatestVolume = ws.Cells(m, 12).Value
                        TickerVolume = ws.Cells(m, 9).Value

                    End If

                Next m
        
        
            ws.Cells(2, 16).Value = TickerIncrease
            ws.Cells(2, 17).Value = GreatestIncrease
            ws.Cells(2, 17).NumberFormat = "0.00%"

            ws.Cells(3, 16).Value = TickerDecrease
            ws.Cells(3, 17).Value = GreatestDecrease
            ws.Cells(3, 17).NumberFormat = "0.00%"

            ws.Cells(4, 16).Value = TickerVolume
            ws.Cells(4, 17).Value = GreatestVolume

        Range("O4:Q4").Columns.AutoFit
        Range("P1").Columns.AutoFit
    
    Next ws

End Sub


