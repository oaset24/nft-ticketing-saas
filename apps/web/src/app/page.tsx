import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Ticket, Users, QrCode, BarChart3 } from 'lucide-react'

export default function HomePage() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100">
      <div className="container mx-auto px-4 py-16">
        <div className="text-center mb-16">
          <h1 className="text-5xl font-bold text-gray-900 mb-6">
            NFT Ticketing SaaS
          </h1>
          <p className="text-xl text-gray-600 mb-8 max-w-3xl mx-auto">
            Die moderne Lösung für Veranstalter: Events anlegen, NFT-Tickets ausgeben, 
            und nahtlose Check-ins mit Blockchain-Technologie.
          </p>
          <div className="flex gap-4 justify-center">
            <Button size="lg" className="px-8">
              Als Veranstalter starten
            </Button>
            <Button variant="outline" size="lg" className="px-8">
              Tickets kaufen
            </Button>
          </div>
        </div>

        <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-6 mb-16">
          <Card>
            <CardHeader>
              <Ticket className="h-8 w-8 text-blue-600 mb-2" />
              <CardTitle>NFT Tickets</CardTitle>
              <CardDescription>
                ERC-1155 Standard mit On-Chain Status und Off-Chain Metadaten
              </CardDescription>
            </CardHeader>
          </Card>

          <Card>
            <CardHeader>
              <Users className="h-8 w-8 text-green-600 mb-2" />
              <CardTitle>Self-Service</CardTitle>
              <CardDescription>
                Intuitive Veranstalter-Dashboard für Event-Management
              </CardDescription>
            </CardHeader>
          </Card>

          <Card>
            <CardHeader>
              <QrCode className="h-8 w-8 text-purple-600 mb-2" />
              <CardTitle>QR Check-in</CardTitle>
              <CardDescription>
                Schnelle Einlass-Kontrolle mit gasloser Meta-Transaktion
              </CardDescription>
            </CardHeader>
          </Card>

          <Card>
            <CardHeader>
              <BarChart3 className="h-8 w-8 text-orange-600 mb-2" />
              <CardTitle>Analytics</CardTitle>
              <CardDescription>
                Real-time KPIs, Verkaufsstatistiken und CSV-Export
              </CardDescription>
            </CardHeader>
          </Card>
        </div>

        <div className="bg-white rounded-lg shadow-lg p-8">
          <div className="grid md:grid-cols-2 gap-8 items-center">
            <div>
              <h2 className="text-3xl font-bold text-gray-900 mb-4">
                DSGVO-konform & Non-Custodial
              </h2>
              <p className="text-gray-600 mb-6">
                Keine Private Key Verwahrung, keine PII on-chain. 
                Vollständig compliant mit deutschen Datenschutzbestimmungen.
              </p>
              <ul className="space-y-2 text-gray-600">
                <li className="flex items-center">
                  <div className="w-2 h-2 bg-green-500 rounded-full mr-3"></div>
                  Stripe Integration für Fiat-Zahlungen
                </li>
                <li className="flex items-center">
                  <div className="w-2 h-2 bg-green-500 rounded-full mr-3"></div>
                  WalletConnect für Blockchain-Integration
                </li>
                <li className="flex items-center">
                  <div className="w-2 h-2 bg-green-500 rounded-full mr-3"></div>
                  Offline-fähige Scanner PWA
                </li>
              </ul>
            </div>
            <div className="bg-gray-50 rounded-lg p-6">
              <h3 className="text-xl font-semibold mb-4">Unterstützte Chains</h3>
              <div className="space-y-2">
                <div className="flex items-center justify-between">
                  <span>Base Mainnet</span>
                  <span className="text-green-600 font-medium">✓ Live</span>
                </div>
                <div className="flex items-center justify-between">
                  <span>Base Sepolia</span>
                  <span className="text-blue-600 font-medium">✓ Testnet</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
