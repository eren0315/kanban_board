# 화면 비율 및 레이아웃 전략 (Layout Strategy)

## 1. 핵심 원칙 (Core Principles)
*   **iOS Native Feel**: 웹이지만 iOS 앱을 사용하는 듯한 경험을 제공합니다.
*   **Content First**: 칸반 보드의 특성상 "가로 공간" 활용을 최우선으로 합니다.
*   **Adaptive**: 기기 크기에 따라 최적의 뷰를 제공하되, 핵심 UX(제스처, 인터랙션)는 유지합니다.

## 2. 반응형 구분 (Breakpoints)

## 2. 반응형 구분 (Breakpoints & Strategy)

### 📱 Mobile (Width < 600px)
*   **View**: `PageView` (페이징 방식)
*   **Column**: 화면에 **단 1개의 컬럼**만 표시.
*   **Interaction**: 좌우 스와이프로 컬럼 이동 (Snap 효과).
*   **Reason**: 작은 화면에서 정보 밀도를 높이고 집중도를 유지하기 위함.

### 📱 Foldable / Tablet (600px <= Width < 1200px)
*   **View**: `ListView` (가로 스크롤)
*   **Column**: 화면 너비에 따라 **2개 ~ 3개의 컬럼** 유동적 표시.
*   **Calculation**: `screenWidth / 350px` (최소 300~350px 너비 보장).

### 💻 Desktop (Width >= 1200px)
*   **View**: `ListView` (가로 스크롤)
*   **Column**: **4개 이상**의 컬럼을 한눈에 표시.
*   **Features**: 트랙패드/휠 스크롤 지원, 스크롤바 표시.

## 3. 확장성 (Scalability)
*   **Column Limit**: 최대 15~30개 컬럼까지 생성 가능하도록 설계.
*   **Navigation**: 컬럼이 많아질 경우를 대비해, 특정 컬럼으로 빠르게 점프할 수 있는 기능(인덱스 바 또는 미니맵) 고려.

## 3. 구현 세부 사항 (Implementation Details)

### 3.1 SafeArea & Orientation
*   모바일에서는 `SafeArea`를 준수하여 노치(Notch) 영역을 침범하지 않습니다.
*   가로 모드(Landscape) 지원:
    *   Mobile Landscape: Desktop 모드와 유사하게 동작하되, 높이가 낮으므로 헤더 축소.

### 3.2 Max Constraints (Desktop)
*   **Max Width**: `1920px`로 제한.
*   **Alignment**: 화면 중앙 정렬 (`Center`).
*   **Reason**: Ultra-wide 모니터에서 UI 요소가 너무 퍼져 보이는 것을 방지하고, 한눈에 파악 가능한 정보량을 조절하기 위함. 1920px 내부에서 가로 스크롤로 컬럼 탐색.

## 4. 코드 적용 가이드
*   `LayoutBuilder`를 사용하여 `constraints.maxWidth`를 기준으로 모바일/데스크탑 모드를 분기합니다.
*   `Responsivelayout` 위젯을 공통 컴포넌트로 만들어 사용합니다.

```dart
class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget desktopBody;
  
  // ...
}
```
