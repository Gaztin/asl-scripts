// @notLoading: false when loading, true otherwise

state("witcher3", "standard")
{
	bool notLoading : 0x02CCB638;
}

state("witcher3", "gog_goty")
{
	bool notLoading : 0x02BF3608;
}

state("witcher3", "old_patch")
{
	bool notLoading : 0x02A0BA98;
}

state("witcher3", "complete_edition_dx11")
{
	bool notLoading : 0x056F17C0;
}

state("witcher3", "complete_edition_dx12")
{
	bool notLoading : 0x054A5F14;
}

init
{
	// Determine version from the file version of the executable
	var proc        = modules.First();
	var fileVersion = String.Format("{0}.{1}.{2}.{3}",
		proc.FileVersionInfo.FileMajorPart,
		proc.FileVersionInfo.FileMinorPart,
		proc.FileVersionInfo.FileBuildPart,
		proc.FileVersionInfo.FilePrivatePart);

	switch (fileVersion)
	{
		case "3.0.19.14337": { version = "standard"; } break;
		case "3.0.19.14336": { version = "gog_goty"; } break;
		case "3.0.4.58000":  { version = "old_patch"; } break;

		case "4.0.1.37654":
		{
			var filePath      = proc.FileName;
			var directoryName = new DirectoryInfo(filePath).Parent.Name;
			if (directoryName == "x64_dx12")
				version = "complete_edition_dx12";
			else
				version = "complete_edition_dx11";
		}
		break;
	}
}

isLoading
{
	return !current.notLoading;
}
