-- Create Specialties Table
CREATE TABLE Specialties (
    specialty_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Create Doctors Table
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    specialty_id INT,
    email VARCHAR(150) NOT NULL UNIQUE,
    FOREIGN KEY (specialty_id) REFERENCES Specialties(specialty_id)
);

-- Create Patients Table
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE
);

-- Create Appointments Table
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_id INT NOT NULL,
    patient_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    reason TEXT,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    UNIQUE(doctor_id, appointment_date)  -- Prevent double booking
);

-- Create Prescriptions Table
CREATE TABLE Prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    medication VARCHAR(200) NOT NULL,
    dosage VARCHAR(100) NOT NULL,
    instructions TEXT,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);
-- Insert Specialties
INSERT INTO Specialties (name) VALUES ('Cardiology'), ('Dermatology'), ('Pediatrics');

-- Insert Doctors
INSERT INTO Doctors (first_name, last_name, specialty_id, email) 
VALUES ('John', 'Doe', 1, 'john.doe@clinic.com'),
       ('Sarah', 'Smith', 2, 'sarah.smith@clinic.com');

-- Insert Patients
INSERT INTO Patients (first_name, last_name, date_of_birth, email) 
VALUES ('Alice', 'Johnson', '1990-05-12', 'alice.johnson@example.com'),
       ('Bob', 'Williams', '1985-11-23', 'bob.williams@example.com');

-- Insert Appointments
INSERT INTO Appointments (doctor_id, patient_id, appointment_date, reason)
VALUES (1, 1, '2025-05-15 09:00:00', 'Routine check-up'),
       (2, 2, '2025-05-15 10:00:00', 'Skin rash consultation');

-- Insert Prescriptions
INSERT INTO Prescriptions (appointment_id, medication, dosage, instructions)
VALUES (1, 'Ibuprofen', '200mg', 'Take one tablet every 8 hours'),
       (2, 'Hydrocortisone Cream', 'Apply twice daily', 'Apply to affected area');
SELECT * FROM Patients;
SELECT d.doctor_id, d.first_name, d.last_name, s.name AS specialty
FROM Doctors d
JOIN Specialties s ON d.specialty_id = s.specialty_id;
SELECT a.appointment_id, 
       a.appointment_date, 
       d.first_name AS doctor_name, 
       p.first_name AS patient_name, 
       a.reason
FROM Appointments a
JOIN Doctors d ON a.doctor_id = d.doctor_id
JOIN Patients p ON a.patient_id = p.patient_id;
SELECT pr.prescription_id, 
       pr.medication, 
       pr.dosage, 
       pr.instructions, 
       a.appointment_date, 
       p.first_name AS patient_name
FROM Prescriptions pr
JOIN Appointments a ON pr.appointment_id = a.appointment_id
JOIN Patients p ON a.patient_id = p.patient_id;


