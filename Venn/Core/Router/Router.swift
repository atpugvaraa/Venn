import Observation
import SwiftUI

enum Route: Hashable {
    case taskDetail(UUID)
}

enum SheetRoute: Identifiable, Hashable {
    case addTask

    var id: String {
        switch self {
        case .addTask: return "addTask"
        }
    }
}

@Observable
final class Router {
    var path = NavigationPath()
    var sheet: SheetRoute?

    var pathBinding: Binding<NavigationPath> {
        Binding(
            get: { self.path },
            set: { self.path = $0 }
        )
    }

    var sheetBinding: Binding<SheetRoute?> {
        Binding(
            get: { self.sheet },
            set: { self.sheet = $0 }
        )
    }

    func navigate(to route: Route) {
        path.append(route)
    }

    func present(_ sheet: SheetRoute) {
        self.sheet = sheet
    }

    func dismissSheet() {
        sheet = nil
    }

    func popToRoot() {
        path = NavigationPath()
    }

    func pop() {
        guard !path.isEmpty else {
            return
        }

        path.removeLast()
    }
}

private struct RouterEnvironmentKey: EnvironmentKey {
    static let defaultValue = Router()
}

extension EnvironmentValues {
    var router: Router {
        get { self[RouterEnvironmentKey.self] }
        set { self[RouterEnvironmentKey.self] = newValue }
    }
}

struct RouterViewModifier: ViewModifier {
    @Environment(\.router) private var router

    @ViewBuilder
    private func destinationView(for route: Route) -> some View {
        switch route {
        case .taskDetail(let taskID):
            EmptyView()
//            TaskDetailView(taskID: taskID)
        }
    }

    func body(content: Content) -> some View {
        content
            .navigationDestination(for: Route.self) { route in
                destinationView(for: route)
            }
    }
}

extension View {
    func usingRouter() -> some View {
        modifier(RouterViewModifier())
    }
}
