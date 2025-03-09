This Majordome based dashboard targeting a (well known HD44780 based) 16x02 
LCD textual display.

> [!WARNING]
> This kind of i2C :arrow_right: PCF8574 :arrow_right: HD44780 displays is actually
> a big hack : Race conditions may crash the display controler which will display
> garbages instead of your valuable information.<br>
> Only a power cycle can reset this controler. There is no way at code side to
> correct this situation.

# Running

> [!NOTE]
> Unlike straight Selene version, this one requires close to zero coding but
> only declarations.

Update `30_Consumption/Consumption.topic` and `40_Production/Production.topic` to 
suite your installation.

```
cd HomeDashboard/MajordomeLCD
Majordome -vf HDB.conf
```
