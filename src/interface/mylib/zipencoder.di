// D import file generated from 'mylib\zipencoder.d'
module mylib.zipencoder;
import std.zip;
import std.stdio;
import mylib.encoder;
final class ZipEncoder : Encoder
{
    const override void[] encode(in void[] data)
{
return this.zipData(data);
}

    const override void[] decode(in void[] data)
{
return this.unzipData(data);
}

    private const void[] zipData(in void[] data, in string directory = "")
{
auto archive = new ZipArchive;
auto mem = new ArchiveMember;
mem.expandedData = cast(ubyte[])data.dup;
mem.name = directory;
mem.compressionMethod = 8;
archive.addMember(mem);
auto data2 = archive.build();
return data2;
}


    private const void[] unzipData(in void[] data, in string directory = "")
{
auto archive = new ZipArchive(cast(ubyte[])data);
auto data1 = archive.expand(archive.directory[directory]);
return data1;
}


}

