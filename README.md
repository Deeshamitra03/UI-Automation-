# Practo UI Automation Project 

This project is a robust automated test suite designed to verify the end-to-end doctor appointment booking flow on **Practo.com**. It utilizes **Robot Framework** with the **Browser Library** (powered by Playwright) to handle dynamic web elements, Server-Side Rendering (SSR) reloads, and authentications.

## Key Features

* **Smart "Reload" Detection:** Instead of using static sleeps, the robot waits for the **"Reset Filters"** button to appear. This is the only 100% accurate way to confirm that Practo has finished reloading the doctor list after applying a filter.
* **Robust Locators:** Utilizes `data-qa-id` attributes (e.g., `data-qa-id="Available Tomorrow_label"`) to ensure tests don't break if text or CSS classes change.
* **Animation Handling:** Includes smart pauses to handle animated dropdown menus (like the "All Filters" menu) to prevent "ghost clicks."
* **Resilient Slot Booking:** Implements a retry loop to handle flaky time slot buttons that might not respond to the first click.
* **End-to-End Verification:** Validates the flow from **Home -> Filter -> Page Reload -> Slot Selection -> Booking Confirmation**.

##  Tech Stack

* **Framework:** [Robot Framework](https://robotframework.org/)
* **Library:** [Browser Library](https://robotframework-browser.org/) (Playwright wrapper)
* **Language:** Python 3.8+
* **Browser Engine:** Chromium

##  Project Structure

```text
practo-login-automation/
├── config/
│   └── config.robot            # Global settings (Base URL, Timeout, Credentials)
├── resources/
│   ├── keywords/
│   │   └── booking_keywords.robot # Core logic (Filter logic, Reload detection, Retry loops)
│   └── locators/
│       ├── login_page.robot      # Locators for Login & OTP
│       ├── doctors_list_page.robot # Locators for Search, Filters & Reset Button
│       ├── doctor_profile_page.robot # Locators for Slots & Profile
│       └── booking_page.robot    # Locators for Patient Details Form
├── tests/
│   └── booking_flow.robot      # Main Test Suite
└── requirements.txt            # Python dependencies
```
## Prerequisites

Ensure you have the following installed:
1.  **Python** (v3.8 or higher)
2.  **Node.js** (Required for Playwright)

##  Installation

1.  **Clone the project:**
    ```bash
    git clone <repository-url>
    cd practo-login-automation
    ```

2.  **Install Python dependencies:**
    ```bash
    pip install robotframework robotframework-browser
    ```

3.  **Initialize the Browser engines:**
    ```bash
    rfbrowser init
    ```

## Configuration

Before running the test, open `config/config.robot` and update your login credentials.

**Note:** Ensure there are **4 spaces** between the variable name and the value.

```robot
*** Variables ***
${BASE_URL}      [https://www.practo.com/doctors](https://www.practo.com/doctors)
${BROWSER}       chromium
${HEADLESS}      false
# We use a 60s timeout to handle slow page reloads safely
${TIMEOUT}       60s

#  UPDATE THESE VALUES
${USER_MOBILE}      9999999999
${USER_PASSWORD}    YourSecurePassword123
```
## How to Run

Execute the test suite from the project root:

```bash
robot tests/booking_flow.robot
```
## Design Decisions & Fixes

### 1. The "Server-Side Reload" Problem
**Issue:** When selecting "Available Tomorrow," the page reloads to fetch new data. Standard automation scripts fail here because they try to click the doctor before the new list loads.
**Solution:** We implemented a **Visible Wait** for the `Reset Filters` button.
* *Why?* This button only appears *after* the filter is successfully applied and the page data is refreshed. It is the perfect "Success Signal."

### 2. The "Ghost Click" Fix
**Issue:** The robot was clicking "Available Tomorrow" while the "All Filters" menu was still sliding down. The click was registered on the container, not the button.
**Solution:** Added a `Sleep 1s` after opening the menu to allow the CSS animation to complete before attempting to click.

### 3. Data-QA-ID Implementation
**Issue:** XPaths using text (e.g., `contains(text(), 'Tomorrow')`) were flaky.
**Solution:** Switched to using `data-qa-id` attributes found in the DOM:
* Filter Option: `xpath=//span[@data-qa-id='Available Tomorrow_label']`
* Reset Button: `xpath=//button[@data-qa-id='Reset_Filters']`
