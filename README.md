# 🚀 Gas Price Intelligence SaaS Platform

Real-time gas price intelligence platform with image-based OCR price detection, crowd-sourced reporting, and competitive analytics.

## Stack
- **Backend**: FastAPI + SQLModel + PostgreSQL
- **Frontend**: React + TypeScript + Tailwind CSS
- **Infrastructure**: Docker + AWS (ECS, RDS, S3, CloudFront)
- **AI/ML**: YOLOv8 + PaddleOCR for price detection
- **Payments**: Stripe
- **CI/CD**: GitHub Actions

## Features

### MVP (Phase 1)
- [x] User authentication & multi-tenancy
- [x] Station management (CRUD)
- [x] Image upload & S3 storage
- [x] OCR-based price detection
- [x] Price reporting API
- [x] Dashboard with price trends
- [x] Email alerts

### Phase 2 (Growth)
- [ ] Mobile app (React Native)
- [ ] Advanced analytics
- [ ] Competitor mapping
- [ ] Historical pricing data
- [ ] API for partners

### Phase 3 (Enterprise)
- [ ] Custom pricing models
- [ ] Integrations with POS systems
- [ ] Predictive analytics
- [ ] White-label options

## Quick Start

### Prerequisites
- Docker & Docker Compose
- PostgreSQL 13+
- Python 3.11+
- Node.js 18+
- AWS Account (for production)

### Local Development

```bash
# Clone repository
git clone https://github.com/ramji3030/gas-price-intel.git
cd gas-price-intel

# Copy environment files
cp backend/.env.example backend/.env
cp frontend/.env.example frontend/.env

# Start with Docker Compose
docker-compose up -d

# Access services
- Backend API: http://localhost:8000
- Frontend: http://localhost:3000
- API Docs: http://localhost:8000/api/docs
- Database: localhost:5432
```

### API Documentation
Visit `http://localhost:8000/api/docs` for interactive Swagger UI.

## Deployment

### AWS (Production)
```bash
# Deploy with Terraform
cd terraform
terraform init
terraform plan
terraform apply
```

### Docker (Self-hosted)
```bash
docker-compose -f docker-compose.prod.yml up -d
```

## Project Structure

```
gas-price-intel/
├── backend/               # FastAPI application
│   ├── app/
│   │   ├── api/          # API routes
│   │   ├── models/       # SQLModel database models
│   │   ├── schemas/      # Pydantic request/response schemas
│   │   ├── core/         # Config, security, dependencies
│   │   └── services/     # Business logic
│   ├── requirements.txt
│   ├── Dockerfile
│   └── .env.example
├── frontend/              # React TypeScript application
│   ├── src/
│   │   ├── components/   # Reusable components
│   │   ├── pages/        # Page components
│   │   ├── services/     # API client
│   │   └── hooks/        # Custom React hooks
│   ├── package.json
│   ├── Dockerfile
│   └── tailwind.config.js
├── docker-compose.yml    # Local dev stack
├── .github/
│   └── workflows/        # GitHub Actions CI/CD
├── terraform/            # AWS infrastructure as code
└── scripts/              # Deployment scripts
```

## API Endpoints

### Authentication
- `POST /api/v1/auth/signup` - Register new user
- `POST /api/v1/auth/login` - Login
- `POST /api/v1/auth/refresh` - Refresh token

### Stations
- `GET /api/v1/stations` - List stations
- `POST /api/v1/stations` - Create station
- `GET /api/v1/stations/{id}` - Get station details
- `PUT /api/v1/stations/{id}` - Update station
- `DELETE /api/v1/stations/{id}` - Delete station

### Prices
- `POST /api/v1/prices/report` - Report price
- `GET /api/v1/prices/station/{id}` - Get station prices
- `GET /api/v1/prices/competitors?lat=X&lng=Y&radius=5` - Get competitor prices

### Uploads
- `POST /api/v1/uploads/image` - Upload and process image
- `GET /api/v1/uploads/status/{id}` - Check processing status

## Pricing Model

| Plan | Price | Stations | Features |
|------|-------|----------|----------|
| **Starter** | $49/mo | 5 | Daily updates, Basic dashboard |
| **Growth** | $199/mo | 50 | Hourly updates, Alerts, API access |
| **Enterprise** | Custom | Unlimited | Real-time, Custom integrations |

## Contributing
1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

## License
MIT License - see LICENSE file

## Contact & Support
- 📧 Email: support@gaspriceintel.com
- 💬 Telegram: [Message us](https://t.me/gaspriceintel)
- 📱 LinkedIn: [Ramji Bharath](https://linkedin.com/in/ramji-bharath)

## Roadmap
- Q1 2026: MVP launch
- Q2 2026: Mobile app + analytics
- Q3 2026: 10,000+ stations coverage
- Q4 2026: Enterprise partnerships

---
**Built with ❤️ by Ramji Bharath**
