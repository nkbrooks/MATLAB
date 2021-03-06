
% 
% 1. If b is a row or column vector and n is an index in the range 1:length(b), then
% 
% 		b(n) = nth element of vector b
% 
% (In various theoretical models, discrete-time indices start at 0, or even take negative values.  Such indexing schemes are not compatible with MATLAB, and should be modified by adding the proper offset so that the first element of a vector is always indexed by n=1.)
% 
% Similarly, if I is a vector of indices in the range 1:length(b), then b(I) consists of the corresponding elements of b, in the same order. For example:
% 
		b = ((0:9).').^2	% .^ (array) exponentiation

		b(1:5)

		b(1:2:10)

		b(11)

		b([1 2 3 3 2 1])	% note repetitions

		b([10:-1:1])


% 2. Reversal of entries of b (last statement) can be also accomplished using the function
% 
% 		FLIPUD (for column vectors)
% or
% 		FLIPLR (if b were a row vector instead)
% 
% Try out
% 		
% 		flipud(b)
% 
% These commands also apply to matrices, as does the more general FLIPDIM.
%  
% One more index permutation to note is circular shift (CIRCSHIFT).
% 
% 		circshift(b,4)		% shift down by 4 positions
% 
% 
% 3. Elements of an array can also be selected based on their individual properties or values, using relational operators.
% 	
% For expample,
% 
% 		b > 47
% 
% returns a logical array having the same dimension as b, where a logical '1' indicates that respective elements of b satisfies the given relationship (>50 in this case), and '0' indicates otherwise. Logical arrays are treated as numerical arrays (with numerical entries 0 or 1) in numerical computations.
% 
% The function FIND returns the indices of the nonzero elements of a vector, numerical or logical. It also applies to two-dimensional arrays (more on that later).
% 
% Try out
% 
		b>50

		find(b>50)

		b(b>50)

		b(find(b>50))

		b([0 0 0 0 0 0 0 0 1 1])  % error: convert to logical
                                  % array first, using LOGICAL

		J = logical([0 0 0 0 0 0 0 0 1 1])

		b(J)

		log2(b).*(b>50)           % log2(0) = NaN


% 4. MATLAB has extensive audio recording, processing and playback capabilities. We will demonstrate sinusoids using the low-level playback function
% 
% 		SOUNDSC(VECTOR, SAMPLING_RATE)
% 
% which:
% 	
% 	- rescales VECTOR to a maximum absolute value of 1.0, which corresponds to the maximum playback volume (to avoid clipping)
% 
% 	- processes VECTOR as required by the D/A device (soundcard)
% 
% 	- in the end, produces an audio signal that approximates the unique continuous-time signal of bandwidth < SAMPLING_RATE/2 whose samples, taken at SAMPLING_RATE (/sec), form the sequence with nonzero portion = VECTOR.
% 
% If SAMPLING_RATE is omitted, the default value is 8192 samples/sec.
% 
% Recall we came across a sinusoid and its exponentially faded version in Lab 2:

		f = 660/8192;       % frequency parameter in cycles/sample
		N = 16384;          % number of samples
		r = 4;              % exponential decay parameter

		n = 0:N-1;          % discrete time axis

		x = cos(2*pi*f*n);  % thus w = 2*pi*f

		e = exp(-r*n/N);    % like cos(.), exp(.) operates on
		                    % each element of the array

		y = x.*e;           % array multiplication
% 
% The sinusoidal vector (and its faded version) above have parameters
% 
% 		frequency f = w/(2*pi) = 660/8192 cycles/sample
% 
% 		length N = 16384 samples
% 
% Played back at sampling rate Fs = 8192 samples/sec, the resulting sinusoid has frequency
% 
% 		F = f*Fs = 660 Hz
% 
% and duration N*Ts = N/Fs = 2 sec.
% 
% 
% 5. Using x and y as in 4.,
% 
% 		Fs = 8192 ;
% 
% 		soundsc(x,Fs)		% constant amplitude
% 
% 		soundsc(y,Fs)		% decaying amplitude
% 
% 		soundsc(fliplr(y),Fs)	% backwards, FLIPLR since row vector
% 
% 		soundsc(y,Fs/2)		% half the frequency, twice the duration
% 
% 		soundsc(x,2*Fs)		% twice the frequency, half the duration
% 
% 		v = x(1:2:N) ;		% "downsample" z, f doubled
% 
% 		soundsc(v,Fs)		% essentially same as soundsc(x,2*Fs)
% 
% 		soundsc(v,Fs/2)		% essentially same as soundsc(x,Fs)
% 
% 
% 6. The rounded-off frequency F = 660 Hz corresponds to the musical note E5. (Notes E4 and (resp.) E6, one octave lower and higher than E5, have one-half and twice the frequency of E5.)
% 
% The vector below consists of the frequencies of all notes (including accidentals, i.e., sharps/flats) in the octave beginning with A3 and ending with A4.  There are thirteen frequencies in total, the ratio between two consecutive frequencies being 2^(1/12):
% 
% 
% 		F = [220 233 247 262 277 294 311 330 349 370 392 415 440];
% 
% 
% We will synthesize and play a piece consisting of notes of equal duration from the set above; the sequence of notes ("score") will be the vector of frequency indices (ranging from 1 to 13):

% 
% 		score = [1 8 13 8 13 8 13 8 5 8 12 8 12];
% 
% 
% Each note will be shaped with an envelope that includes a gradual rise as well as a fade. Both features (rise and fade) are based on decaying exponentials with parameters r1 and r2 (see below).


		T = 0.38;          % note duration in seconds
		N = ceil(T*Fs);    % no. of samples per note
		n = 0:N-1;         % time vector for each note

		f = F/Fs;          % convert Hz to cycles/sample

		r1 = 5.0;
		r2 = 6.0;

		L = length(score);

		piece = [];        % initialization of sample vector

		for i = 1:L
			x = cos(2*pi*f(score(i))*n);
			x = x.*(1-exp(-r1*n/N)).*exp(-r2*n/N);
			piece = [piece x];
		end

		plot(piece)        % note identical envelopes

% Playback (two copies of piece, back-to-back, with pause in-between):
% 
	soundsc([piece 0*n 0*n 0*n piece],Fs)
