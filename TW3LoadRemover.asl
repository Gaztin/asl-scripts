// @notLoading: false when loading, true otherwise
// @menuState:  0 while in main menu

state("witcher3", "standard")
{
	bool notLoading : 0x02CCB638;
	byte menuState  : 0x02AA4525;
}

state("witcher3", "gog_goty")
{
	bool notLoading : 0x02BF3608;
	byte menuState  : 0x02BF7702;
}

state("witcher3", "old_patch")
{
	bool notLoading : 0x02A0BA98;
	byte menuState  : 0x02A8DB11;
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
		case "3.0.19.14337": { version = "standard";  } break;
		case "3.0.19.14336": { version = "gog_goty";  } break;
		case "3.0.4.58000":  { version = "old_patch"; } break;
	}
}

isLoading
{
	return !current.notLoading;
}
