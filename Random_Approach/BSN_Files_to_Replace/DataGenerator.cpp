#include "libbsn/generator/DataGenerator.hpp"
#include "libbsn/range/Range.hpp"

namespace bsn {
    namespace generator {
        DataGenerator::DataGenerator() : markovChain(), seed() {
        }

        DataGenerator::DataGenerator(const Markov& markov):markovChain(markov), seed() {
        }

        DataGenerator::DataGenerator(const DataGenerator& obj) : markovChain(obj.markovChain),seed() {
        }

        DataGenerator::~DataGenerator() {}

        DataGenerator& DataGenerator::operator=(const DataGenerator& obj) {
            markovChain = obj.markovChain;
            return (*this);
        }

        std::uniform_int_distribution<int> probabilityGenerator(1,100);


        void DataGenerator::setSeed() {
            std::random_device rd;
            std::mt19937 aux(rd());
            seed = aux;
        }

        void DataGenerator::nextState() {
            int32_t randomNumber = probabilityGenerator(seed);
            int32_t offset = markovChain.currentState * 5;
            double prob_0 =markovChain.transitions[offset+0];
            double prob_1 = markovChain.transitions[offset+1];
            double prob_2 = markovChain.transitions[offset+2];
            double prob_3 = markovChain.transitions[offset+3];
            double prob_4 = markovChain.transitions[offset+4];

            double accum=0;
            double min_range0=99999;
            double max_range0=99999;
            double min_range1=99999;
            double max_range1=99999;
            double min_range2=99999;
            double max_range2=99999;
            double min_range3=99999;
            double max_range3=99999;
            double min_range4=99999;
            double max_range4=99999;
    

            if(prob_0!=0.0){
                min_range0=0;
                max_range0=prob_0;
                accum=max_range0;
            }

            if(prob_1!=0.0){
                if(accum!=0.0){
                     min_range1=std::min(accum+1,100.0);
                     max_range1=std::min(accum+prob_1,100.0);
                     accum=max_range1;
                }else{
                     min_range1=0;
                     max_range1=prob_1;
                     accum=max_range1;
                }
            }

            if(prob_2!=0.0){
                if(accum!=0.0){
                     min_range2=std::min(accum+1,100.0);
                     max_range2=std::min(accum+prob_2,100.0);
                     accum=max_range2;
                }else{
                     min_range2=0;
                     max_range2=prob_2;
                     accum=max_range2;
                }
            }

            if(prob_3!=0.0){
                if(accum!=0.0){
                     min_range3=std::min(accum+1,100.0);
                     max_range3=std::min(accum+prob_3,100.0);
                     accum=max_range3;
                }else{
                     min_range3=0;
                     max_range3=prob_3;
                     accum=max_range3;
                }
            }

            if(prob_4!=0.0){
                if(accum!=0.0){
                     min_range4=std::min(accum+1,100.0);
                     max_range4=std::min(accum+prob_4,100.0);
                     accum=max_range4;
                }else{
                     min_range4=0;
                     max_range4=prob_4;
                     accum=max_range4;
                }
            }


            if (min_range0!=99999 && randomNumber >min_range0 && randomNumber <=max_range0) {
                markovChain.currentState = 0;                         
            }    
            else if (min_range1!=99999 && randomNumber >=min_range1 && randomNumber <=max_range1) {
                markovChain.currentState = 1;             
            }    
            else if (min_range2!=99999 && randomNumber >=min_range2 && randomNumber <=max_range2) {
                markovChain.currentState = 2;   
            }     
            else if (min_range3!=99999 && randomNumber >=min_range3 && randomNumber <=max_range3) {
                markovChain.currentState = 3;   
            }    
            else if (min_range4!=99999 && randomNumber >=min_range4 && randomNumber <=max_range4) {
                markovChain.currentState = 4; 
            }
        }
 
        double DataGenerator::calculateValue() {
            if (markovChain.currentState > 4 || markovChain.currentState < 0){
                throw std::out_of_range("current state is out of bounds");
            }

            bsn::range::Range range = markovChain.states[markovChain.currentState];
            // Cria um número aleatório baseado no range
            std::uniform_real_distribution<double> value_generator(range.getLowerBound(), range.getUpperBound());
            double val = value_generator(seed);
            return val;
        }

        double DataGenerator::getValue() {
            return calculateValue();
        }


    }
    
} // namespace bs 



