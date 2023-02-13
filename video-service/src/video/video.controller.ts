import { Controller, Get, Param } from '@nestjs/common';
import {Video, VideoService} from './video.service';

@Controller('v1/video')
export class VideoController {
  constructor(private readonly videoService: VideoService) {}

  @Get()
  async getAllVideos(): Promise<Video[]> {
    return this.videoService.getVideos();
  }

  @Get(':id')
  async getVideoById(@Param('id') id: string): Promise<Video> {
    return this.videoService.getVideoById(Number(id));
  }
}
