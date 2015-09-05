module mylib.zipencoder;
import std.zip;
import std.stdio;
import mylib.encoder;

///
final class ZipEncoder : Encoder{
    override const void[] encode(in void[] data){
        return this.zipData(data);
    }
    override const void[] decode(in void[] data){
        return this.unzipData(data);
    }
    private const void[] zipData(in void[] data, in string directory = ""){
        auto archive = new ZipArchive;
        auto mem = new ArchiveMember;
        mem.expandedData = cast(ubyte[])data.dup; 
        mem.name = directory;
        mem.compressionMethod = 8;
        archive.addMember(mem);
        auto data2 = archive.build(); // encode
        return data2;
    }
    private const void[] unzipData(in void[] data, in string directory = ""){
        auto archive = new ZipArchive(cast(ubyte[])data);
        auto data1 = archive.expand(archive.directory[directory]);
        return data1;
    }
}
