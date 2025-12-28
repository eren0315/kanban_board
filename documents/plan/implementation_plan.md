# 구현 계획서: iOS 스타일 칸반 보드 (Flutter Web)

## 목표
iOS 네이티브 앱의 유려한 디자인과 사용자 경험을 웹으로 구현한 칸반 보드 애플리케이션을 개발합니다.
데이터베이스는 **Supabase (PostgreSQL 기반)**를 사용합니다.

## 사용자 리뷰 (완료)
> [!IMPORTANT]
> **데이터베이스 선정**: **Supabase** 사용 승인 완료. (2025-12-28)

## 주요 변경 사항

### 1. 프로젝트 구조 (Hexagonal Architecture)
*   **lib/**
    *   **core/**: 공통 유틸리티, 설정, 상수
    *   **domain/**: 핵심 비즈니스 로직 (Entities, Repository Interfaces) - *외부 의존성 없음*
    *   **application/**: 유스케이스 (Use Cases), 서비스 로직
    *   **infrastructure/**: 외부 시스템 연동 (Supabase Repository Impl, Data Sources)
    *   **presentation/**: UI 및 상태 관리 (Riverpod)
        *   **components/**: iOS 스타일 공통 위젯
        *   **board/**: 칸반 보드 화면 및 뷰모델

### 2. 패키지 추가 (`pubspec.yaml`)
#### [MODIFY] pubspec.yaml
*   `cupertino_icons`: iOS 아이콘
*   `flutter_riverpod`: 상태 관리
*   `supabase_flutter`: Supabase 연동
*   `go_router`: 네비게이션
*   `flutter_dotenv`: 환경변수 관리 (API Key 보안)
*   `google_fonts`: 폰트 (Inter/Roboto)
*   `animations`: 부드러운 전환 효과

### 3. 디자인 시스템 (iOS Style)
*   **CupertinoApp** 기반
*   **Blur & Translucency**: `BackdropFilter`를 활용한 글래스모피즘
*   **Micro-interactions**: 드래그 앤 드롭 애니메이션

## 검증 계획 (Verification Plan)

### 자동화 테스트
*   `flutter test`: 비즈니스 로직 테스트

### 수동 검증
1.  **초기 화면**: 앱 실행 및 대시보드 진입
2.  **데이터 연동**: Supabase 데이터 Read/Write 확인
3.  **UX**: iOS 스타일 애니메이션 및 트랜지션 확인
