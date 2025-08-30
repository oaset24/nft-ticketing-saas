# NFT Ticketing SaaS Platform

Eine SaaS-Plattform für Veranstalter, um Events anzulegen, Ticketkontingente zu erstellen und als nicht-custodiale, übertragbare Utility NFTs auf einer EVM L2 auszugeben.

## 🎯 Features

- **Self-Service SaaS** für Veranstalter (Event Wizard, Ticket Setup, Dashboard)
- **NFT Tickets** (ERC-1155) mit On-Chain Status und Off-Chain Metadaten
- **Payment Integration** mit Fiat (Stripe) und optional Krypto
- **QR Code Check-in** mit gasloser Meta-Tx oder Off-Chain Signatur
- **Real-time Analytics** und CSV Export
- **DSGVO-konform** ohne Private Key Verwahrung

## 🏗️ Architektur

### Monorepo Struktur
```
├── apps/
│   ├── web/          # Next.js 14 Web App (Organizer + Buyer)
│   └── scanner/      # PWA Scanner App für Staff
├── packages/
│   ├── contracts/    # Solidity Smart Contracts (Foundry)
│   └── ui/          # Shared UI Components
```

### Tech Stack
- **Frontend**: Next.js 14, TypeScript, Tailwind CSS, shadcn/ui
- **Blockchain**: Solidity, Foundry, wagmi, viem, RainbowKit
- **Backend**: Next.js API Routes, Supabase (Postgres)
- **Payments**: Stripe, optional Coinbase Commerce
- **Auth**: Supabase Auth + Wallet Connect

## 🚀 Quick Start

### Prerequisites
- Node.js 20+
- pnpm 8+
- Foundry (für Smart Contracts)

### Installation
```bash
# Clone repository
git clone <repo-url>
cd nft-ticketing-saas

# Install dependencies
pnpm install

# Setup environment variables
cp apps/web/.env.local.example apps/web/.env.local
# Fill in your API keys and configuration
```

### Development
```bash
# Start all apps in development mode
pnpm dev

# Or start individual apps
pnpm --filter web dev          # Web app on http://localhost:3000
pnpm --filter scanner dev      # Scanner app on http://localhost:3001

# Smart contracts
cd packages/contracts
forge build
forge test
```

## 📋 Environment Variables

### Web App (.env.local)
```bash
# Supabase
NEXT_PUBLIC_SUPABASE_URL=your-supabase-url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-supabase-anon-key

# Blockchain
NEXT_PUBLIC_CHAIN_ID=8453
NEXT_PUBLIC_ALCHEMY_ID=your-alchemy-id
NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID=your-walletconnect-project-id

# Payments
STRIPE_SECRET_KEY=sk_test_...
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=pk_test_...

# Other
JWT_SECRET=your-jwt-secret
IPFS_TOKEN=your-web3-storage-token
```

## 🔧 Smart Contracts

### TicketCollection1155.sol
- ERC-1155 Standard mit Supply Tracking
- Access Control (Organizer, Minter, Checker Rollen)
- Check-in Funktionalität
- Pausable für Notfälle
- Optional EIP-2981 Royalties

### CollectionFactory.sol
- Factory Pattern für Event Collections
- Ownership Management
- Collection Registry

### Deployment
```bash
cd packages/contracts

# Compile contracts
forge build

# Run tests
forge test

# Deploy (configure RPC_URL and PRIVATE_KEY)
forge script script/Deploy.s.sol --rpc-url $RPC_URL --private-key $PRIVATE_KEY --broadcast
```

## 🎫 User Flows

### 1. Organizer Flow
1. Registrierung und E-Mail Verifizierung
2. Event anlegen (Titel, Datum, Venue, Steuerprofil)
3. Ticket-Typen erstellen (Kontingent, Preise, Limits)
4. Verkauf starten
5. Dashboard: Live KPIs, Check-in Status, Exports

### 2. Buyer Flow
1. Event/Tickets auswählen
2. Payment via Stripe oder Krypto
3. NFT Ticket in Wallet oder E-Mail Wallet erhalten
4. "Meine Tickets" Übersicht

### 3. Staff Flow (Scanner)
1. QR Code scannen am Einlass
2. Besitz & Status prüfen
3. Check-in ausführen (Meta-Tx oder Off-Chain)
4. Visuelles Feedback (✅/❌)

## 🔒 Security & Compliance

### DSGVO Compliance
- Keine PII on-chain
- Datensparsamkeit
- Aufbewahrungsfristen
- Löschkonzept

### Non-Custodial
- Keine Private Key Speicherung
- Nur Signatur-Verifikation
- WalletConnect Integration
- Optional: Non-custodial MPC Wallets

### Security Features
- Rate Limiting
- OWASP ASVS Lite
- 2FA für Admins
- Audit Logs

## 📊 Database Schema

Haupttabellen:
- `users` - Benutzer & Auth
- `organizers` - Veranstalter Profile
- `events` - Event Daten
- `ticket_types` - Ticket Kategorien
- `orders` - Bestellungen
- `payments` - Payment Tracking
- `tickets` - NFT Mapping
- `checkins` - Check-in Logs

## 🧪 Testing

```bash
# Lint all packages
pnpm lint

# Type checking
pnpm type-check

# Build all packages
pnpm build

# Smart contract tests
cd packages/contracts && forge test

# E2E tests (Playwright)
pnpm test:e2e
```

## 🚀 Deployment

### Frontend (Vercel)
```bash
# Build web app
cd apps/web && npm run build

# Deploy to Vercel
vercel --prod
```

### Smart Contracts
```bash
cd packages/contracts

# Deploy to Base Sepolia (Testnet)
forge script script/Deploy.s.sol --rpc-url $BASE_SEPOLIA_RPC --private-key $PRIVATE_KEY --broadcast --verify

# Deploy to Base Mainnet
forge script script/Deploy.s.sol --rpc-url $BASE_RPC --private-key $PRIVATE_KEY --broadcast --verify
```

## 📈 Roadmap

### MVP (v1.0)
- [x] Monorepo Setup
- [x] Smart Contracts (ERC-1155)
- [ ] Web App (Organizer Dashboard)
- [ ] Payment Integration (Stripe)
- [ ] Scanner PWA
- [ ] Analytics & Export

### Future (v1.1+)
- [ ] Sekundärmarkt mit Anti-Scalping
- [ ] Loyalty/Perks System
- [ ] Multi-Tenant Branding
- [ ] RFID/NFC Integration

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

- 📧 Email: support@nft-ticketing.de
- 💬 Discord: [Join our community](https://discord.gg/nft-ticketing)
- 📖 Documentation: [docs.nft-ticketing.de](https://docs.nft-ticketing.de)
