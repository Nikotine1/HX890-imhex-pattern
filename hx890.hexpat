struct RadioStatus {
    padding[2];
    u8 MultiWatch_scan [[comment("0x00=off, 0x01=multi, 0x02=scan")]];
    u8 ActiveNavigationTarget [[comment("0x00=none, 0x03=waypoint, 0x04=route")]];
    padding[2];
    u8 SelectedChannelGroup;
    padding[1] [[comment("always 0e")]];
    padding[1] [[comment("always 02")]];
    padding[1] [[comment("always 02")]];
    u8 VolumeSetting [[comment("16 steps")]];
    u8 SquelchSetting [[comment("16 steps ")]];
    u8 DistressAlertStatusMaybe [[comment("always 00")]];
    padding[1] [[comment("always 00")]];
    u16 SelectedChannel;
    u16 ChannelBefore16S;
    padding[1] [[comment("always f0")]];
    padding[1] [[comment("values seen: 01, 04")]];
};

struct ChannelIndex {
    u8 ChannelInUse [[comment("0x00=in use, 0xff=not in use"),color("FF0000")]];
    u8 ChannelIndex [[comment("numeric 1-based index"),color("FFFF00")]];
};

struct RadioConfiguration {
    ChannelIndex PriorityChannels[3];
    ChannelIndex SubChannels[3];
    padding[3] [[comment("always ff")]];
    padding[1] [[comment("always 02")]];
    u8 Dimmer [[comment("0..5")]];
    u8 Contrast [[comment("0..30")]];
    u8 KeyBeep [[comment("0..5 volume")]];
    padding[1] [[comment("always 01")]];
    u8 MultiWatch [[comment("0=dual, 1=triple")]];
    padding[1] [[comment("always 01")]];
    u8 ScanType [[comment("0x00=memory, 0x01=priority")]];
    u8 ScanResumeTime [[comment("1..5 seconds")]];
    u8 WeatherAlert;
    padding[1] [[comment("always 00")]];
    u8 EmergencyLED;
    u8 WaterHazardLED;
    u8 Lamp;
    u8 AFPitchCONT [[comment("0x00=normal, 0x01=high-low-cut, 0x02=high-low-boost, 0x03=low-boost, 0x04=high-boost")]];
    u8 BatterySave [[comment("0x00=off, 0x01=50%, 0x02=70%, 0x03=80%, 0x04=90%")]];
    padding[1] [[comment("always ff")]];
    u8 VOX;
    u8 VOXLevel [[comment("0..4")]];
    u8 VOXDelayTime;
    u8 NoiseCancelRx;
    u8 NoiseCancelRxLevel [[comment("0..3")]];
    u8 NoiseCancelTx;
    padding[1] [[comment("always 00 ")]];
    padding[3] [[comment("always ff")]];
    u8 WPDisplayRange;
    padding[1] [[comment("always ff")]];
    u8 WPArrivalRange;
    u8 WPRoutingOperation;
};

bitfield GPSTimeFormat {
    GPSArea: 1 [[comment("0=UTC, 1=Local")]];
    GPSFormat: 1 [[comment("0=12h, 1=24h")]];
    GPSOffsetSign: 1 [[comment("0=negative, 1=positive")]];
    GPSOffsetHalfHours: 5 [[comment("Number of half hours")]];
};

bitfield GPSOutputSentences {
    padding: 2 [[comment("0x80..0x40")]];
    DSCDSE: 1;
    RMC: 1;
    GSV: 1;
    GSA: 1;
    GGA: 1;
    GLL: 1 [[comment("0x01")]];
};

struct GPSSettings {
    u8 GPSPower;
    u8 GPSPowerSave;
    u8 GPSLocationFormat;
    GPSTimeFormat GPSTimeFormat;
    u8 GPSSpeed;
    u8 GPSDistance;
    u8 GPSAltitude;
    u8 GPSPinning;
    u8 GPSDifferential;
    u8 GPSDirection;
    GPSOutputSentences GPSOutputSentences;
    u8 GPSLoggerInterval;
    padding[1] [[comment("always 00")]];
};

struct SoftkeySettings {
    u8 ActiveSoftkeyPage [[comment("00..04")]];
    u8 SoftkeyTimer;
    u8 Softkeys[3*4] [[comment("4 groups of 3 keys, 0=none")]];
};

struct ChannelGroupDefinition {
    u8 GroupEnabled [[color("FF0000")]];
    u8 DSCEnabled [[color("FFFF00")]];
    u8 ATISEnabled [[comment("01 in group 4 enables YCE15 ATIS Setup"),color("00FFFF")]];
    char GroupName[4] [[comment("padded with ff"),color("0000FF")]];
    padding[1] [[comment("always ff")]];
    char ModelString[8] [[comment("padded with ff"),color("FF00FF")]];
};

struct DSCSettings {
    char MMSIBCD[5] [[comment("BCD format, last digit always 0, ff if none")]];
    u8 MMSIProgrammed [[comment("	0=unset, 1=set, 2=?")]];
    char ATISBCD[5] [[comment("BCD format, ff if none")]];
    u8 ATISProgrammed [[comment("0=unset, 1=set")]];
    padding[4] [[comment("always 01 1f 6f 1f")]];
    padding[5] [[comment("always 2f 2f 2f 5c 78")]];
    u8 BeepSettings;
    padding[1] [[comment("always 04")]];
    u8 IndividualRing [[comment("0x00=5s, 0x01=10s, 0x02=15s, 0x03=20s, 0x04=120s")]];
    u8 NoACTTimer [[comment("0x00=1min, 0x01=3min, 0x02=5min, 0x03=10min, 0x04=15min")]];
    u8 CHSwitchTimer [[comment("0x00=off, 0x01=10s, 0x02=30s, 0x03=60s, 0x04=120s")]];
    u8 POSFixWait [[comment("0x00=15s, 0x01=30s, 0x02=60s, 0x03=90s, 0x04=120s")]];
    padding[5] [[comment("always ff 01 ff 00 00")]];
    padding[16] [[comment("always ff")]];
    padding[1] [[comment("always 00")]];
    u8 AutoPOSPolling;
    u8 AutoPOSTime;
    padding[1] [[comment("always 02")]];
    padding[1] [[comment("always 00")]];
    padding[1] [[comment("HX870: 46, HX870E: 8c")]];
    padding[1] [[comment("HX870: 30, HX870E: ff")]];
    padding[1] [[comment("always ff")]];
    padding[1] [[comment("always 00")]];
    padding[1] [[comment("always 02")]];
    u8 GMInterval [[comment("0x00=1min, 0x01=3min, 0x02=5min, 0x03=10min, 0x04=15min")]];
    padding[1] [[comment("always ff")]];
    padding[1] [[comment("always 00")]];
    padding[1] [[comment("HX870: 46, HX870E: 8c")]];
    padding[1] [[comment("HX870: 30, HX870E: ff")]];
    padding[9] [[comment("always ff")]];
};

struct ChannelEnabledGroup {
    u64 ChannelEnabled[4];
};

struct ScanMemoryGroup {
    u64 ScanMemoryEnabled[4];
};

bitfield MarineChannel {
    ChannelID: 8 [[color("FF0000")]];
    FreqShiftRxOnly: 1;
    FreqShiftRxTx: 1;
    HighPowerAllowed: 1;
    TxAllowed: 1;
    LowPowerDefault: 1;
    padding: 1;
    ChannelSuffixB: 1;
    ChannelSuffixA: 1;
    DSCShipShip: 1;
    ChannelPrefix: 7;
    ScramblerEnabled: 1;
    ScramblerType: 1 [[comment("type of scrambler (0 = CVS2500, 1 = FVP-42)")]];
    padding: 1 [[comment("always 0 (1 is illegal value)")]];
    ScramblerCode: 5 [[comment("scrambler code (0-3 for CVS2500, 0-31 for FVP-42)")]];
};

bitfield PrivateChannelGroup {
    ChannelGroup: 4 [[comment("bitmask: 0x1000 = US, 0x0100=Intl, 0x0010 = NL (or other region)"),color("FF0000")]];
    TXorRXonly: 4 [[comment("0xC for TX or 0x0 for RX-only"),color("FF0000")]];
    Scrambler: 8;
    ChannelID: 16;
    RxFreqBCD: 20;
    padding: 4;
    TxFreqBCD: 20;
    LowPower: 1;
    padding: 2;
    HighPowerAllowed: 1;
    padding: 48;
};

struct Name16bit {
    char Name16bit[16];
};

bitfield WaypointDefinition {
    MMSI_Position: 40 [[color("FF0000")]];
    latitude_degrees: 8 [[color("FFFF00")]];
    latitude_minutes: 24 [[color("00FF00")]];
    latitude_hemisphere: 8 [[color("00FFFF")]];
    padding: 4;
    longitude_degrees: 12 [[color("00FF00")]];
    longitude_minutes: 24 [[color("FF00FF")]];
    longitude_hemisphere: 8 [[color("F0F0F0")]];
    waypoint_name: 112 [[color("FFFFFF")]];
    padding: 8;
    waypoint_id: 8 [[color("0F0F0F")]];
};

struct Route {
    u128 RouteName [[color("FF0000")]];
    u8 WaypointID[32];
};

bitfield DSCaddressMMSI {
    DSCaddressMMSI: 36;
    padding: 4; // always 0
    
};

struct ThreeDSCaddresses {
    DSCaddressMMSI DSCaddress[3];
    padding[1];
};

struct GMstruct {
    char GMID[5] [[color("FF0000")]];
    char GMname[11];
    ThreeDSCaddresses GMmember[3];
};


struct RadioStruct {
    u8 ActivePresetFlag;
    char RadioFrequency[3];
    char RadioName[7];
    padding[5];
};

u16 MagicPrefix @ 0x0000;
u16 MagicSuffix @ 0xFFFE;

RadioStatus radio_status @ 0x0002;
RadioConfiguration radio_configuration @ 0x0020;

GPSSettings gps_settings @ 0x0050;
SoftkeySettings softkey_settings @ 0x0060;

ChannelGroupDefinition channel_group_definition[4] @ 0x0070 [[comment("Fourth group not used")]];

DSCSettings dsc_settings @ 0x00b0;

char FlashID[8] @ 0x0100;

u8 Group3RegionCode @ 0x010f [[comment("group 3 region; 0=CAN, 1=UK 2=BE, 3=NL, 4=Sweden, 5=Germany")]];

ChannelEnabledGroup channel_enabled_group[3] @ 0x0120;
u16 ChannelEnabledWxGroup @ 0x0180;
u24 ChannelEnabledRgGroup @ 0X0182;
u32 ChannelEnabledExpGroup[3] @ 0x0185;

ScanMemoryGroup scan_memory_group[3] @ 0x0190;
u16 ScanMemWxGroup @ 0x01f0;
u16 ScanMemRgGroup @ 0x01f2;
u8 ScanMemExpGroup[3] @ 0x01f4;

ChannelIndex channel_preset_list_group1[10] @ 0x0200;
ChannelIndex channel_preset_list_group2[10] @ 0x0220;
ChannelIndex channel_preset_list_group3[10] @ 0x0240;

MarineChannel marine_channel_group1[96] @ 0x0700;
MarineChannel marine_channel_group2[96] @ 0x0900;
MarineChannel marine_channel_group3[96] @ 0x0B00;
PrivateChannelGroup regional_channel_group[20] @ 0x0D00;
PrivateChannelGroup expansion_channel_group[30] @ 0x0F00;

Name16bit channel_names1[96] @ 0x1100;
Name16bit channel_names2[96] @ 0x1D00;
Name16bit channel_names3[96] @ 0x2900;
Name16bit channel_namesRG[20] @ 0x3800;
Name16bit channel_namesEXP[30] @ 0x3C00;

WaypointDefinition Waypoints[250] @ 0xD700;
Route Routes[20] @ 0xC700;

ThreeDSCaddresses DSCindividualMMSI[33] @ 0x4200;
Name16bit DSCindividualName[100] @ 0x4500;
ThreeDSCaddresses DSCgroupMSSI[7] @ 0x5000;
Name16bit DSCgroupName[20] @ 0x5100;
GMstruct GMdefinition[10] @ 0x5500;

RadioStruct RadioStation[20] @ 0x0500;