---
date: 12-10-2026
subject: Sensor System
description: Protocol to exchange serial data between two devices.
---

# 1. USART

**Universal Synchronous and Asynchronous Receiver-Transmitter** — type of serial interface device that can be programmed to communicate asynchronously or synchronously.

- COM ports provide a convenient way for PCs and embedded systems to exchange information.
- The traditional COM port on a PC is an RS-232 serial port. Recent PCs often skip RS-232 in favor of USB. Nevertheless a USB device can appear as a virtual COM port that applications can access using COM-port APIs or libraries.
- Many existing devices with asynchronous serial ports can use a USB UART to communicate with PCs as a virtual COM.

# 2. UART

Protocol for exchanging serial data between two devices.

- Uses only 2 wires: TX → RX, in each direction, plus a common ground.
- Transmitter and receiver do not share a common clock: they must agree on the speed (Baud rate) and parameters of the transmission.

Data is transmitted as **frames**:

- All transmission start with a **start** bit and stop with a **stop** bit
- Data bits (5 to 9, usually 7 or 8, sent LSB first)
- Parity bit (optional) useful for error detection:
	- Even parity: `1` if number of `1` is even
	- Odd parity: `1` if number of `1` is odd

In particular for UART there is no synchronous clock.

## HAL functions

Basic functions:

```c
HAL_StatusTypeDef HAL_UART_Receive(UART_HandleTypeDef *huart, uint8_t *pData, uint16_t Size, uint32_t Timeout)
HAL_StatusTypeDef HAL_UART_Transmit(UART_HandleTypeDef *huart, uint8_t *pData, uint16_t Size, uint32_t Timeout)
```

Add `_IT` for the interrupt version.

Direct Memory Access functions:

```c
HAL_StatusTypeDef HAL_UART_Receive_DMA(UART_HandleTypeDef *huart, uint8_t *pData, uint16_t Size)
HAL_StatusTypeDef HAL_UART_Transmit_DMA(UART_HandleTypeDef *huart, uint8_t *pData, uint16_t Size)
```

Function to receive an amount of data in blocking mode till either the expected number of data is received or an IDLE event occurs.

```c
HAL_StatusTypeDef HAL_UARTEx_ReceiveToIdle(UART_HandleTypeDef *huart, uint8_t *pData, uint16_t Size, uint16_t *RxLen, uint32_t Timeout)
HAL_StatusTypeDef HAL_UARTEx_ReceiveToIdle_DMA(UART_HandleTypeDef *huart, uint8_t *pData, uint16_t Size)
```

## Project 3a — MCU to PC via Virtual COM

Objective: send information from the microcontroller to the PC, using the USART interface for the Virtual COM.

- Send a string containing your name and your year of birth followed by a new line every second.
- Use a terminal emulator (Arduino IDE, VSCode, PuTTY) to receive the string.

### USART configuration

- Open a new project (use default)
- Check that the two pins for USART are enabled
- Select a Baud Rate (e.g. 115200 Bits/s). The same BR should be set in the terminal emulator, since it is an asynchronous communication!

### Identify the COM port on your PC (Windows)

- Open "Device Manager" (Gestione dispositivi) by right-clicking on the start menu, and selecting "Device Manager"
- Scroll down until "Ports (COM and LPT)" and open the submenu. The COM port we need should be identified by the name "STMicroelectronics STLink Virtual COM Port (COM__ )"

### Generate string

To correctly create the data to be sent to the PC, use the `snprintf` function to generate a string.

```c
uint8_t count = 10;
int length = snprintf(string, sizeof(string), " %d\n", count);
HAL_UART_Transmit(&huart2, string, length, 100);
```

```c
float voltage = 0.125;
float voltage2 = 10.535;
int length = snprintf(string, sizeof(string), "%.3f,%.3f \n", voltage, voltage2);
HAL_UART_Transmit(&huart2, string, length, 100);
```

## Homework 4a — MCU to PC with DMA

Objective: send information from the microcontroller to the PC, using the USART interface for the Virtual COM and using DMA functions.

- Send a string containing your name and your year of birth followed by a new line every second.
- Use a terminal emulator (Arduino IDE, VSCode, PuTTY) to receive the string.

UART configuration:

- Enable DMA in the USART2 peripheral with USART2_TX requests, in normal mode
- Enable both the interrupt for UART2 and the one for DMA

## Homework 4b — PC to MCU variable length

Try sending from the PC via UART a string of variable length.

- When you send the string "LED ON", turn the green LED on.
- When you send the string "LED OFF", turn the green LED off.
- Hint: use the ReceiveToIdle function.


---
Related: [[_Sensor System MOC]]
Source: [[05 - USART  LCD 2026-2027.pdf]]