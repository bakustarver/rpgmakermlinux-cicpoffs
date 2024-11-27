=begin
This script contains various utility functions and classes for dealing
with audio. This is a stand-alone script.

Audio.square(durationInMs,freq,volume,timbre,async) - Generates a square wave.
Audio.beep(durationInMs,freq,volume,timbre,async) - Alias for Audio.square
Audio.sine(durationInMs,freq,volume,timbre,async) - Generates a sine wave.
Audio.triangle(durationInMs,freq,volume,timbre,async) - Generates a triangle wave.
Audio.saw(durationInMs,freq,volume,async) - Generates a saw wave.
Audio.noise(durationInMs,volume,async) - Generates white noise.
Audio.playTone(toneFile,async) - Plays a tone in the Apple iPod alarm tone format.
Parameters:
 durationInMs - duration of the sound in milliseconds.
   The module Audio::NoteLength contains useful durations for tones.
   If 0 or nil, the frequency is determined using the maximum duration
   of the given sound envelopes.
 freq - the frequency of the sound in Hz. The higher the frequency,
  the higher the pitch. If 0, no sound will be generated.
  The module Audio::Note contains useful frequencies for tones.
  freq can also be a SoundEnvelope or an array of two element arrays, 
  as follows:
   freq[0] - time in ms to apply the specified frequency
   freq[1] - frequency to apply. In between, values will be interpolated
 volume - volume of the sound, from 0 through 100
  volume can also be a SoundEnvelope.
 async - specifies whether the function will return immediately
  without waiting for the sound to finish (stands for asynchronous)
 timbre - specifies the timbre of the tone; from 0.0 through 1.0
  timbre can also be a SoundEnvelope or an array of two element arrays, 
  as follows:
   volume[0] - time in ms to apply the specified timbre
   volume[1] - timbre to apply. In between, values will be interpolated

WaveData - A class for holding audio data in memory. This class
is easy to serialize into the save file.
 intensity() - Calculates the intensity, or loudness of the data
  Returns a value from 0 through 127.
 time() - Length of the data in seconds.
 play() - Plays the wave data

getPlayTime(filename) - Gets the length of an audio file in seconds.
  Supports WAV, MP3, and OGG files.
getWaveData(filename) - Creates wave data from the given WAV file path.
  Returns a WaveData object or an integer: 1=not found; 2=invalid format;
  3=format not supported; 4=no sound in the data (the last error is helpful
  for diagnosing whether anything was recorded, since a recording device
  can record even if no microphone is attached.)

beginRecord() - Starts recording.  Returns 0 if successful.
getRecorderSample() - Gets a single sample from the microphone.
 The beginRecord function must have been called beforehand.
stopRecord() - Stops recording without saving the recording to a file.
endRecord(file) - Stops recording and saves the recording to a file.
=end

if !defined?(safeExists?)
  def safeExists?(f)
    ret=false
    File.open(f,"rb") { ret=true } rescue nil
    return ret
  end
end

def pbSaveSoundData(samples, freq, filename)
  samples="" if !samples
  data=[
     0x46464952,samples.length+0x2C,
     0x45564157,0x20746d66,0x10,
     0x01,0x01, # PCM,mono
     freq,freq,
     1,8, # 8-bit
     0x61746164,samples.length
  ].pack("VVVVVvvVVvvVV")
  f=File.open(filename,"wb")
  if f
    f.write(data)
    f.write(samples)
    f.close
  end
end

# plays 8 bit mono sound data (default: 11025 Hz)
def pbPlaySoundData(samples,volume,async=false,sampleFreq=11025)
  return if !samples || samples.length==0 || sampleFreq==0
  waveOutOpen=Win32API.new("winmm.dll","waveOutOpen","plplll","l")
  waveOutPrepareHeader=Win32API.new("winmm.dll","waveOutPrepareHeader","lpl","l")
  waveOutWrite=Win32API.new("winmm.dll","waveOutWrite","lpl","l")
  waveOutSetVolume=Win32API.new("winmm.dll","waveOutSetVolume","ll","l")
  waveOutClose=Win32API.new("winmm.dll","waveOutClose","l","l")
  waveOutGetNumDevs=Win32API.new("winmm.dll","waveOutGetNumDevs","","l")
  getStringAddress=proc {|obj|
     return 0 if !obj
     buffer=" "*4
     rtlMoveMemory_pi = Win32API.new('kernel32', 'RtlMoveMemory', 'pii', 'i')
     stringPointer=(obj.__id__*2)+12
     rtlMoveMemory_pi.call(buffer,stringPointer,4)
     return buffer.unpack("L")[0]
  }
  saveToTemp=proc {|samples,freq|
     chars="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
     for i in 1...1000
       name=""; 8.times { name+=chars[rand(chars.length),1] }
       name=ENV["TEMP"]+"\\"+name+"_tmp.wav"
       if !safeExists?(name)
         pbSaveSoundData(samples,freq,name)
         return name
       end
     end
     return nil
  }
  playThenDelete=proc {|path,volume,length,async|
     return if !path || !safeExists?(path)
     thread=Thread.new {
        Thread.stop
        _path=Thread.current[:path]
        _length=Thread.current[:length]
        sleep(_length);
        File.delete(_path) rescue nil
     }
     thread[:path]=path
     thread[:length]=length
     Audio.se_play(path,volume)
     thread.run
     sleep(length);
  }
  waveHdr=[getStringAddress.call(samples),samples.length,
     0,0,0,0,0,0].pack("V*")
  # 8 bit mono sound data
  waveFormat=[0x01,0x01,sampleFreq,sampleFreq,1,8,0].pack("vvVVvvv")
  duration=samples.length
  waveOutHandle=" "*4
  code=waveOutOpen.call(waveOutHandle,-1,waveFormat,0,0,0)
  if code!=0
    timeLength=samples.length.to_f/sampleFreq
    path=saveToTemp.call(samples,sampleFreq)
    playThenDelete.call(path,volume,timeLength,async)
    return
  end
  waveOutHandle=waveOutHandle.unpack("L")[0]
  volume=(volume*65535/100)
  volume=(volume<<16)|volume
  waveOutSetVolume.call(waveOutHandle,volume)
  code=waveOutPrepareHeader.call(waveOutHandle,waveHdr,waveHdr.length)
  if code!=0
    waveOutClose.call(waveOutHandle)
    return
  end
  thread=Thread.new {
     Thread.stop
     waveOut=Thread.current[:waveOut]
     waveHdr=Thread.current[:waveHeader]
     waveData=Thread.current[:waveData]
     waveOutUnprepareHeader=Win32API.new("winmm.dll","waveOutUnprepareHeader","lpl","l")
     waveOutClose=Win32API.new("winmm.dll","waveOutClose","l","l")
     loop do
       sleep(1)
       hdr=waveHdr.unpack("V*")
       flags=hdr[4]
       if (flags&1)==1
         # All done
         waveOutUnprepareHeader.call(waveOut,waveHdr,waveHdr.length)
         waveOutClose.call(waveOut)
         break
       end
     end
  }
  thread[:waveOut]=waveOutHandle
  thread[:waveHeader]=waveHdr
  thread[:waveData]=@samples
  if waveOutWrite.call(waveOutHandle,waveHdr,waveHdr.length)!=0
    waveOutClose.call(waveOutHandle)
    return
  end
  thread.run
  sleep(@duration/1000.0) if !async
  return
end



class NoteEnvelope
  attr_accessor :fall
  attr_accessor :max
  attr_reader :envelope

  def initialize(fall=1200,maxPoint=30)
    @fall=fall # time until fall to zero
    @maxPoint=maxPoint # maximum point
    @envelope=SoundEnvelope.new
  end

  def falling(duration)
    return self if duration<=0
    @envelope.changeDiscrete(0,@maxPoint)
    if duration>=@fall
      @envelope.change(fall,0)
      @envelope.change(duration-fall,0)
    else
      @envelope.change(duration,@maxPoint*duration/@fall)
    end
    @envelope.changeDiscrete(0,0)
    return self
  end

  def sweeping(duration,sweepDuration)
    return self if duration<=0
    return steady(duration) if sweepDuration<=0
    @envelope.changeDiscrete(0,@maxPoint)  
    falling=true
    while duration>0
      dur=duration>sweepDuration ? sweepDuration : duration
      if falling
        self.falling(dur)
      else
        sd=sweepDuration
        if sd>@fall
          d=[(sweepDuration-@fall),dur].min
          @envelope.change(d,0)
          dur-=d
          sd-=d
        end
        if d==sd
          @envelope.change(dur,@maxPoint)
        else
          @envelope.change(dur,@maxPoint*(@fall-(sd-dur))/@fall)
        end
      end
      falling=!falling
      duration-=sweepDuration
    end
    @envelope.changeDiscrete(0,0)
    return self
  end

  def rest(duration)
    if duration>0
      @envelope.changeDiscrete(0,0)
      @envelope.changeDiscrete(duration,0)
    end
    return self
  end

  def steady(duration)
    if duration>0
      @envelope.changeDiscrete(0,@maxPoint)
      @envelope.changeDiscrete(duration,@maxPoint)
      @envelope.changeDiscrete(0,0)
    end
    return self
  end
end



# A class for holding audio data in memory. This class
# is easy to serialize into the save file.
class WaveData
  def initialize(samplesPerSec,samples)
    @freq=samplesPerSec
    @samples=samples.is_a?(String) ? samples.clone : samples.pack("C*")
  end

  def setSamples(samples)
    @samples=samples.is_a?(String) ? samples.clone : samples
  end

  def self._load(string)
    data=Marshal.load(string)
    ret=self.new(data[0],[])
    ret.setSamples(Zlib::Inflate.inflate(data[1]))
    return ret
  end

  def _dump(depth=100)
    return Marshal.dump([@freq,Zlib::Deflate.deflate(@samples)])
  end

  def intensity
    distance=@samples.length/2000
    i=distance/2
    count=0
    volume=0
    while i<@samples.length
      vol=(@samples[i]-128).abs
      vol=127 if vol>127
      if vol>=16
        volume+=vol
        count+=1
      end
      i+=distance
    end
    return 0 if count==0
    return volume/count # from 0 through 127
  end

  def time
    return @freq==0 ? 0.0 : (@samples.length)*1.0/@freq
  end

  def play
    # Play sound data asynchronously
    pbPlaySoundData(@samples,100,true,@freq)
  end

  def save(filename)
    pbSaveSoundData(@samples,@freq,filename)
  end
end



# A class for specifying volume, frequency, and timbre envelopes.
class SoundEnvelope; include Enumerable
  def initialize(env=nil)
    @e=[];
    set(env) if env
  end

  def self.fromToneFile(file)
    envelope=self.new
    File.open(file,"rb"){|f|
       f.gets if !f.eof?
       while !f.eof?
         ln=f.gets
         if ln[ /^(\d+)\s+(\d+)/ ]
           envelope.addValueChange($1.to_i,$2.to_i)
         end
       end
    }
    return envelope
  end

  def length; @e.length; end
  def [](x); @e[x]; end
  def each; @e.each {|x| yield x }; end
  def clear; @e.clear; end

  def changeAbsolute(pos,volume)
    return self if pos<0
    velength=@e.length
    if velength>0
      @e.push([pos,volume])
      stableSort()
    else
      @e.push([pos,volume])
    end
    return self
  end

  def self.initial(value)
    return self.new.change(0,value)
  end

  def self.smoothVolume(duration,volume)
    env=self.new
    return env if duration<8
    env.change(0,0)
    env.change(5,volume)
    env.changeAbsolute(duration-10,volume)
    env.changeAbsolute(duration-5,0)
    env.changeAbsolute(duration,0)
    return env
  end

 # Creates a volume envelope using the given attack, decay, and
 # release times and the given sustain level.
 #   duration - duration of the sound
 #   attack - attack time (in ms), or time between the start of the sound
 #     and the time where the sound reaches its maximum volume.
 #     If this value is less than 0, the sound will decay from silence to 
 #     the sustain volume instead (see below).
 #   decay - decay time (in ms), or time after the attack phase until
 #     the time where the sound reaches its sustain volume
 #   sustain - sustain volume, or normal volume of sound (0-100)
 #   release - release time (in ms), or amount of time to fade out the 
 #     sound when it reaches its end. The sound's duration includes its 
 #     release time.
  def self.attackDecayRelease(duration,attack,decay,sustain,release)
    env=self.new
    if attack<=0
      env.change(0,attack==0 ? 100 : 0)
    else
      env.change(attack,100)
    end
    env.change(decay,sustain)
    env.changeAbsolute(duration-release,sustain)
    if release>20
      env.changeAbsolute(duration-release-4,0)
    end
    env.changeAbsolute(duration,0)
    return env
  end

  def self.blink(value,onDuration,offDuration,totalDuration)
    return self.new.addValueChanges(
       value,onDuration,0,offDuration).repeat(totalDuration)
  end
    
  def change(delta,volume)
    return self if delta<0
    velength=@e.length
    if velength>0
      @e.push([@e[velength-1][0]+delta,volume])
    else
      @e.push([delta,volume])
    end
    return self
  end

  def duration
    return @e.length==0 ? 0 : @e[@e.length-1][0]
  end

  def value
    return @e.length==0 ? 0 : @e[@e.length-1][1]
  end

  def addValueChange(value,duration)
    changeDiscrete(0,value)
    changeDiscrete(duration,value)
    return self
  end

  def sweep(value1,value2,duration,sweepDuration=1000/16)
    val=true
    while duration>0
      dur=duration<sweepDuration ? duration : sweepDuration
      if val
        addValueChange(value1,dur)
      else
        addValueChange(value2,dur)
      end
      val=!val
      duration-=sweepDuration
    end
    addValueChange(0,0)
    return self
  end

  def addValueChanges(*arg)
    i=0;while i<arg.length
      changeDiscrete(0,arg[i])
      changeDiscrete(arg[i+1]||0,arg[i])
      i+=2;end
    return self
  end

  def repeat(desiredDuration)
    return self if @e.length==0 || desiredDuration<0
    oldDuration=self.duration
    currentDuration=oldDuration
    return self if oldDuration==0
    oldLength=self.length
    i=0
    while currentDuration<desiredDuration
      item=@e[i]
      newDuration=currentDuration+item[0]
      if newDuration>desiredDuration
        deltaNew=(newDuration-self.duration)
        deltaDesired=(desiredDuration-self.duration)
        newValue=deltaNew==0 ? self.value : self.value+(item[1]-self.value)*deltaDesired/deltaNew
        @e.push([desiredDuration,newValue])
        break
      else
        @e.push([newDuration,item[1]])
      end
      i+=1
      if i>=oldLength
        i=0; currentDuration+=oldDuration
      end
    end
    return self
  end

 # Changes the volume, frequency, etc. abruptly without blending.
  def changeDiscrete(delta,volume)
    return self if delta<0
    velength=@e.length
    if velength>0
      oldValue=@e[velength-1][1]
      oldDelta=@e[velength-1][0]
      newDelta=oldDelta+delta
      newValue=oldValue
      if newDelta!=oldDelta || newValue!=oldValue
        @e.push([newDelta,newValue])
        oldDelta=newDelta
        oldValue=newValue
      end
      newValue=volume
      if newDelta!=oldDelta || newValue!=oldValue
        @e.push([newDelta,newValue])
      end
    else
      @e.push([delta,volume])
    end
    return self
  end

  def set(value)
    if value.is_a?(SoundEnvelope) || value.is_a?(Array)
      @e.clear
      for v in value; @e.push(v); end
    end
    return self
  end

  private

  def stableSort
    pm=1;while pm<@e.length
      pl=pm; while pl>0 && @e[pl-1][0]>@e[pl][0]
        tmp=@e[pl]; @e[pl]=@e[pl-1]; @e[pl-1]=tmp
        pl-=1; end
      pm+=1;end
  end
end



# internal class
class SoundEnvelopeIterator# :nodoc:
  def initialize(env)
    @env=env
    @envIndex=0
  end

  def getValue(frame)
    value=0
    if @envIndex==@env.length
      value=@env[@envIndex-1][1] 
    elsif @envIndex==0
      value=@env[@envIndex][1]
    else
      lastPos=@env[@envIndex-1][0]
      thisPos=@env[@envIndex][0]
      if thisPos!=lastPos
        lastVolume=@env[@envIndex-1][1]
        thisVolume=@env[@envIndex][1]
        value=(thisVolume-lastVolume)*(frame-lastPos)/(thisPos-lastPos)+lastVolume
     else
        value=@env[@envIndex][1] 
      end
    end
    while @envIndex+1<=@env.length && @env[@envIndex][0]==frame.to_i
       @envIndex+=1
    end
    return value
  end
end



# internal class
class WaveForm# :nodoc:
  SAMPLEFREQ=11025

  def initialize(proc,freq,duration,timbre=0.5)
    @duration=duration # in ms
    @volumeEnvelope=SoundEnvelope.new
    @freqEnvelope=SoundEnvelope.new
    @timbreEnvelope=SoundEnvelope.new
    @proc=proc
    @freq=freq
    @timbre=timbre
    if @freq.is_a?(Array) || @freq.is_a?(SoundEnvelope)
      @freqEnvelope.set(@freq)
      @freq=@freq.length>0 ? @freq[0][1] : 800
    end
    if @timbre.is_a?(Array) || @timbre.is_a?(SoundEnvelope)
      @timbreEnvelope.set(@timbre)
      @timbre=@timbre.length>0 ? @timbre[0][1] : 0.5
    end
  end

  def setFrequencyEnvelope(env)
    if env.is_a?(Numeric)
      @freqEnvelope.clear
      @freqEnvelope.addValueChange(env,@duration)
    else
      @freqEnvelope.set(env)
    end
  end

  def setVolumeEnvelope(env)
    if env.is_a?(Numeric)
      @volumeEnvelope.clear
      @volumeEnvelope.addValueChange(env,@duration)
    else
      @volumeEnvelope.set(env)
    end
  end

  def lcm(x,y)
    return y if x==0; return x if y==0
    return x if x==y
    if x>y; incr=x
      while x%y!=0; x+=incr; end
      return x
    else; incr=y
      while y%x!=0; y+=incr; end
      return y
    end
  end

  def start
    @i=0
    @volumeIterator=SoundEnvelopeIterator.new(@volumeEnvelope)
    @freqIterator=SoundEnvelopeIterator.new(@freqEnvelope)
    @timbreIterator=SoundEnvelopeIterator.new(@timbreEnvelope)
    @sampleCount=@duration*SAMPLEFREQ/1000
    @samples=" "*@sampleCount
    @exactSamplesPerPass=@freq==0 ? 1.0 : [SAMPLEFREQ.to_f/@freq,1].max
    @step=1.0/@exactSamplesPerPass
    @exactCounter=0
  end

  def self.frac(x)
    return x-x.floor
  end

  def nextSample
    vol=100
    fframe=@i*1000.0/SAMPLEFREQ
    if @volumeEnvelope.length>0 # Update volume
      vol=@volumeIterator.getValue(fframe)
    end
    if @proc
      updateBuffer=false
      if @freqEnvelope.length>0 # Update frequency
        freq=@freqIterator.getValue(fframe)
        if freq!=@freq # update sample buffer
          @freq=freq
          @exactSamplesPerPass=@freq==0 ? 1.0 : [SAMPLEFREQ.to_f/@freq,1].max
          @step=1.0/@exactSamplesPerPass
        end
      end
      if @timbreEnvelope.length>0 # Update timbre
        @timbre=@timbreIterator.getValue(fframe)
      end
      if @freq==0 || vol==0
        @samples[@i]=0x80
      else
        sample=@proc.call(@exactCounter,@timbre)
        @samples[@i]=0x80+(vol*sample).round
      end
    else # noise
      v=vol.abs.to_i*2
      @samples[@i]=0x80+(rand(v).to_i-(v/2))
    end
    @i+=1
    @exactCounter+=@step
    while @exactCounter>1.0; @exactCounter-=1.0; end
  end
  
  def mixSamples(other)
    for i in 0...other.sampleCount
      newSamp=((@samples[i]-0x80)+(other.samples[i]-0x80))/2+0x80
      @samples[i]=newSamp
    end
  end

  def play(volume=100, async=false)
    pbPlaySoundData(@samples,volume,async,SAMPLEFREQ)
  end

  def generateSound
    start
    while @i<@sampleCount
      nextSample
    end
  end

  def toWaveData
    return WaveData.new(SAMPLEFREQ,@samples)
  end

  def save(filename)
    pbSaveSoundData(@samples,SAMPLEFREQ,filename)
  end

  attr_accessor :samples,:sampleCount
end



module Audio
  module Note
    REST    = 0
    GbelowC = 196
    A       = 220
    Asharp  = 233
    B       = 247
    C       = 262
    Csharp  = 277
    D       = 294
    Dsharp  = 311
    E       = 330
    F       = 349
    Fsharp  = 370
    G       = 392
    Gsharp  = 415
  end

  module NoteLength
    WHOLE     = 1600
    HALF      = WHOLE/2
    QUARTER   = HALF/2
    EIGHTH    = QUARTER/2
    SIXTEENTH = EIGHTH/2
  end

  def self.noise(durationInMs=200, volume=100, async=false)
    return if durationInMs<=0
    waveForm=WaveForm.new(nil,0,durationInMs)
    if volume.is_a?(Array) || volume.is_a?(SoundEnvelope)
      waveForm.setVolumeEnvelope(volume)
      volume=100
    end
    waveForm.generateSound
    waveForm.play(volume,async)
  end

  # internal method
  def self.envelopeDuration(env)
    return 0 if !env
    if env.is_a?(SoundEnvelope) || env.is_a?(Array)
      return SoundEnvelope.new(env).duration
    end
    return 0
  end

  def self.oscillateDouble(durationInMs, freq1, freq2, volume1, volume2,
                           timbre1, timbre2, proc1, proc2, async=false)
    return if durationInMs<0
    freq1Zero=(freq1.is_a?(Numeric) && freq1<=0) ||
       (freq1.is_a?(Array) && freq1.length==0)
    freq2Zero=(freq2.is_a?(Numeric) && freq2<=0) ||
       (freq2.is_a?(Array) && freq2.length==0)
    if freq1Zero && freq2Zero
      Thread.sleep(durationInMs/1000.0) if !async
      return
    end
    if durationInMs==0 || durationInMs==nil
      durationInMs=[
         envelopeDuration(freq1),
         envelopeDuration(freq2),
         envelopeDuration(volume1),
         envelopeDuration(volume2),
         envelopeDuration(timbre1),
         envelopeDuration(timbre2)
      ].max
      return if durationInMs<=0
    end
    waveForm1=WaveForm.new(proc1,freq1,durationInMs,timbre1)
    waveForm2=WaveForm.new(proc2,freq2,durationInMs,timbre2)
    waveForm1.setVolumeEnvelope(volume1)
    waveForm2.setVolumeEnvelope(volume2)
    waveForm1.generateSound
    waveForm2.generateSound
    waveForm1.mixSamples(waveForm2)
    waveForm1.play(100,async)
  end

  def self.oscillate(durationInMs=200, freq=800, volume=100, timbre=0.5, async=false, &block)
    return if durationInMs<0
    if (freq.is_a?(Numeric) && freq<=0) || (freq.is_a?(Array) && freq.length==0)
      Thread.sleep(durationInMs/1000.0) if !async
      return
    end
    if durationInMs==0 || durationInMs==nil
      durationInMs=[
         envelopeDuration(freq),
         envelopeDuration(volume),
         envelopeDuration(timbre)].max
      return if durationInMs<=0
    end
    waveForm=WaveForm.new(block,freq,durationInMs,timbre)
    if volume.is_a?(Array) || volume.is_a?(SoundEnvelope)
      waveForm.setVolumeEnvelope(volume)
      volume=100
    end
    waveForm.generateSound
    waveForm.play(volume,async)
  end

  def self.frac(x)
    return x-x.floor
  end

  TWOPI=Math::PI*2
  @@sineProc2=proc {|z,timbre|
     x=z<timbre ? (z*0.5/timbre) : ((z-timbre)*0.5/(1.0-timbre))+0.5
     next Math.sin(x*TWOPI)
  }

  # Generates a sine wave.
  def self.sine(durationInMs=200, freq=800, volume=100,timbre=0.5, async=false)
    oscillate(durationInMs,freq,volume,timbre,async,&@@sineProc2)
  end

  # Generates two sine waves played at once.
  def self.doubleSine(durationInMs=200, freq1=800, freq2=800, volume1=100,
                      volume2=100, timbre1=0.5, timbre2=0.5, async=false)
    oscillateDouble(durationInMs,freq1,freq2,volume1,volume2,
       timbre1,timbre2,@@sineProc2,@@sineProc2,async)
  end

  @@noiseProc2=proc {|i,timbre| 
     n=(rand(256)/255.0)*0.1
     rand(2)==0 ? 1-n : -1+n
  }

  def self.noise2(durationInMs=200, freq=800, volume=100, timbre=0.5, async=false)
    oscillate(durationInMs,freq,volume,timbre,async,&@@noiseProc2)
  end

  @@squareProc2=proc {|i,timbre| i<timbre ? 1 : -1 }

  # Generates a square wave.
  def self.square(durationInMs=200, freq=800, volume=100, timbre=0.5, async=false)
    oscillate(durationInMs,freq,volume,timbre,async,&@@squareProc2)
  end

  # Generates a telephone button tone.
  def self.dtmf(tone, durationInMs=200, volume=95, async=false)
    return if !tone
    if tone.length>1
      for i in 0...tone.length
        dtmf(tone[i,1],durationInMs,volume,false)
      end
    end
    t1=0
    t1=1209 if "14ghi7pqrs*".include?(tone)
    t1=1336 if "2abc5jkl8tuv0".include?(tone)
    t1=1477 if "3def6mno9wxyz#".include?(tone)
    t1=1633 if "ABCD".include?(tone)
    t2=0
    t2=697 if "12abc3defA".include?(tone)
    t2=770 if "4ghi5jkl6mnoB".include?(tone)
    t2=852 if "7pqrs8tuv9wxyzC".include?(tone)
    t2=941 if "*0#D".include?(tone)
    return if t1==0 || t2==0
    f1=Math::PI*2.0*t1/WaveForm::SAMPLEFREQ
    f2=Math::PI*2.0*t2/WaveForm::SAMPLEFREQ
    doubleSine(durationInMs,t1,t2,volume,volume,0.5,0.5,async)
  end

  def self.beep(durationInMs=200, freq=800, volume=100, timbre=0.5, async=false)
    square(durationInMs,freq,volume,timbre,async)
  end

  @@triangleProc2=proc {|z,timbre|
     z<timbre ? (1-(z.to_f/timbre)*2.0) : ((((z-(1.0-timbre)).to_f/(1.0-timbre))*2.0)-1.0)
  }

  # Generates a triangle wave.
  # "timbre" specifies the timbre of the tone; from 0 through 1
  # a timbre of 0 or 1 generates a saw wave
  def self.triangle(durationInMs=200, freq=800, volume=100, timbre=0.5, async=false)
    oscillate(durationInMs,freq,volume,timbre,async,&@@triangleProc2)
  end

  @@triangleProc3=proc {|z,timbre|
     v=z<timbre ? (1-(z.to_f/timbre)*2.0).abs : -(((((z-(1.0-timbre)).to_f/(1.0-timbre))*2.0)-1.0).abs)
     (v<0) ? -(0.5+(-v/2)) : 0.5+(v/2)
  }

  # Generates an NES triangle wave.
  # "timbre" specifies the timbre of the tone; from 0 through 1
  def self.triangle2(durationInMs=200, freq=800, volume=100, timbre=0.5, async=false)
    oscillate(durationInMs,freq,volume,timbre,async,&@@triangleProc3)
  end

  def self.playTone(tone,async=false)
    beep(0,SoundEnvelope.fromToneFile(tone),80,0.5,async)
  end

  # Generates a saw wave.
  def self.saw(durationInMs=200, freq=800, volume=100, async=false)
    # same as triangle wave with timbre of 1
    triangle(durationInMs,freq,volume,1.0,async)
  end
end



def ringtone(duration,volume=95)
  Audio.sine(duration,
     SoundEnvelope.new.addValueChanges(
        1209,500,1477,500,0,2000).repeat(duration),volume)
end

def backspace(duration=50,volume=95)
  Audio.doubleSine(duration,852,1633,volume,volume)
end

def callwaiting(duration=50,volume=95)
  Audio.doubleSine(duration,941,1633,volume,volume)
end

def callheld(duration,volume=95)
  Audio.doubleSine(duration,
     SoundEnvelope.new.addValueChanges(
        480,200,0,150,480,200,0,150,480,200,0,1950).repeat(duration),
     SoundEnvelope.new.addValueChanges(
        440,200,0,150,440,200,0,150,440,200,0,1950).repeat(duration),
     volume,volume)
end

def loudFastBusy(duration,volume=95)
  Audio.doubleSine(duration,
     SoundEnvelope.blink(480,250,250,duration),
     SoundEnvelope.blink(620,250,250,duration)
  )
end

def toneUS(toneType, duration, volume = 95)
  case toneType
  when 0  # dialtone
    Audio.doubleSine(duration, 350, 440, volume)
  when 1  # busy
    Audio.doubleSine(duration,
                     SoundEnvelope.blink(480, 500, 500, duration),
                     SoundEnvelope.blink(620, 500, 500, duration),
                     volume, volume)
  when 2  # ringback
    Audio.doubleSine(duration,
                     SoundEnvelope.blink(480, 2000, 4000, duration),
                     SoundEnvelope.blink(440, 2000, 4000, duration),
                     volume, volume)
  when 3  # callfailed
    Audio.doubleSine(duration,
                     SoundEnvelope.blink(480, 300, 200, duration),
                     SoundEnvelope.blink(620, 300, 200, duration),
                     volume, volume)
  end
end

def toneDE(toneType,duration,volume=95)
  case toneType
  when 0: # dialtone
    Audio.sine(duration,425,volume)
  when 1: # busy
    Audio.sine(duration,SoundEnvelope.blink(425,480,480,duration),volume)
  when 2: # ringback
    Audio.sine(duration,SoundEnvelope.blink(425,1000,4000,duration),volume)
  when 3: # callfailed
    Audio.sine(duration,SoundEnvelope.blink(425,240,240,duration),volume)
  end
end

def toneFR(toneType,duration,volume=95)
  case toneType
  when 0:
    Audio.sine(duration,440,volume)
  when 1:
    Audio.sine(duration,SoundEnvelope.blink(440,500,500,duration),volume)
  when 2:
    Audio.sine(duration,SoundEnvelope.blink(440,1500,3500,duration),volume)
  when 3:
    Audio.sine(duration,SoundEnvelope.blink(440,250,250,duration),volume)
  end
end

def toneIsrael(toneType,duration,volume=95)
  case toneType
  when 0:
    Audio.sine(duration,400,volume)
  when 1:
    Audio.sine(duration,SoundEnvelope.blink(400,500,500,duration),volume)
  when 2:
    Audio.sine(duration,SoundEnvelope.blink(400,1000,3000,duration),volume)
  when 3
    Audio.sine(duration,SoundEnvelope.blink(400,250,250,duration),volume)
  end
end

def toneNL(toneType,duration,volume=95)
  case toneType
  when 0:
    Audio.sine(duration,425,volume)
  when 1:
    Audio.sine(duration,SoundEnvelope.blink(425,500,500,duration),volume)
  when 2:
    Audio.sine(duration,SoundEnvelope.blink(425,1000,4000,duration),volume)
  when 3:
    Audio.sine(duration,SoundEnvelope.blink(425,250,250,duration),volume)
  end
end

def toneGB(toneType,duration,volume=95)
  case toneType
  when 0:
    Audio.sine(duration,350,440,volume)
  when 1:
    Audio.sine(duration,SoundEnvelope.blink(400,375,375,duration),volume)
  when 2:
    Audio.doubleSine(duration,
       SoundEnvelope.new.addValueChanges(400,400,0,200,400,400,0,2000).repeat(duration),
       SoundEnvelope.new.addValueChanges(450,400,0,200,450,400,0,2000).repeat(duration),
       volume,volume)
  when 3:
    Audio.sine(duration,
       SoundEnvelope.new.addValueChanges(400,400,0,350,400,225,0,525).repeat(duration),
       volume)
  end
end

# internal function
def getOggPage(file)
  pos=file.pos
  fgetdw=proc{|file|
     (file.eof? ? 0 : (file.read(4).unpack("V")[0] || 0))
  }
  dw=fgetdw.call(file)
  return nil if dw!=0x5367674F
  header=file.read(22)
  bodysize=0
  hdrbodysize=(file.read(1)[0] rescue 0)
  hdrbodysize.times do
    bodysize+=(file.read(1)[0] rescue 0)
  end
  ret=[header,file.pos,bodysize,file.pos+bodysize]
  return ret
end

# internal function
def oggfiletime(file)
  fgetdw=proc{|file|
     (file.eof? ? 0 : (file.read(4).unpack("V")[0] || 0))
  }
  fgetw=proc{|file|
     (file.eof? ? 0 : (file.read(2).unpack("v")[0] || 0))
  }
  pages=[]
  page=nil
  begin
    page=getOggPage(file)
    if page
      pages.push(page)
      file.pos=page[3]
    end
  end while page
  if pages.length==0
    return -1
  end
  curserial=nil
  i=-1
  pcmlengths=[]
  rates=[]
  for page in pages
    header=page[0]
    serial=header[10,4].unpack("V")
    frame=header[2,8].unpack("C*")
    frameno=frame[7]
    frameno=(frameno<<8)|frame[6]
    frameno=(frameno<<8)|frame[5]
    frameno=(frameno<<8)|frame[4]
    frameno=(frameno<<8)|frame[3]
    frameno=(frameno<<8)|frame[2]
    frameno=(frameno<<8)|frame[1]
    frameno=(frameno<<8)|frame[0]
    if serial!=curserial
      curserial=serial
      file.pos=page[1]
      packtype=(file.read(1)[0] rescue 0)
      string=file.read(6)
      if string!="vorbis"
        return -1
      end
      if packtype!=1
        return -1
      end
      i+=1
      version=fgetdw.call(file)
      if version!=0
        return -1
      end
      channels=(file.read(1)[0] rescue 0)
      rates[i]=fgetdw.call(file)
    end
    pcmlengths[i]=frameno
  end
  ret=0.0
  for i in 0...pcmlengths.length
    ret+=pcmlengths[i]*1.0/rates[i]
  end
  return ret
end

def getPlayTime(filename)
  if safeExists?(filename)
    return [getPlayTime2(filename),0].max
  elsif safeExists?(filename+".wav")
    return [getPlayTime2(filename+".wav"),0].max
  elsif safeExists?(filename+".mp3")
    return [getPlayTime2(filename+".mp3"),0].max
  elsif safeExists?(filename+".ogg")
    return [getPlayTime2(filename+".ogg"),0].max
  else
    return 0
  end
end

def getPlayTime2(filename)
  time=-1
  return -1 if !safeExists?(filename)
  fgetdw=proc{|file|
     (file.eof? ? 0 : (file.read(4).unpack("V")[0] || 0))
  }
  fgetw=proc{|file|
     (file.eof? ? 0 : (file.read(2).unpack("v")[0] || 0))
  }
  File.open(filename,"rb"){|file|
     file.pos=0
     fdw=fgetdw.call(file)
     if fdw==0x46464952 # "RIFF"
       filesize=fgetdw.call(file)
       wave=fgetdw.call(file)
       if wave!=0x45564157 # "WAVE"
         return -1
       end
       fmt=fgetdw.call(file)
       if fmt!=0x20746d66 # "fmt "
         return -1
       end
       fmtsize=fgetdw.call(file)
       format=fgetw.call(file)
       channels=fgetw.call(file)
       rate=fgetdw.call(file)
       bytessec=fgetdw.call(file)
       if bytessec==0
         return -1
       end
       bytessample=fgetw.call(file)
       bitssample=fgetw.call(file)
       data=fgetdw.call(file)
       if data!=0x61746164 # "data"
         return -1
       end
       datasize=fgetdw.call(file)
       time=(datasize*1.0)/bytessec
       return time
     elsif fdw==0x5367674F # "OggS"
       file.pos=0
       time=oggfiletime(file)
       return time
     end
     file.pos=0
     # Find the length of an MP3 file
     while true
       rstr=""
       ateof=false
       while !file.eof?
         if (file.read(1)[0] rescue 0)==0xFF
           begin; rstr=file.read(3); break; rescue; ateof=true; break; end
         end
       end
       break if ateof || !rstr || rstr.length!=3
       if rstr[0]==0xFB
         t=rstr[1]>>4
         next if t==0 || t==15
         freqs=[44100,22050,11025,48000]
         bitrates=[32,40,48,56,64,80,96,112,128,160,192,224,256,320]
         bitrate=bitrates[t]
         t=(rstr[1]>>2)&3
         freq=freqs[t]
         t=(rstr[1]>>1)&1
         filesize=FileTest.size(filename)
         frameLength=((144000*bitrate)/freq)+t
         numFrames=filesize/(frameLength+4)
         time=(numFrames*1152.0/freq)
         break
       end
     end
  }
  return time
end

# Creates wave data from the given WAV file path
def getWaveData(filename)
  time=-1
  fgetdw=proc{|file|
     (file.eof? ? 0 : (file.read(4).unpack("V")[0] || 0))
  }
  fgetw=proc{|file|
     (file.eof? ? 0 : (file.read(2).unpack("v")[0] || 0))
  }
  if !safeExists?(filename)
    return 1 # Not found
  end
  File.open(filename,"rb"){|file|
     file.pos=0
     fdw=fgetdw.call(file)
     if fdw==0x46464952 # "RIFF"
       filesize=fgetdw.call(file)
       wave=fgetdw.call(file)
       if wave!=0x45564157 # "WAVE"
         return 2
       end
       fmt=fgetdw.call(file)
       if fmt!=0x20746d66 # "fmt "
         return 2
       end
       fmtsize=fgetdw.call(file)
       format=fgetw.call(file)
       if format!=1
         return 3 # unsupported
       end
       channels=fgetw.call(file) # channels (1 or 2)
       if channels!=1
         return 3 # unsupported
       end
       rate=fgetdw.call(file) # samples per second
       bytessec=fgetdw.call(file) # avg bytes per second
       if bytessec==0
       return 2
       end
       bytessample=fgetw.call(file) # bytes per sample
       bitssample=fgetw.call(file) # bits per sample (8, 16, etc.)
       if bitssample!=8 && bitssample!=16
         return 3 # unsupported
       end
       data=fgetdw.call(file)
       if data!=0x61746164 # "data"
         return 2
       end
       datasize=fgetdw.call(file)
       data=file.read(datasize)
       samples=nil
       if bitssample==8
         samples=data.unpack("C*")
         start=0
         for i in 0...samples.length
           s=samples[i]
           if s<0x70 || s>=0x90
             start=i
             break
           end
         end
         finish=start
         i=samples.length-1
         while i>=start
           s=samples[i]
           if s<0x70 || s>=0x90
             finish=i+1
             break
           end
           i-=1
         end
         if finish==start
           return 4 # Nothing was recorded
         end
         start=0
         finish=samples.length
         wave=WaveData.new(rate,samples[start,finish-start])
         return wave
       elsif bitssample==16
         samples=data.unpack("v*")
         start=0
         for i in 0...samples.length
           s=samples[i]
           if s>0x1000 && s<0xF000
             start=i
             break
           end
         end
         finish=start
         i=samples.length-1
         while i>=start
           s=samples[i]
           if s<0x1000 && s<0xF000
             finish=i+1
             break
           end
           i-=1
         end
         if finish==start
           return 4 # Nothing was recorded
         end
         start=0
         # Convert to 8-bit samples
         for i in start...finish
           samples[i]=((samples[i]-0x8000)>>8)&0xFF
         end
         finish=samples.length
         return WaveData.new(rate,samples[start,finish-start])
       end
     end
  }
  return 2
end

###############################

begin
  MciSendString = Win32API.new('winmm','mciSendString','%w(p,p,l,l)','l') 
  MciErrorString = Win32API.new('winmm','mciGetErrorString','%w(l,p,l)','l')
rescue
  MciSendString=nil
  MciErrorString=nil
end

# Starts recording.  Returns 0 if successful.
def beginRecord
  return 256+72 if !MciSendString
  MciSendString.call("open new type waveaudio alias RECORDER buffer 4",0,0,0)
  MciSendString.call("set RECORDER channels 1",0,0,0)
  retval=MciSendString.call("record RECORDER",0,0,0)
  if retval!=0
    MciSendString.call("close RECORDER",0,0,0)
  end
  return retval
end


# Gets a single sample from the microphone.
# The beginRecord or beginRecordUI function must have been called beforehand.
def getRecorderSample
  return 0x8000 if !MciSendString
  buffer="\0"*256
  ret=0
  MciSendString.call("stop RECORDER",0,0,0)
  MciSendString.call("status RECORDER bitspersample",buffer,256,0)
  bitspersample=buffer.to_i
  MciSendString.call("status RECORDER level",buffer,256,0)
  MciSendString.call("record RECORDER",0,0,0)
  if bitspersample==8
    ret=buffer.to_i<<8 # max 128
  else
    ret=buffer.to_i    # max 0x8000
  end
  return ret
end

def stopRecord()
  return if !MciSendString
  MciSendString.call("stop RECORDER",0,0,0)
  MciSendString.call("close RECORDER",0,0,0)
end

def endRecord(file)
  return if !MciSendString
  MciSendString.call("stop RECORDER",0,0,0)
  if file && file!=""
    MciSendString.call("save RECORDER #{file}",0,0,0)
  end
  MciSendString.call("close RECORDER",0,0,0)
end

#Audio.sine(140,SoundEnvelope.initial(6400).change(140,11400),50)
