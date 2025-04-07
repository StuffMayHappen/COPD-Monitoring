-- Patients Table
CREATE TABLE patient (  
    id int PRIMARY KEY AUTO_INCREMENT,
    first_name varchar(16) NOT NULL,
    last_name varchar(16) NOT NULL,
    gender enum('male', 'female', 'other'),
    contact_info varchar(255),
    address varchar(255),
    email varchar(64) NOT NULL,
    password varchar(512),
    phone_number varchar(20),
    birthdate date NOT NULL
);

-- Doctors Table
CREATE TABLE doctor (  
    id int PRIMARY KEY AUTO_INCREMENT,
    first_name varchar(16) NOT NULL,
    last_name varchar(16) NOT NULL,
    gender enum('male', 'female', 'other'),
    contact_info varchar(255),
    address varchar(255),
    email varchar(64) NOT NULL,
    password varchar(512),
    phone_number varchar(20),
    birthdate date NOT NULL,
    specialty enum('obstetrics and gynaecology', 'family medicine', 'cardiologist', 'psychiatry', 'pediatrics', 'geriatrics', 'critical care medicine', 'radiologist', 
                   'dermatology', 'neurology', 'gastroenterology', 'allergist', 'endocrinologist', 'hematology', 'infectius disease physician', 'diagnostic radiology',
                   'emergency medicine', 'anesthesiology', 'internal medicine', 'oncologist', 'general surgery', 'colorectal surgery', 
                   'medical genetics', 'facial plastic surgery')
);

-- Diagnosis Table
CREATE TABLE diagnosis (  
    id int PRIMARY KEY AUTO_INCREMENT,
    patient_id int,
    diagnosis_date date,
    diagnosis varchar(1000),
    treatment varchar(1000),
    FOREIGN KEY (patient_id) REFERENCES patient(id)
);

-- Medications Table 
CREATE TABLE medication (  
    id int PRIMARY KEY AUTO_INCREMENT,
    patient_id int,
    name varchar(36),
    dosage varchar(255),
    start_date date,
    end_date date,
    validation_date date,
    frequency varchar(255),
    prescribed_by varchar(36),
    FOREIGN KEY (patient_id) REFERENCES patient(id)
);

-- Hospitalization History Table
CREATE TABLE hospitalization_history (  
    id int PRIMARY KEY AUTO_INCREMENT,
    patient_id int,
    admission_date date,
    discharge_date date,
    reason_for_admission varchar(255),
    FOREIGN KEY (patient_id) REFERENCES patient(id)
);

-- Surgical History Table
CREATE TABLE surgical_history (  
    id int PRIMARY KEY AUTO_INCREMENT,
    patient_id int,
    surgery_type enum ('major', 'minor'),
    surgery_date date,
    procedure_text varchar(255),
    FOREIGN KEY (patient_id) REFERENCES patient(id)
);

-- Current Treaments Table
CREATE TABLE current_treatments (  
    id int PRIMARY KEY AUTO_INCREMENT,
    patient_id int,
    treatment_type enum('pulmonary rehabilitation', 'antibiotics', 'surgery', 'coticosteroids', 'theophylline', 'lung volume reduction', 'vaccines', 
                        'approach considerations', 'oxygen therapy', 'inhaler', 'pharmaceutical drug', 'non-invasive ventilation', 'beta2-adrenergic agonists', 
                        'long-acting', 'bronchial rheoplasty', 'bronchodilators', 'smoking cessation', 'steroid inhalers', 'phosphodiesterase-4 inhibitor', 
                        'organ transplantation', 'steroid tablets', 'muccoregulators', 'combination drugs','copd medications', 'physical therapy', 'more in copd', 
                        'other'),
    treatment_name varchar(255),
    start_date date,
    end_date date,
    frequency varchar(255),
    prescribed__by varchar(36),
    FOREIGN KEY (patient_id) REFERENCES patient(id)
);

-- Allergies Table 
CREATE TABLE allergies (  
    id int PRIMARY KEY AUTO_INCREMENT,
    patient_id int,
    allergy_type enum('food', 'drug', 'environmental', 'other'),
    allergy_name varchar(255),
    reaction varchar(255),
    FOREIGN KEY (patient_id) REFERENCES patient(id)
);

-- Medical History Table
CREATE TABLE medical_history (  
    id int PRIMARY KEY AUTO_INCREMENT,
    patient_id int,
    diagnosis_id int,
    medication_id int,
    hospitalization_history_id int,
    surgical_history_id int,
    current_treatments_id int,
    allergies_id int,
    FOREIGN KEY (patient_id) REFERENCES patient(id),
    FOREIGN KEY (diagnosis_id) REFERENCES diagnosis(id),
    FOREIGN KEY (medication_id) REFERENCES medication(id),
    FOREIGN KEY (hospitalization_history_id) REFERENCES hospitalization_history(id),
    FOREIGN KEY (surgical_history_id) REFERENCES surgical_history(id),
    FOREIGN KEY (current_treatments_id) REFERENCES current_treatments(id),
    FOREIGN KEY (allergies_id) REFERENCES allergies(id)
);

-- Risk Factors Table
CREATE TABLE risk_factors (  
    id int PRIMARY KEY AUTO_INCREMENT,
    patient_id int,
    smoking_status varchar(50),
    exposure_to_pollutants varchar(50),
    age int,
    BMI float,
    family_history_of_COPD enum('yes', 'no'),
    FOREIGN KEY (patient_id) REFERENCES patient(id)
);

-- Predictions Table
CREATE TABLE predictions (  
    id int PRIMARY KEY AUTO_INCREMENT,
    patient_id int,
    model_output float,
    created_at timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    predicted_class enum('Low', 'Medium', 'High'), -- If we plan on doing more advanced data analysis or machine learning predictions it's like a risk_level field 
    model_version varchar(50),
    confidence_score float,  -- added field for model confidence
    prediction_method varchar(50),  -- to track prediction method (e.g., algorithm used)
    FOREIGN KEY (patient_id) REFERENCES patient(id)
);

-- Test Results Table
CREATE TABLE testresults (  
    id int PRIMARY KEY AUTO_INCREMENT,
    patient_id int,
    test_type enum('pulmonary function testing', 'blood test', 'aat deficiency test', 'copd test overview', 'pulse oximetry', 'standardized symptoms score', 
                    'ct scan', 'spirometry', 'electrocardiography', 'echocardiogram', 'exercise testing', 'takeway', 'arterial blood gas test', 'chest x-ray',
                    'sputum culture', 'peak flow test', 'other tests'),
    created_at timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    result varchar(255),
    FOREIGN KEY (patient_id) REFERENCES patient(id)
);

-- Sensor Data Table
CREATE TABLE sensordata (  
    id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    heart_rate FLOAT,
    oxygen_saturation FLOAT,
    respiratory_rate FLOAT,
    activity_level ENUM('resting', 'walking', 'exercise', 'sleeping'),  -- Added 'sleeping' for sleep tracking
    copd_risk INT DEFAULT 0,  -- 0 = Low, 1 = Medium, 2 = High
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    temperature FLOAT,  -- Added field for body temperature
    humidity FLOAT,  -- Added field for environmental humidity
    location VARCHAR(255),  -- Added field for GPS or location tracking
    steps INT DEFAULT 0,  -- Number of steps taken (from the band)
    calories_burned FLOAT DEFAULT 0,  -- Calories burned (from the band)
    battery_level INT,  -- Battery level of the band (in percentage)
    sleep_duration FLOAT,  -- Sleep duration (in hours)
    FOREIGN KEY (patient_id) REFERENCES patient(id)
);

-- Research Article Table
CREATE TABLE researcharticle (
    id INT AUTO_INCREMENT PRIMARY KEY,
    year INT NOT NULL,
    population TEXT NOT NULL,
    purpose_of_study TEXT NOT NULL,
    sensor_used TEXT NULL,
    main_results TEXT NOT NULL,
    methods TEXT NOT NULL,
    features TEXT NULL,
    benefits TEXT NOT NULL,
    limitations TEXT NOT NULL
);

-- if you want to drop the foreign key constraints, use this code
ALTER TABLE patient ADD COLUMN last_login TIMESTAMP DEFAULT NULL;
ALTER TABLE doctor ADD COLUMN last_login TIMESTAMP DEFAULT NULL;


-- if you want to drop the foreign key constraints, use the following code
ALTER TABLE patient MODIFY password VARCHAR(255);
ALTER TABLE doctor MODIFY password VARCHAR(255);

-- adding a doctor_id column  that references the doctor table
ALTER TABLE patient ADD COLUMN doctor_id INT, ADD CONSTRAINT fk_patient_doctor FOREIGN KEY (doctor_id) REFERENCES doctor(id) ON DELETE CASCADE;