-- Add lastAppointmentAt column to clients table
ALTER TABLE `clients`
  ADD COLUMN `lastAppointmentAt` DATETIME(3) NULL AFTER `observations`;

