import Cocoa

let eventMask = (1 << CGEventType.otherMouseDown.rawValue) | (1 << CGEventType.otherMouseUp.rawValue)

print("Hello, user, I will try to block your mouse's side buttons")

guard let eventTap = CGEvent.tapCreate(
    tap: .cgSessionEventTap,
    place: .headInsertEventTap,
    options: .defaultTap,
    eventsOfInterest: CGEventMask(eventMask),
    callback: { (proxy, type, event, refcon) -> Unmanaged<CGEvent>? in
        let buttonNumber = event.getIntegerValueField(.mouseEventButtonNumber)
        if buttonNumber == 3 || buttonNumber == 4 {
            print("Dropping the event")
            return nil // Drop the event
        }
        return Unmanaged.passUnretained(event)
    },
    userInfo: nil
) else {
    print("Failed to create event tap. Ensure Terminal/binary has Accessibility permissions.")
    exit(1)
}

let runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0)
CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, .commonModes)
CGEvent.tapEnable(tap: eventTap, enable: true)
CFRunLoopRun()
