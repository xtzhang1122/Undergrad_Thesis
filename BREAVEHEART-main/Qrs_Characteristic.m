classdef Qrs_Characteristic
% Various measurements for Selvester/QRS Scoring an ECG
   
    properties (SetAccess=public)
        
        L1_Q_duration
        L1_R_duration
        L1_rq_ratio
        

        L2_Q_duration
        L2_R_duration
        L2_rq_ratio
        

        avL_Q_duration
        avL_R_duration
        avL_rq_ratio
        

        avF_Q_duration
        avF_R_duration
        avF_rq_ratio
        

        V3_Q_duration
        V3_R_duration
        V3_rq_ratio
       

        V4_Q_duration
        V4_R_duration
        V4_rq_ratio
        

        V5_Q_duration
        V5_R_duration
        V5_rq_ratio
        

        V6_Q_duration
        V6_R_duration
        V6_rq_ratio
        

        V1_Q_duration
        V1_R_duration
        

        V2_Q_duration
        V2_R_duration
       
    end
    
    
    methods
        
        function obj = Qrs_Characteristic(varargin)        % varagin: ECG12
            if nargin == 0; return; end
            if nargin ~= 3
                error('Qrs_score: expected 3 args in constructor, got %d', nargin);
            end
            
            assert(isa(varargin{1}, 'ECG12'), 'Argument is not a ECG12 class');
            assert(isa(varargin{2}, 'Lead_Morphology'), 'Argument is not a Lead_Morphology class');
            
            ecg = varargin{1};
            lead_morph = varargin{2};
            gender = varargin{3};
            

            [obj.L1_Q_duration, obj.L1_R_duration, obj.L1_rq_ratio] = qrs_score_computation(ecg.I, lead_morph.L1_q_loc, lead_morph.L1_r_loc, lead_morph.L1_s_loc, gender);
            [obj.L2_Q_duration, obj.L2_R_duration, obj.L2_rq_ratio] = qrs_score_computation(ecg.II, lead_morph.L2_q_loc, lead_morph.L2_r_loc, lead_morph.L2_s_loc, gender);
            [obj.avF_Q_duration, obj.avF_R_duration, obj.avF_rq_ratio] = qrs_score_computation(ecg.avF, lead_morph.avF_q_loc, lead_morph.avF_r_loc, lead_morph.avF_s_loc, gender);
            [obj.avL_Q_duration, obj.avL_R_duration, obj.avL_rq_ratio] = qrs_score_computation(ecg.avL, lead_morph.avL_q_loc, lead_morph.avL_r_loc, lead_morph.avL_s_loc, gender);
            [obj.V1_Q_duration, obj.V1_R_duration, ~] = qrs_score_computation(ecg.V1, lead_morph.V1_q_loc, lead_morph.V1_r_loc, lead_morph.V1_s_loc, gender);
            [obj.V2_Q_duration, obj.V2_R_duration, ~] = qrs_score_computation(ecg.V2, lead_morph.V2_q_loc, lead_morph.V2_r_loc, lead_morph.V2_s_loc, gender);
            [obj.V3_Q_duration, obj.V3_R_duration, obj.V3_rq_ratio] = qrs_score_computation(ecg.V3, lead_morph.V3_q_loc, lead_morph.V3_r_loc, lead_morph.V3_s_loc, gender);
            [obj.V4_Q_duration, obj.V4_R_duration, obj.V4_rq_ratio] = qrs_score_computation(ecg.V4, lead_morph.V4_q_loc, lead_morph.V4_r_loc, lead_morph.V4_s_loc, gender);
            [obj.V5_Q_duration, obj.V5_R_duration, obj.V5_rq_ratio] = qrs_score_computation(ecg.V5, lead_morph.V5_q_loc, lead_morph.V5_r_loc, lead_morph.V5_s_loc, gender);
            [obj.V6_Q_duration, obj.V6_R_duration, obj.V6_rq_ratio] = qrs_score_computation(ecg.V6, lead_morph.V6_q_loc, lead_morph.V6_r_loc, lead_morph.V6_s_loc, gender);

            
        end     % End main Lead_Morphology method        
        
        
        
    end     % End methods

    methods(Static)
        function l = length(); g = Qrs_Score(); l = length(properties(g)); end
        function a = allnan()
            a = Qrs_Score();
            p = properties(a);
            for i = 1:length(p)
                a.(p{i}) = nan;
            end
	end


    end
end     % End class
