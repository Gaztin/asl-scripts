state("witcher3", "standard")
{
	uint counter : 0x02904FE0;
}

state("witcher3", "gog_goty")
{
	uint counter : 0x0282CF90;
}

state("witcher3", "old_patch")
{
	uint counter : 0x026E0340;
}

init
{
	// Determine version from the file version of the executable
	var proc         = modules.First();
	var file_version = String.Format("{0}.{1}.{2}.{3}",
	                                 proc.FileVersionInfo.FileMajorPart,
	                                 proc.FileVersionInfo.FileMinorPart,
	                                 proc.FileVersionInfo.FileBuildPart,
	                                 proc.FileVersionInfo.FilePrivatePart);

	switch (file_version)
	{
		case "3.0.19.14337": { version = "standard";  } break;
		case "3.0.19.14336": { version = "gog_goty";  } break;
		case "3.0.4.58000":  { version = "old_patch"; } break;
	}

	refreshRate = 30;
}

isLoading
{
	return current.counter == old.counter;
}
