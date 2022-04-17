## 노이즈캠

사진을 찍으면 노이즈 필터를 적용해 오래된 사진의 느낌을 주는 카메라 어플리케이션

## Screenshots

<div display="flex">
	<img src="https://github.com/MojitoBar/NoiseCamera/blob/main/screenshot5.png" alt="drawing" width="250"/>
	<img src="https://github.com/MojitoBar/NoiseCamera/blob/main/screenshot4.png" alt="drawing" width="250"/>
	<img src="https://github.com/MojitoBar/NoiseCamera/blob/main/screenshot3.png" alt="drawing" width="250"/>
	<img src="https://github.com/MojitoBar/NoiseCamera/blob/main/screenshot2.png" alt="drawing" width="250"/>
	<img src="https://github.com/MojitoBar/NoiseCamera/blob/main/screenshot1.png" alt="drawing" width="250"/>
</div>


## Period

2021.07. ~ 2021.08

## Content

- 카메라 메인 뷰와 인 앱 갤러리 뷰로 구성도어 있으며, StoryBoard로 UI 구현.
- Photos의 photoLibraryDidChange()를 이용해 앨범의 변화를 감지하고 PHAsset을 이용해 앨범에서 가장 최근 사진을 불러옴.
- PHAssetChangeRequest의 deleteAssets()을 이용해 앱에서 삭제한 사진이 앨범에 적용 되도록 함.
- CIFilter의 CIMultiplyBlendMode를 적용해 노이즈 이미지를 카메라로 찍은 사진에 적용.

## Member

주동석

## Stack

Swift
