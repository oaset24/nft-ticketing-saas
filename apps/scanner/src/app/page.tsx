import React from "react";
import { QrCode, Scan, Wifi, WifiOff } from 'lucide-react'

export default function ScannerPage() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-green-50 to-blue-100">
      <div className="container mx-auto px-4 py-8">
        <div className="text-center mb-8">
          <h1 className="text-4xl font-bold text-gray-900 mb-4">
            NFT Ticket Scanner
          </h1>
          <p className="text-lg text-gray-600 mb-6">
            Scannen Sie QR-Codes für den Einlass zu Veranstaltungen
          </p>
        </div>

        <div className="max-w-md mx-auto space-y-6">
          <div className="bg-white rounded-lg shadow-lg p-6">
            <div className="flex items-center gap-2 mb-4">
              <QrCode className="h-6 w-6 text-blue-600" />
              <h2 className="text-xl font-semibold">QR-Code Scanner</h2>
            </div>
            <p className="text-gray-600 mb-4">
              Scannen Sie Tickets für den Einlass
            </p>
            <button className="w-full bg-blue-600 hover:bg-blue-700 text-white font-medium py-3 px-4 rounded-lg flex items-center justify-center gap-2">
              <Scan className="h-5 w-5" />
              Scanner starten
            </button>
          </div>

          <div className="bg-white rounded-lg shadow-lg p-6">
            <div className="flex items-center gap-2 mb-4">
              <Wifi className="h-6 w-6 text-green-600" />
              <h2 className="text-xl font-semibold">Status</h2>
            </div>
            <div className="space-y-3">
              <div className="flex items-center justify-between">
                <span>Verbindung</span>
                <div className="flex items-center gap-2 text-green-600">
                  <Wifi className="h-4 w-4" />
                  <span className="text-sm">Online</span>
                </div>
              </div>
              <div className="flex items-center justify-between">
                <span>Offline-Modus</span>
                <div className="flex items-center gap-2 text-gray-500">
                  <WifiOff className="h-4 w-4" />
                  <span className="text-sm">Bereit</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
