# 📜 FormKit – Lightweight SwiftUI Form Validation Framework

FormKit is a lightweight and flexible SwiftUI form framework designed for declarative, real-time, and user-friendly form validation. It supports per-field validation, error display, touched state tracking, and reactive form validity with a focus on SwiftUI best practices.

---

## 🚀 Features

- ✅ Field-level validation (required, min length, custom rules)
- ✅ Live validation on user interaction
- ✅ Reactive `form.isValid` for controlling submit buttons
- ✅ Clean separation of concerns using `FormModel` and `FormField`
- ✅ Touched-based error visibility (errors show only after interaction)
- ✅ Full SwiftUI compatibility (iOS 15+)
- ✅ Demo app with Login and Registration flows

---

## 🧠 How It Works

### 1. Define a Form

```swift
@StateObject private var form = FormModel {
    ("email", FormField(value: "", validators: [
        .required(message: "Email is required"),
        .custom { $0.contains("@") ? nil : "Invalid email" }
    ]))
}
```

### 2. Bind and Validate

```swift
TextField("Email", text: form.binding(for: "email"))
    .onChange(of: form.binding(for: "email").wrappedValue) {
        form.validate(field: "email")
    }

if let error = form.error(for: "email"), form.touched(for: "email") {
    Text(error).foregroundColor(.red)
}
```

### 3. Check Overall Validity

```swift
Button("Submit") {
    form.markAllTouched()
}
.disabled(!form.isValid)
```

---

## 📱 Demo App

The demo includes:

- ✉️ Login form: email + password validation
- 📝 Registration form: name, age, optional bio
- 🗭 Navigation between login and registration
- 🎨 Custom border styling without UIKit `TextFieldStyle`

Start with:

```swift
HomeView()
```

To navigate between both forms.

---

## 🧹 Validator Types

```swift
.required(message: String)
.minLength(Int, message: String)
.custom((Value) -> String?)  // nil means valid
```

More validators like `.emailFormat`, `.matchesField`, `.numericOnly`, etc. can be added easily.

---

## 🧪 Future Plans

- [ ] Async validation support
- [ ] Reusable `ValidatedTextField` SwiftUI view
- [ ] Form reset / initial values
- [ ] Validation groups and conditional rules
- [ ] Swift Package release

---

## 📂 Folder Structure

```
FormKit/
├─ Sources/
│  ├─ FormModel.swift
│  ├─ FormField.swift
│  ├─ Validator.swift
│  ├─ Protocols.swift
│  └─ FormBuilder.swift
├─ Demo/
│  ├─ HomeView.swift
│  ├─ LoginView.swift
│  ├─ RegistrationView.swift
│  └─ SharedUI.swift (validatedField)
```

---

## 📦 Requirements

- iOS 15+
- Swift 5.7+
- Xcode 14+

---

## 👥 Contributing

Found a bug or want to help extend validation? Open a PR or create an issue. Feedback is welcome!

---

## 📄 License

MIT License. Use it, fork it, ship it 🚀

