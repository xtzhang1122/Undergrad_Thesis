# Undergrad_Thesis

## Title
Using Artificial Intelligence to Risk Stratify ECGs at Triage for Patients Presenting to Emergency Departments with Chest Pain


#### Supervisors: Ervin Sejdic and Rohit Mohindra


### Abstract
This thesis develops a Machine Learning-based tool for Electrocardiogram (ECG) analysis, designed to enhance the diagnosis of Occlusion Myocardial Infarction (OMI) in emergency departments. Amidst the high-stakes and fast-paced environment of emergency care, the swift and accurate identification of OMI can be lifesaving. The proposed tool leverages a Random Forest classifier, optimized to interpret ECG features for OMI detection. The thesis focuses on examining relevant literature and outlines the feature engineering process in detail, ensuring data integrity and selecting pertinent features.

The proposed design utilizes BREAVEHEART for feature computation and Python for risk analysis. The design is deliberately engineered to bridge different computational platforms, creating a streamlined process. A comprehensive dataset, provided by PhysioNet, is utilized to test the ability of the classifier.

The findings indicate that Machine Learning can aid clinical decision-making by providing rapid risk stratification for patients with suspected OMI. However, given the complexity of ECGs and the frequent data skew, traditional diagnostic approaches might lead to misdiagnosis. This thesis lays the groundwork for future enhancements, including refining the user interface for clinical application and expanding the dataset to include a wider array of ECG presentations. These enhancements ensure the tool’s adaptability and effectiveness across various clinical scenarios. The ultimate aim of this thesis is to support an AI-assisted approach in emergency settings, potentially reducing the morbidity and mortality associated with OMI.

### Overview of this Repository
This repository contains only the code for the thesis, excluding any datasets. The ```BREAVEHEART-main``` repository is a fork of the original [BREAVEHEART](https://github.com/BIVectors/BRAVEHEART), with additional files included to compute specific features not addressed by the original code. The ```ReadMe``` file in BREAVEHEART-main is identical to the one in the original [BREAVEHEART](https://github.com/BIVectors/BRAVEHEART) repository. The ```Feature Computation``` directory houses procedures for calculating all relevant features for OMI detection, including data computation, plot generation, and saving results. After this process, a file is generated for each patient. These files are then consolidated into a single file using ```feature_compliation.py```, which is subsequently utilized by the Random Forest model stored in ```main.py```.
