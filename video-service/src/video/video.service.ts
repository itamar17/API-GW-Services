import { Injectable } from '@nestjs/common';
import { ApiProperty } from "@nestjs/swagger";

export class Video {
  @ApiProperty()
  readonly id: number;
  @ApiProperty()
  readonly name: string;
  @ApiProperty()
  readonly rank: number;

  constructor(id: number, name: string, rank : number) {
    this.id = id;
    this.name = name;
    this.rank = rank;
  }
}

@Injectable()
export class VideoService {
  private videos: Video[] = [
    new Video(1, 'gladiator', 9.2),
    new Video(2, 'fast & furious', 3.4),
  ];

  getVideos(): Video[] {
    return this.videos;
  }

  getVideoById(id: number): Video {
    return this.videos.filter(video => video.id === id)[0];
  }
}
