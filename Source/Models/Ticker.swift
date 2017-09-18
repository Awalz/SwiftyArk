//
//  Ticker.swift
//  SwiftyArk
//
//  Created by Andrew on 2017-09-17.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

public struct ArkTickerResponse : Decodable {
   /* public let success: Bool
    public let ticker : [ArkTicker]
    
   public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        print(values.allKeys)
        
        success = try values.decode(Bool.self, forKey: .success)
        ticker  = try values.decode([ArkTicker].self,  forKey: .ticker)
    }
        
    enum CodingKeys: String, CodingKey {
        case success
        case ticker = "result"
    } */
}

public enum TickerCurrency : String {
    case aud = "AUD"
    case brl = "BRL"
    case cad = "CAD"
    case chf = "CHF"
    case clp = "CLP"
    case cny = "CNY"
    case czk = "CZK"
    case dkk = "DKK"
    case eur = "EUR"
    case gbp = "GBP"
    case hkd = "HKD"
    case huf = "HUF"
    case idr = "IDR"
    case ils = "ILS"
    case inr = "INR"
    case jpy = "JPY"
    case krw = "KRW"
    case mxn = "MXN"
    case myr = "MYR"
    case nok = "NOK"
    case nzd = "NZD"
    case php = "PHP"
    case pkr = "PKR"
    case pln = "PLN"
    case rub = "RUB"
    case sek = "SEK"
    case sgd = "SGD"
    case thb = "THB"
    case twd = "TWD"
    case usd = "USD"
    case zar = "ZAR"
}

public struct ArkTicker {
    public let currency         : TickerCurrency
    public let id               : String
    public let name             : String
    public let symbol           : String
    public let rank             : Int
    public let price            : Double
    public let bitcoinPrice     : Double
    public let volume24Hour     : Double
    public let marketCap        : Double
    public let availableSupply  : Double
    public let totalSupply      : Double
    public let percentChange1h  : Double
    public let percentChange24h : Double
    public let percentChange7d  : Double

    init?(currency: TickerCurrency, data: Data) {
        
        guard let jsonArray = try? JSONSerialization.jsonObject(with: data, options: []) as? NSArray else {
            return nil
        }
        
        guard let jarray = jsonArray else {
            return nil
        }
        
        guard let json = jarray[0] as? [String: AnyObject] else {
            return nil
        }
                
        self.currency = currency
        let currencyKeys = ArkTicker.getCurrencyKeys(currency)
        
        guard let id               = json["id"] as? String,
              let name             = json["name"] as? String,
              let symbol           = json["symbol"] as? String,
              let rank             = json["rank"] as? String,
              let btcPrice         = json["price_btc"] as? String,
              let availableSupply  = json["available_supply"] as? String,
              let totalSupply      = json["total_supply"] as? String,
              let percentChange1h  = json["percent_change_1h"] as? String,
              let percentChange24h = json["percent_change_24h"] as? String,
              let percentChange7d  = json["percent_change_7d"] as? String,
              let price            = json[currencyKeys.priceKey] as? String,
              let volume24Hour     = json[currencyKeys.volume24Hour] as? String,
              let marketCap        = json[currencyKeys.marketCap] as? String
        else  {
            return nil
        }
        self.id = id
        self.name = name
        self.symbol = symbol
        
        guard let rankInt               = Int(rank),
              let btcPriceFloat         = Double(btcPrice),
              let availableSupplyFloat  = Double(availableSupply),
              let totalSupplyFloat      = Double(totalSupply),
              let percentChange1hFloat  = Double(percentChange1h),
              let percentChange24hFloat = Double(percentChange24h),
              let percentChange7dFloat  = Double(percentChange7d),
              let priceFloat            = Double(price),
              let volume24HourFloat     = Double(volume24Hour),
              let marketCapFloat        = Double(marketCap) else {
            return nil
        }
        
        self.rank             = rankInt
        self.bitcoinPrice     = btcPriceFloat
        self.availableSupply  = availableSupplyFloat
        self.totalSupply      = totalSupplyFloat
        self.percentChange1h  = percentChange1hFloat
        self.percentChange24h = percentChange24hFloat
        self.percentChange7d  = percentChange7dFloat
        self.price            = priceFloat
        self.volume24Hour     = volume24HourFloat
        self.marketCap        = marketCapFloat 
    }
    
    static private func getCurrencyKeys(_ currency: TickerCurrency) -> (priceKey: String, volume24Hour: String, marketCap: String) {
        switch currency {
        case .aud:
            return ("price_aud", "24h_volume_aud", "market_cap_aud")
        case .brl:
            return ("price_brl", "24h_volume_brl", "market_cap_brl")
        case .cad:
            return ("price_cad", "24h_volume_cad", "market_cap_cad")
        case .chf:
            return ("price_chf", "24h_volume_chf", "market_cap_chf")
        case .clp:
            return ("price_clp", "24h_volume_clp", "market_cap_clp")
        case .cny:
            return ("price_cny", "24h_volume_cny", "market_cap_cny")
        case .czk:
            return ("price_czk", "24h_volume_czk", "market_cap_czk")
        case .dkk:
            return ("price_dkk", "24h_volume_dkk", "market_cap_dkk")
        case .eur:
            return ("price_eur", "24h_volume_eur", "market_cap_eur")
        case .gbp:
            return ("price_gbp", "24h_volume_gbp", "market_cap_gbp")
        case .hkd:
            return ("price_hkd", "24h_volume_hkd", "market_cap_hkd")
        case .huf:
            return ("price_huf", "24h_volume_huf", "market_cap_huf")
        case .idr:
            return ("price_idr", "24h_volume_idr", "market_cap_idr")
        case .ils:
            return ("price_ils", "24h_volume_ils", "market_cap_ils")
        case .inr:
            return ("price_inr", "24h_volume_inr", "market_cap_inr")
        case .jpy:
            return ("price_jpy", "24h_volume_jpy", "market_cap_jpy")
        case .krw:
            return ("price_krw", "24h_volume_krw", "market_cap_krw")
        case .mxn:
            return ("price_mxn", "24h_volume_mxn", "market_cap_mxn")
        case .myr:
            return ("price_myr", "24h_volume_myr", "market_cap_myr")
        case .nok:
            return ("price_nok", "24h_volume_nok", "market_cap_nok")
        case .nzd:
            return ("price_nzd", "24h_volume_nzd", "market_cap_nzd")
        case .php:
            return ("price_php", "24h_volume_php", "market_cap_php")
        case .pkr:
            return ("price_pkr", "24h_volume_pkr", "market_cap_pkr")
        case .pln:
            return ("price_pln", "24h_volume_pln", "market_cap_pln")
        case .rub:
            return ("price_rub", "24h_volume_rub", "market_cap_rub")
        case .sek:
            return ("price_sek", "24h_volume_sek", "market_cap_sek")
        case .sgd:
            return ("price_sgd", "24h_volume_sgd", "market_cap_sgd")
        case .thb:
            return ("price_thb", "24h_volume_thb", "market_cap_thb")
        case .twd:
            return ("price_twd", "24h_volume_twd", "market_cap_twd")
        case .usd:
            return ("price_usd", "24h_volume_usd", "market_cap_usd")
        case .zar:
            return ("price_zar", "24h_volume_zar", "market_cap_zar")
        }
    }
}





