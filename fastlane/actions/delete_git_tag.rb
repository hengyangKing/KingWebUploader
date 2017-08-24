module Fastlane
  module Actions
    module SharedValues
      DELETE_GIT_TAG_CUSTOM_VALUE = :DELETE_GIT_TAG_CUSTOM_VALUE
    end

    class DeleteGitTagAction < Action
      def self.run(params)
        
        tag = params[:tagName]
        isDeleteLocalTag = params[:deleteLocalTag]
        isDeleteOriginTag = params[:deleteOriginTag]

        cmds = [];

        #deleteLocalTag
        #git tag -d tagname
        if isDeleteLocalTag
          cmds << "git tag -d #{tag}"          
        end

        #deleteOriginTag
        #git push origin :tagname
        if isDeleteOriginTag
          cmds << "git push origin :#{tag}"
          
        end
        #执行
       result =  Actions.sh(cmds.join('&'));
       return result;

      end


      def self.description
        "delete git tag action"
      end

      def self.details

        "delete git tag"
      end

      def self.available_options
        # Define all options your action supports. 
        
        # Below a few examples
        [
          FastlaneCore::ConfigItem.new( key: :tagName,
                                        description: "you want delete tag name",
                                        is_string: true, # true: verifies the input is a string, false: every kind of value
                                        optional:false),

          FastlaneCore::ConfigItem.new( key: :deleteLocalTag,
                                        description: "you want delete local tag?",
                                        is_string: false, # true: verifies the input is a string, false: every kind of value
                                        default_value: true,
                                        optional:true),

          FastlaneCore::ConfigItem.new( key: :deleteOriginTag,
                                        description: "you want delete origin tag?",
                                        is_string: false, # true: verifies the input is a string, false: every kind of value
                                        default_value: true,
                                        optional:true)
        ]
      end


      def self.return_value
        nil
      end

      def self.authors
        ["hengyangking@yeah.net"]
      end

      def self.is_supported?(platform)
        # you can do things like
        # 
        #  true
        # 
        #  platform == :ios
        # 
        #  [:ios, :mac].include?(platform)
        # 

        platform == :ios
      end

      def  self.example_code 
        [
          'delete_git_tag(tagName:"foo")',
          'delete_git_tag(tagName:"foo",deleteLocalTag:true)',
          'delete_git_tag(tagName:"foo",deleteLocalTag:true,deleteOriginTag:true)'
        ]
        
      end
    end
  end
end
