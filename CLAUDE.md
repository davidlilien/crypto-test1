# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Python-based data analysis project focused on cryptocurrency and stock market analysis using Jupyter notebooks. The project performs advanced financial analysis including:

- High-frequency Bitcoin data analysis (1-minute resolution over 5 days)
- Historical stock analysis (Apple, NVIDIA, Tesla, Ford from IPO to present)  
- Fourier transform analysis for cycle detection
- Wavelet analysis for time-frequency decomposition
- Interactive visualization using Plotly

## Environment Setup

The project uses Python 3.13.5 with a virtual environment located at `./venv/`.

### Activating the Environment
```bash
source venv/bin/activate
```

### Installing Dependencies
```bash
pip install -r requirements.txt
```

## Key Dependencies

- **pandas**: Data manipulation and analysis
- **yfinance**: Yahoo Finance API for stock data
- **requests**: HTTP requests for cryptocurrency API calls
- **plotly**: Interactive plotting and visualization
- **jupyter/notebook**: Notebook environment
- **scipy**: Scientific computing (FFT, wavelets)
- **PyWavelets**: Wavelet analysis (used in crypto analysis)
- **numpy**: Numerical computing

## Project Structure

- **cryptos.ipynb**: Main cryptocurrency analysis notebook with Bitcoin data from Binance API
  - 1-minute resolution data over 30 days
  - Fourier transform frequency analysis  
  - Wavelet analysis for time-frequency decomposition
  - Advanced cycle detection algorithms

- **stocks.ipynb**: Stock market analysis notebook with historical data via yfinance
  - Multi-decade analysis of major stocks (AAPL, NVDA, TSLA, F)
  - Performance tracking from IPO to present
  - Volume and price trend analysis

- **requirements.txt**: Python package dependencies
- **venv/**: Python virtual environment

## Running the Analysis

### Cryptocurrency Analysis
1. Activate the virtual environment: `source venv/bin/activate`
2. Start Jupyter: `jupyter notebook`
3. Open `cryptos.ipynb` and run cells sequentially
4. The notebook fetches real-time Bitcoin data from Binance API

### Stock Analysis  
1. Activate the virtual environment: `source venv/bin/activate`
2. Start Jupyter: `jupyter notebook`
3. Open `stocks.ipynb` and run cells sequentially
4. The notebook fetches historical stock data via yfinance

## Data Sources

- **Cryptocurrency**: Binance API for 1-minute BTCUSDT kline data
- **Stocks**: Yahoo Finance via yfinance library for historical OHLCV data

## Analysis Features

### Cryptocurrency (Bitcoin)
- **High-resolution analysis**: 1-minute granularity over 5 days (7,200 data points)
- **Frequency domain analysis**: FFT to detect dominant trading cycles
- **Wavelet analysis**: Time-frequency decomposition using Morlet wavelets
- **Cycle detection**: Identifies patterns from minutes to intraday cycles

### Stock Market
- **Historical analysis**: Complete trading history from IPO to present
- **Performance metrics**: Total returns, volatility, volume analysis
- **Decade-by-decade breakdown**: Performance tracking across time periods
- **Multi-asset comparison**: Apple, NVIDIA, Tesla, Ford comparative analysis

## Technical Notes

- All visualizations use Plotly for interactive charts
- Data is automatically fetched and doesn't require manual downloads
- The cryptocurrency analysis handles API rate limits with proper delays
- Stock data includes splits and dividend adjustments via yfinance