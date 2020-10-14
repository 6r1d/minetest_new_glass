### RGB glass test code

```lua
interrupt(1)
digiline_send(
    'rgb',
    {
        switch = math.random(0,1),
        color = math.random(0, 255)
    }
)
```
