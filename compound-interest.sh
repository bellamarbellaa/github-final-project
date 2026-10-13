#!/bin/bash

# Compound Interest Calculator
# Formula: A = P(1 + r/n)^(nt)

echo "================================"
echo "   COMPOUND INTEREST CALCULATOR"
echo "================================"

read -p "Enter principal amount: " principal
read -p "Enter annual interest rate (%): " rate
read -p "Enter time period (years): " time
read -p "Enter compounding frequency per year: " frequency

# Validate inputs
if ! [[ "$principal" =~ ^[0-9]+([.][0-9]+)?$ &&
        "$rate" =~ ^[0-9]+([.][0-9]+)?$ &&
        "$time" =~ ^[0-9]+([.][0-9]+)?$ &&
        "$frequency" =~ ^[1-9][0-9]*$ ]]; then
    echo "Error: Please enter valid numbers. Frequency must be a positive integer."
    exit 1
fi

# Calculate compound interest
result=$(awk \
    -v p="$principal" \
    -v r="$rate" \
    -v t="$time" \
    -v n="$frequency" \
    'BEGIN {
        amount = p * (1 + (r / 100) / n) ^ (n * t)
        interest = amount - p
        printf "%.2f %.2f", interest, amount
    }')

read -r interest amount <<< "$result"

echo "================================"
echo "RESULTS"
echo "================================"
echo "Principal Amount  : $principal"
echo "Interest Rate     : $rate%"
echo "Time Period       : $time years"
echo "Compounding Times : $frequency per year"
echo "Compound Interest : $interest"
echo "Total Amount      : $amount"
