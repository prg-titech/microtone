#include <bits/stdc++.h>
#include <windows.h>

namespace harmonics {
    
    /// @brief true if it allows negative octave. if false, the lowest note can be defined (and it is C0 = 16.351.. Hz).
    const bool allow_negative_octave = false;

    /// @brief standard frequency for A4 note in chromatic(12TET) scale.
    const long double standard_frequency_A4 = 440.000;
    
    namespace notes {
        /// @brief note class for N-TET(tone equal temperatment).
        /// @tparam number of notes in 1 octave.
        template <int N>
        class noteTET {
            private:
                /// @brief octave of the note. greater or equal than 0. (may be extended)
                int _octave;

                /// @brief pitch of the note. greater or equal than 0 and less than N.
                int _pitch;

                /// @brief frequency of the base note (C0) with the standard A440.
                const long double _stdC0Freq440 = standard_frequency_A4 * powl(2.0, -19.0 / 4.0);
            
            public:
            /// @brief returns the new note with N-note scale.
            /// @param k interval from the C0 - base note.
            /// @return note which has interval of k from the C0.
            noteTET(int k) {
                if (!allow_negative_octave) {assert(0 <= k);}
                _pitch = k % N;
                _octave = k / N;
            }

            /// @brief returns the pitch of the note.
            /// @return pitch of the note. remind that A4 is set for 440Hz.
            int getPitch() {
                return _pitch;
            }


            /// @brief returns the octave of the note.
            /// @return octave of the note. remind that A4 is set for 440Hz.
            int getOctave() {
                return _octave;
            }

            /// @brief returns the height of the note.
            /// @return (octave) * N + pitch.
            int getHeight() {
                return _octave * N + _pitch;
            }

            /// @brief evaluate the difference of the note.
            /// @param x note with N-note scale.
            /// @return (height of x) - (height of this)
            int getDifference(noteTET x) {
                return x._octave * N + x._pitch - _octave * N - _pitch;
            }
            
            /// @brief returns the frequency of the note.
            /// @return frequency[Hz] of the note. remind that A4 is set for 440Hz.
            long double getFreq() {
                return _stdC0Freq440 * powl(2.0, (long double)this->getHeight() / N);
            }


            /// @brief evaluates the cent - log-scale of the note height - of the note. remind that 1 octave is equal with 1200 cents.
            /// @param stdFreq standard frequency for measure cent. default value is C0.
            /// @return cent[￠] of the note.
            long double getCent(long double stdFreq = _stdC0Freq440) {
                return log2l(getFreq() / stdFreq) * 1200.0;
            }

            /// @brief evaluates the cent - log-scale of the note height - of the note. remind that 1 octave is equal with 1200 cents.
            /// @param n standard note for measure cent.
            /// @return cent[￠] of the note.
            long double getCent(noteTET& n) {
                return getCent(n->getFreq());
            }

            /// @brief evaluates the cent difference of the two notes. note that 1 octave is equal with 1200 cents.
            /// @param x note to find the difference.
            /// @param y note to be the standard of the difference.
            /// @return cent[￠] difference of the note.
            friend long double getCentDifference(noteTET& x, noteTET& y) {
                return x->getCent() - y->getCent();
            }

            /// @brief play the note in beep sound.
            /// @note it uses windows.h Beep function, and it only takes ul as frequency. therefore in low frequency it may cause some error.
            /// @param duration time [ms] to play the note. remind that DWORD is same as unsigned long, and windows.h beep funcion has a little bit of delay.
            void play(DWORD duration = 1000) {
                Beep((DWORD)getFreq(), duration);
            }
        };

        template <int N>
        class scaleTET {
            
        };
    }
}



int main() {
    for (int i = 0; i < 19; i++) {
        harmonics::notes::noteTET<19> note(19 * 4 + i);
        note.play();
    }
}
