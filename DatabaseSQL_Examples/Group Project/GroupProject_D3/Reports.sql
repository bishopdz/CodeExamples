--Reports
--David Beverley, Adam Collier, Zach Hall, and Daniel Bishop
SET SERVEROUTPUT ON;

--Client Report
Begin
Reports.ClientReport('', '', 'Proin Sed Corp.'); 
END;

--Weekly Schedule
Begin
Reports.WeeklySchedule('01-MAY-19','08-JUL-19'); 
END;

--Photographer Schedule
Begin
Reports.PhotographerSchedule('01-MAY-19','01-JUL-19'); 
END;

--Photographer Availability Transaction
Begin
Reports.PhotographerAvailability('Lisa', 'Donaldson', '01-MAY-19'); 
END;

--Accounts Receivable
Begin
Reports.AccountRecievable('20-OCT-19'); 
END;

--Popular Location
Begin
Reports.PopularLocations; 
END;