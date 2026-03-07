import React, { useState } from 'react';

function UploadForm({ onPriceSubmitted }) {
  const [formData, setFormData] = useState({
    stationName: '',
    address: '',
    city: '',
    state: '',
    zipCode: '',
    price: '',
    fuelType: 'regular'
  });
  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState('');

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setMessage('');

    try {
      const response = await fetch('http://localhost:8000/api/prices/', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          station_name: formData.stationName,
          address: formData.address,
          city: formData.city,
          state: formData.state,
          zip_code: formData.zipCode,
          price: parseFloat(formData.price),
          fuel_type: formData.fuelType,
          source: 'manual'
        }),
      });

      if (response.ok) {
        const data = await response.json();
        setMessage('✅ Price submitted successfully!');
        // Reset form
        setFormData({
          stationName: '',
          address: '',
          city: '',
          state: '',
          zipCode: '',
          price: '',
          fuelType: 'regular'
        });
        // Notify parent component
        if (onPriceSubmitted) onPriceSubmitted();
      } else {
        setMessage('❌ Error submitting price. Please try again.');
      }
    } catch (error) {
      console.error('Error:', error);
      setMessage('❌ Network error. Make sure backend is running.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="upload-form">
      <h2>📍 Submit Gas Price</h2>
      
      {message && (
        <div className={`message ${message.includes('✅') ? 'success' : 'error'}`}>
          {message}
        </div>
      )}

      <form onSubmit={handleSubmit}>
        <div className="form-grid">
          <div className="form-group">
            <label htmlFor="stationName">Station Name *</label>
            <input
              type="text"
              id="stationName"
              name="stationName"
              value={formData.stationName}
              onChange={handleChange}
              placeholder="e.g., RaceWay"
              required
            />
          </div>

          <div className="form-group">
            <label htmlFor="address">Address *</label>
            <input
              type="text"
              id="address"
              name="address"
              value={formData.address}
              onChange={handleChange}
              placeholder="e.g., 1230 US Highway"
              required
            />
          </div>

          <div className="form-group">
            <label htmlFor="city">City *</label>
            <input
              type="text"
              id="city"
              name="city"
              value={formData.city}
              onChange={handleChange}
              placeholder="e.g., Hickory"
              required
            />
          </div>

          <div className="form-group">
            <label htmlFor="state">State *</label>
            <input
              type="text"
              id="state"
              name="state"
              value={formData.state}
              onChange={handleChange}
              placeholder="e.g., NC"
              maxLength="2"
              required
            />
          </div>

          <div className="form-group">
            <label htmlFor="zipCode">ZIP Code *</label>
            <input
              type="text"
              id="zipCode"
              name="zipCode"
              value={formData.zipCode}
              onChange={handleChange}
              placeholder="e.g., 28601"
              maxLength="5"
              required
            />
          </div>

          <div className="form-group">
            <label htmlFor="price">Gas Price ($/gallon) *</label>
            <input
              type="number"
              id="price"
              name="price"
              value={formData.price}
              onChange={handleChange}
              placeholder="e.g., 3.40"
              step="0.01"
              min="0"
              max="10"
              required
            />
          </div>

          <div className="form-group">
            <label htmlFor="fuelType">Fuel Type *</label>
            <select
              id="fuelType"
              name="fuelType"
              value={formData.fuelType}
              onChange={handleChange}
              required
            >
              <option value="regular">Regular</option>
              <option value="premium">Premium</option>
              <option value="diesel">Diesel</option>
            </select>
          </div>
        </div>

        <button 
          type="submit" 
          className="submit-btn"
          disabled={loading}
        >
          {loading ? '⏳ Submitting...' : '✅ Submit Price'}
        </button>
      </form>

      <div className="example-data">
        <h3>💡 Example: RaceWay 1230 US</h3>
        <ul>
          <li><strong>Station Name:</strong> RaceWay</li>
          <li><strong>Address:</strong> 1230 US Highway</li>
          <li><strong>City:</strong> Hickory</li>
          <li><strong>State:</strong> NC</li>
          <li><strong>ZIP:</strong> 28601</li>
          <li><strong>Price:</strong> $3.40</li>
          <li><strong>Fuel Type:</strong> Regular</li>
        </ul>
      </div>
    </div>
  );
}

export default UploadForm;
