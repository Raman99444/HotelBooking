document.addEventListener("turbolinks:load", function() {
  const bookingForm = document.querySelector('#booking-form');

  if (bookingForm) {
    const arrivalDateInput = document.querySelector('#booking_arrival_date');
    const departureDateInput = document.querySelector('#booking_departure_date');
    const guestNameInput = document.querySelector('#booking_guest_name');
    const guestEmailInput = document.querySelector('#booking_guest_email');
    const submitButton = bookingForm.querySelector('input[type="submit"]');
    const currencyInput = document.querySelector('#booking_currency');

    bookingForm.addEventListener('submit', function(event) {
      if (!validateForm()) {
        event.preventDefault();
      }
    });

    // Add event listeners to remove errors on input change for date fields
    arrivalDateInput.addEventListener('input', validateDateFields);
    departureDateInput.addEventListener('input', validateDateFields);
    guestNameInput.addEventListener('input', validateGuestFields);
    guestEmailInput.addEventListener('input', validateGuestFields);
    currencyInput.addEventListener('input', validateCurrencyField);

    function validateForm() {
      const arrivalDate = new Date(arrivalDateInput.value);
      const departureDate = new Date(departureDateInput.value);
      const today = new Date();
      today.setHours(0, 0, 0, 0);

      const currency = currencyInput.value.trim();
      const currencyPattern = /^[A-Za-z]{2,3}$/;

      let errorMessages = [];
      let hasErrors = false;

      // Clear previous errors
      clearErrors();

      // Validate date fields
      if (arrivalDate < today) {
        errorMessages.push("Arrival date cannot be in the past.");
        arrivalDateInput.classList.add('is-invalid');
        hasErrors = true;
      }

      if (departureDate < arrivalDate) {
        errorMessages.push("Departure date cannot be earlier than arrival date.");
        departureDateInput.classList.add('is-invalid');
        hasErrors = true;
      }

      // Validate guest name and email fields
      if (!guestNameInput.value.trim()) {
        errorMessages.push("Guest name cannot be blank.");
        guestNameInput.classList.add('is-invalid');
        hasErrors = true;
      }

      if (!guestEmailInput.value.trim()) {
        errorMessages.push("Guest email cannot be blank.");
        guestEmailInput.classList.add('is-invalid');
        hasErrors = true;
      }

      if (!currencyPattern.test(currency)) {
        errorMessages.push("Currency must be a valid 3-letter code.");
        currencyInput.classList.add('is-invalid');
        hasErrors = true;
      }

      if (hasErrors) {
        submitButton.disabled = true;
        errorMessages.forEach(msg => {
          const errorDiv = document.createElement('div');
          errorDiv.className = 'error-message text-danger';
          errorDiv.innerText = msg;
          if (msg.includes("Arrival date")) {
            arrivalDateInput.parentNode.appendChild(errorDiv);
          } else if (msg.includes("Departure date")) {
            departureDateInput.parentNode.appendChild(errorDiv);
          } else if (msg.includes("Guest name")) {
            guestNameInput.parentNode.appendChild(errorDiv);
          } else if (msg.includes("Guest email")) {
            guestEmailInput.parentNode.appendChild(errorDiv);
          } else if (msg.includes("Currency")) {
            currencyInput.parentNode.appendChild(errorDiv);
          }
        });
        return false;
      } else {
        submitButton.disabled = false;
        return true;
      }
    }

    function validateDateFields() {
      const arrivalDate = new Date(arrivalDateInput.value);
      const departureDate = new Date(departureDateInput.value);
      const today = new Date();
      today.setHours(0, 0, 0, 0);

      let hasErrors = false;

      // Clear previous errors
      clearErrors();

      // Validate date fields
      if (arrivalDate < today) {
        arrivalDateInput.classList.add('is-invalid');
        hasErrors = true;
        const errorDiv = document.createElement('div');
        errorDiv.className = 'error-message text-danger';
        errorDiv.innerText = "Arrival date cannot be in the past.";
        arrivalDateInput.parentNode.appendChild(errorDiv);
      }

      if (departureDate < arrivalDate) {
        departureDateInput.classList.add('is-invalid');
        hasErrors = true;
        const errorDiv = document.createElement('div');
        errorDiv.className = 'error-message text-danger';
        errorDiv.innerText = "Departure date cannot be earlier than arrival date.";
        departureDateInput.parentNode.appendChild(errorDiv);
      }

      submitButton.disabled = hasErrors;
    }

    function validateGuestFields() {
      const guestName = guestNameInput.value.trim();
      const guestEmail = guestEmailInput.value.trim();
    
      // Clear previous errors
      clearErrors();
    
      if (!guestName) {
        guestNameInput.classList.add('is-invalid');
        const errorDiv = document.createElement('div');
        errorDiv.className = 'error-message text-danger';
        errorDiv.innerText = "Guest name cannot be blank.";
        guestNameInput.parentNode.appendChild(errorDiv);
      }
    
      if (!guestEmail) {
        guestEmailInput.classList.add('is-invalid');
        const errorDiv = document.createElement('div');
        errorDiv.className = 'error-message text-danger';
        errorDiv.innerText = "Guest email cannot be blank.";
        guestEmailInput.parentNode.appendChild(errorDiv);
      }
    
      submitButton.disabled = !guestName || !guestEmail;
    }
    
    function validateCurrencyField() {
      const currency = currencyInput.value.trim();
      const currencyPattern = /^[A-Za-z]{2,3}$/;
      
      // Clear previous errors
      clearErrors();
    
      if (!currencyPattern.test(currency)) {
        currencyInput.classList.add('is-invalid');
        const errorDiv = document.createElement('div');
        errorDiv.className = 'error-message text-danger';
        errorDiv.innerText = "Currency must be a valid 3-letter code.";
        currencyInput.parentNode.appendChild(errorDiv);
        submitButton.disabled = true;
      } else {
        currencyInput.classList.remove('is-invalid');
        submitButton.disabled = false;
      }
    }    

    function clearErrors() {
      document.querySelectorAll('.error-message').forEach(e => e.remove());
      arrivalDateInput.classList.remove('is-invalid');
      departureDateInput.classList.remove('is-invalid');
      guestNameInput.classList.remove('is-invalid');
      guestEmailInput.classList.remove('is-invalid');
      currencyInput.classList.remove('is-invalid');
    }
  }
});
