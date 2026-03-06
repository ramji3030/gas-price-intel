import React, { useState } from 'react';
import './App.css';

function App() {
  const [activeTab, setActiveTab] = useState('dashboard');
  const [priceData, setPriceData] = useState([]);
  const [uploadedImage, setUploadedImage] = useState(null);

  const handleImageUpload = async (e) => {
    const file = e.target.files[0];
    if (!file) return;

    const formData = new FormData();
    formData.append('file', file);
    formData.append('station_id', 'STATION123');

    try {
      const response = await fetch('http://localhost:8000/api/v1/prices/upload', {
        method: 'POST',
        body: formData,
      });
      const data = await response.json();
      alert(`Price detected: $${data.detected_price}`);
      loadPrices();
    } catch (error) {
      console.error('Error uploading image:', error);
    }
  };

  const loadPrices = async () => {
    try {
      const response = await fetch('http://localhost:8000/api/v1/prices/STATION123');
      const data = await response.json();
      setPriceData(data);
    } catch (error) {
      console.error('Error loading prices:', error);
    }
  };

  React.useEffect(() => {
    loadPrices();
  }, []);

  return (
    <div className="App">
      <header className="app-header">
        <h1>⛽ Gas Price Intelligence Platform</h1>
        <nav>
          <button onClick={() => setActiveTab('dashboard')} className={activeTab === 'dashboard' ? 'active' : ''}>
            Dashboard
          </button>
          <button onClick={() => setActiveTab('upload')} className={activeTab === 'upload' ? 'active' : ''}>
            Upload Price
          </button>
          <button onClick={() => setActiveTab('analytics')} className={activeTab === 'analytics' ? 'active' : ''}>
            Analytics
          </button>
        </nav>
      </header>

      <main className="app-main">
        {activeTab === 'dashboard' && (
          <div className="dashboard">
            <h2>Your Station Dashboard</h2>
            <div className="stats-grid">
              <div className="stat-card">
                <h3>Current Price</h3>
                <p className="price">${priceData[0]?.price || 'N/A'}</p>
              </div>
              <div className="stat-card">
                <h3>Competitor Avg</h3>
                <p className="price">$3.89</p>
              </div>
              <div className="stat-card">
                <h3>Price Updates</h3>
                <p className="count">{priceData.length}</p>
              </div>
              <div className="stat-card">
                <h3>Market Position</h3>
                <p className="position">2nd</p>
              </div>
            </div>

            <div className="price-history">
              <h3>Recent Price Updates</h3>
              <table>
                <thead>
                  <tr>
                    <th>Time</th>
                    <th>Price</th>
                    <th>Source</th>
                    <th>Status</th>
                  </tr>
                </thead>
                <tbody>
                  {priceData.slice(0, 10).map((item, idx) => (
                    <tr key={idx}>
                      <td>{new Date(item.timestamp).toLocaleString()}</td>
                      <td>${item.price}</td>
                      <td>{item.source}</td>
                      <td><span className="badge">Active</span></td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        )}

        {activeTab === 'upload' && (
          <div className="upload-section">
            <h2>Upload Gas Price Photo</h2>
            <div className="upload-card">
              <input 
                type="file" 
                accept="image/*" 
                onChange={handleImageUpload}
                id="file-upload"
                style={{ display: 'none' }}
              />
              <label htmlFor="file-upload" className="upload-button">
                📸 Choose Image
              </label>
              <p>Upload a photo of your gas station price board</p>
              <p className="hint">Our AI will automatically detect and extract prices</p>
            </div>
          </div>
        )}

        {activeTab === 'analytics' && (
          <div className="analytics">
            <h2>Price Analytics</h2>
            <div className="chart-placeholder">
              <p>📊 Price trends and competitive analysis coming soon</p>
              <ul>
                <li>7-day price trends</li>
                <li>Competitor comparison</li>
                <li>Market positioning</li>
                <li>Revenue optimization suggestions</li>
              </ul>
            </div>
          </div>
        )}
      </main>
    </div>
  );
}

export default App;
