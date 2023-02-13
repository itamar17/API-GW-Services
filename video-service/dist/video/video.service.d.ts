export declare class Video {
    readonly id: number;
    readonly name: string;
    readonly rank: number;
    constructor(id: number, name: string, rank: number);
}
export declare class VideoService {
    private videos;
    getVideos(): Video[];
    getVideoById(id: number): Video;
}
