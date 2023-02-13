import { Video, VideoService } from './video.service';
export declare class VideoController {
    private readonly videoService;
    constructor(videoService: VideoService);
    getAllVideos(): Promise<Video[]>;
    getVideoById(id: string): Promise<Video>;
}
