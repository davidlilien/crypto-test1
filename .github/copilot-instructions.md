# AI Agent Instructions for Financial Analysis Project

## Project Overview
This is a Python-based financial data analysis project with two main analysis notebooks:
- `cryptos.ipynb`: High-frequency cryptocurrency analysis using Binance Vision API
- `stocks.ipynb`: Historical stock market analysis using Yahoo Finance

## Architecture Patterns

### Configuration-Driven Design
Both notebooks use global configuration variables at the top of the first cell:
```python
# Cryptocurrency config
DUREE_JOURS = 365
INTERVAL = '1h'
SYMBOL = 'BTCUSDT'

# Stock config
SYMBOLE = "AAPL"
DUREE = "10d"
INTERVAL = "15m"
MA_PERIODE = 30
```

**Pattern**: Always modify configuration variables at the notebook top, never hardcode values in analysis cells.

### Data Pipeline Architecture
1. **Data Fetching**: External API calls with progress indicators
2. **Data Validation**: Timestamp normalization, NaN handling, date range validation
3. **Feature Engineering**: Moving averages, differences, technical indicators
4. **Analysis**: FFT/wavelet transforms, cycle detection
5. **Visualization**: Multi-subplot Plotly charts with synchronized axes

### API Integration Patterns

#### Binance Vision (Cryptocurrency)
- Parallel downloading with `ThreadPoolExecutor` (max 12 workers)
- Complex timestamp normalization (ms → μs conversion)
- Progress bars using `ipywidgets.FloatProgress`
- Error handling for network failures and ZIP corruption

#### Yahoo Finance (Stocks)
- Simple `yfinance.Ticker.history()` calls
- Automatic handling of splits/dividends
- Date range calculation from duration parameters

## Critical Developer Workflows

### Environment Setup
```bash
source venv/bin/activate
pip install -r requirements.txt
jupyter notebook
```

### Notebook Execution Order
1. Run configuration cell first (sets global variables)
2. Execute data download cell (may take several minutes)
3. Run analysis cells sequentially
4. Execute visualization cell last

### Data Dependencies
- Internet connection required for all analyses
- Binance API has rate limits (handled with delays)
- Yahoo Finance data includes automatic adjustments

## Project-Specific Conventions

### Variable Naming
- French names for data variables: `df_btc`, `diff_series`, `decalage`
- English for technical terms: `fft_vals`, `coefficients`, `scalogram`
- Configuration variables in ALL_CAPS

### Analysis Patterns

#### Moving Average Alignment
```python
# Phase-shifted MA for temporal alignment
decalage = MA_PERIOD // 2
df[f'ma_{MA_PERIOD}_shifted'] = df[f'ma_{MA_PERIOD}'].shift(-decalage)
```

#### FFT Analysis Workflow
1. Detrend data (remove mean)
2. Apply `np.fft.rfft()` for real-valued signals
3. Convert frequencies to periods: `periods = 1.0 / fft_freqs`
4. Filter top N dominant frequencies for reconstruction

#### Wavelet Analysis Setup
```python
# Morlet wavelets for time-frequency analysis
wavelet = 'morl'
scales = np.geomspace(1, 256, 80)  # Geometric spacing for frequency coverage
coefficients, frequencies = pywt.cwt(signal, scales, wavelet)
```

### Visualization Patterns

#### Multi-Subplot Layout
- 4-row subplots: Price/Volume, Differences, Wavelets, FFT Spectrum
- Secondary y-axes for volume overlays
- Synchronized x-axes with `matches='x3'`
- Logarithmic scales for frequency domains

#### Interactive Features
- `hovermode='x unified'` for coordinated hovering
- Color-coded traces: green (price), blue (MA), red (differences), purple (FFT)
- Renderer set to `'vscode'` for VS Code integration

### Error Handling Patterns
- Try/catch blocks around API calls and complex computations
- Graceful degradation (annotations instead of crashes)
- Progress tracking with success/failure counters
- Data validation before analysis (empty DataFrame checks)

## Key Files Reference
- `cryptos.ipynb`: Exemplifies complex API integration, parallel processing, advanced signal analysis
- `stocks.ipynb`: Shows simpler API usage, basic technical analysis, comparative visualization
- `requirements.txt`: Minimal dependency list focused on data science stack
- `CLAUDE.md`: Legacy AI instructions (superseded by this file)

## Performance Considerations
- Signal processing limited to 1024 samples for wavelet analysis
- FFT reconstruction uses top 200 frequencies by default
- Parallel downloads capped at 12 workers to avoid API throttling
- Progress bars prevent UI blocking during long operations

## Testing Approach
Run notebook cells sequentially and verify:
- Data downloads complete without errors
- Timestamps are properly normalized
- Visualizations render correctly in VS Code
- FFT/wavelet computations produce expected frequency ranges