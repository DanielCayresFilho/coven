-- Migration: Add lastAppointmentAt column to clients table
-- Execute this SQL directly in your database if migrations are not working

ALTER TABLE `clients`
  ADD COLUMN `lastAppointmentAt` DATETIME(3) NULL AFTER `observations`;

