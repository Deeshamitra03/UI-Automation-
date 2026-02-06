# Practo UI Automation Project 

This project is an automated test suite designed to verify the end-to-end doctor appointment booking flow on **Practo.com**. It utilizes **Robot Framework** with the **Browser Library** (powered by Playwright) to handle dynamic web elements, authentication, and robust UI interactions.

##  Key Features

* **Secure Authentication:** Automates user login using credentials (Mobile + Password) and detects OTP blocks gracefully.
* **Smart "JS Wait" Strategy:** Uses direct JavaScript execution (`Wait For Function`) to detect UI updates (like "Reset Filters") instantly, bypassing flaky XPath locators.
* **Resilient Slot Booking:** Implements a "3-Strike Retry Loop" to handle flaky time slot buttons that don't immediately respond to clicks.
* **Multi-Tab Handling:** Automatically detects and switches context when doctor profiles open in new tabs.
* **End-to-End Verification:** Validates the flow from Login -> Search -> Filter -> Slot Selection -> Booking Confirmation.

##  Tech Stack

* **Framework:** [Robot Framework](https://robotframework.org/)
* **Library:** [Browser Library](https://robotframework-browser.org/) (Playwright wrapper)
* **Language:** Python 3.8+
* **Browser Engine:** Chromium

## Project Structure

```text
practo-login-automation/
├── config/
│   └── config.robot            # Global configuration (Base URL, Timeout, Credentials)
├── resources/
│   ├── keywords/
│   │   └── booking_keywords.robot # Core logic (Login, Filter with JS, Retry Loop)
│   └── locators/
│       ├── login_page.robot      # Locators for Login & OTP screens
│       ├── doctors_list_page.robot # Locators for Search & Filter (Wildcard XPaths)
│       ├── doctor_profile_page.robot # Locators for Slots & New Tab
│       └── booking_page.robot    # Locators for Patient Details Form
├── tests/
│   └── booking_flow.robot      # Main Test Suite
└── requirements.txt            # Python dependencies
```

## Prerequisites

Ensure you have the following installed:
1.  **Python** (v3.8 or higher)
2.  **Node.js** (Required for Playwright)

## Installation

1.  **Clone the project:**
    ```bash
    git clone <repository-url>
    cd practo-login-automation
    ```

2.  **Install Python dependencies:**
    ```bash
    pip install -r requirements.txt
    ```

3.  **Initialize the Browser engines:**
    ```bash
    rfbrowser init
    ```

##  Configuration

Before running the test, open `config/config.robot` and update your login credentials.

**Note:** Ensure there are **4 spaces** between the variable name and the value.

```robot
*** Variables ***
${BASE_URL}      [https://www.practo.com/doctors](https://www.practo.com/doctors)
${BROWSER}       chromium
${HEADLESS}      false
${TIMEOUT}       30s
```
## How to Run

Execute the test suite from the project root:

```bash
robot tests/booking_flow.robot
```


# ⚠️ UPDATE THESE VALUES
${USER_MOBILE}      9999999999
${USER_PASSWORD}    YourSecurePassword123
