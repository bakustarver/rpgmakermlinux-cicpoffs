# Ruby 1.8 compat
module Ruby18
    module ObjectPatch
        # Object#type used to be an alias to Object#class
        def type
            self.class
        end
    end

    class IncludeStringArray < Array
        def include?(thing)
            if thing.is_a?(String) then
                super(thing.to_sym)
            else
                super
            end
        end
    end

    module KernelPatch
        # Used to return a string array
        def methods(*)
            IncludeStringArray.new super
        end

        def singleton_methods(*)
            IncludeStringArray.new super
        end
    end

    module ModulePatch
        # Used to return string array.
        # Fix instance_methods.include? use-case by patching it to work with strings
        # The array will still be of symbols however
        def instance_methods(*)
            IncludeStringArray.new super
        end

        def public_instance_methods(*)
            IncludeStringArray.new super
        end

        def private_instance_methods(*)
            IncludeStringArray.new super
        end
    end

    module ArrayPatch
        def nitems
            count {|i| !i.nil?}
        end

        def choice
            sample
        end
    end

    module HashPatch
        def index(value)
            key value
        end
    end


    # Apply Patches
    Object.prepend ObjectPatch
    Module.prepend ModulePatch
    Kernel.prepend KernelPatch
    Array.prepend ArrayPatch
    Hash.prepend HashPatch
end
