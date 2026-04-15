# Unmanaged-Health-Insurance-Claim-System
Unmanaged scenario on health insurance claim system
# Unmanaged Health Insurance Claim System

This project demonstrates an **Unmanaged RAP (RESTful ABAP Programming Model)** implementation in **SAP ABAP Cloud**, designed to manage health insurance claim items with full lifecycle handling and Fiori-based UI.

---

## 📌 Project Overview

The system enables users to:
- Create and manage insurance claim items
- Track claim status (Pending, Delivered)
- Filter and search claims using smart filters
- View structured claim data (treatment, doctor, amount, etc.)

Built using:
- **RAP Unmanaged Scenario**
- **CDS Views (Interface + Projection)**
- **Behavior Implementation**
- **OData V2 Service Binding**
- **SAP Fiori Elements UI**

---

## 🏗️ Architecture

### 1. CDS Data Model
- Created **Interface Views** for database tables (Claim Header & Claim Item)
- Defined **Projection Views** for UI exposure
- Established **associations (Header → Items)**

### 2. Behavior Definition (Unmanaged)
- Implemented unmanaged behavior to handle:
  - Create
  - Update
  - Delete
- Custom logic written in **Behavior Implementation Class**
- Managed **status transitions and validations**

### 3. Service Exposure
- Created **Service Definition**
- Bound using **Service Binding (OData V2 - UI)**
- Published endpoint for Fiori consumption

### 4. UI Layer
- Generated **SAP Fiori Elements List Report**
- Enabled:
  - Smart Filters
  - Table view
  - Inline actions (Create/Delete)

---

## 📊 Application Preview

### 🔹 Claim Items List View
<img width="1766" height="951" alt="Claim Items UI" src="https://github.com/user-attachments/assets/33902e1d-bf1b-4606-99e9-f7a822eec826" />

### 🔹 Service Binding & RAP Structure
<img width="1912" height="1040" alt="Service Binding" src="https://github.com/user-attachments/assets/d1a25c57-2c5b-4fb5-aa5f-188b9525ce80" />

---

## ⚙️ Key Features

- ✔️ Unmanaged RAP implementation (manual logic control)
- ✔️ Header–Item data modeling
- ✔️ Status handling (Pending, Delivered)
- ✔️ Currency & amount handling
- ✔️ Smart filtering in Fiori UI
- ✔️ Clean Core compliant design

---

## 🧠 Key Learnings

- Difference between **Managed vs Unmanaged RAP**
- Writing custom logic in **Behavior Implementation**
- Service exposure using **OData V2**
- Building UI with **Fiori Elements without custom frontend code**

---

## 🚀 How to Run

1. Activate all CDS views and behavior definitions
2. Publish Service Binding
3. Click **Preview** → Opens Fiori Elements App
4. Test CRUD operations and filtering

---

## 📎 Technologies Used

- SAP ABAP Cloud
- RAP (Unmanaged Scenario)
- CDS Views
- OData V2
- SAP Fiori Elements

---

## 👨‍💻 Author

**Hariharavasan V J**
