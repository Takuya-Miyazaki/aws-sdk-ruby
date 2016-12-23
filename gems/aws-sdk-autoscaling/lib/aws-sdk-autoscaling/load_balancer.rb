# WARNING ABOUT GENERATED CODE
#
# This file is generated. See the contributing for info on making contributions:
# https://github.com/aws/aws-sdk-ruby/blob/master/CONTRIBUTING.md
#
# WARNING ABOUT GENERATED CODE

module Aws::AutoScaling
  class LoadBalancer

    extend Aws::Deprecations

    # @overload def initialize(group_name, name, options = {})
    #   @param [String] group_name
    #   @param [String] name
    #   @option options [Client] :client
    # @overload def initialize(options = {})
    #   @option options [required, String] :group_name
    #   @option options [required, String] :name
    #   @option options [Client] :client
    def initialize(*args)
      options = Hash === args.last ? args.pop.dup : {}
      @group_name = extract_group_name(args, options)
      @name = extract_name(args, options)
      @data = options.delete(:data)
      @client = options.delete(:client) || Client.new(options)
    end

    # @!group Read-Only Attributes

    # @return [String]
    def group_name
      @group_name
    end

    # @return [String]
    def name
      @name
    end
    alias :load_balancer_name :name

    # One of the following load balancer states:
    #
    # * `Adding` - The instances in the group are being registered with the
    #   load balancer.
    #
    # * `Added` - All instances in the group are registered with the load
    #   balancer.
    #
    # * `InService` - At least one instance in the group passed an ELB
    #   health check.
    #
    # * `Removing` - The instances in the group are being deregistered from
    #   the load balancer. If connection draining is enabled, Elastic Load
    #   Balancing waits for in-flight requests to complete before
    #   deregistering the instances.
    #
    # * `Removed` - All instances in the group are deregistered from the
    #   load balancer.
    # @return [String]
    def state
      data.state
    end

    # @!endgroup

    # @return [Client]
    def client
      @client
    end

    # @raise [NotImplementedError]
    # @api private
    def load
      msg = "#load is not implemented, data only available via enumeration"
      raise NotImplementedError, msg
    end
    alias :reload :load

    # @raise [NotImplementedError] Raises when {#data_loaded?} is `false`.
    # @return [Types::LoadBalancerState]
    #   Returns the data for this {LoadBalancer}.
    def data
      load unless @data
      @data
    end

    # @return [Boolean]
    #   Returns `true` if this resource is loaded.  Accessing attributes or
    #   {#data} on an unloaded resource will trigger a call to {#load}.
    def data_loaded?
      !!@data
    end

    # @!group Actions

    # @example Request syntax with placeholder values
    #
    #   load_balancer.attach()
    # @param [Hash] options ({})
    # @return [Types::AttachLoadBalancersResultType]
    def attach(options = {})
      options = Aws::Util.deep_merge(options,
        auto_scaling_group_name: @group_name,
        load_balancer_names: [@name]
      )
      resp = @client.attach_load_balancers(options)
      resp.data
    end

    # @example Request syntax with placeholder values
    #
    #   load_balancer.detach()
    # @param [Hash] options ({})
    # @return [Types::DetachLoadBalancersResultType]
    def detach(options = {})
      options = Aws::Util.deep_merge(options,
        auto_scaling_group_name: @group_name,
        load_balancer_names: [@name]
      )
      resp = @client.detach_load_balancers(options)
      resp.data
    end

    # @!group Associations

    # @return [AutoScalingGroup]
    def group
      AutoScalingGroup.new(
        name: @group_name,
        client: @client
      )
    end

    # @deprecated
    # @api private
    def identifiers
      {
        group_name: @group_name,
        name: @name
      }
    end
    deprecated(:identifiers)

    private

    def extract_group_name(args, options)
      value = args[0] || options.delete(:group_name)
      case value
      when String then value
      when nil then raise ArgumentError, "missing required option :group_name"
      else
        msg = "expected :group_name to be a String, got #{value.class}"
        raise ArgumentError, msg
      end
    end

    def extract_name(args, options)
      value = args[1] || options.delete(:name)
      case value
      when String then value
      when nil then raise ArgumentError, "missing required option :name"
      else
        msg = "expected :name to be a String, got #{value.class}"
        raise ArgumentError, msg
      end
    end

    class Collection < Aws::Resources::Collection

      # @!group Batch Actions

      # @param options ({})
      # @return [void]
      def batch_attach(options = {})
        batch_enum.each do |batch|
          params = Aws::Util.copy_hash(options)
          params[:auto_scaling_group_name] = batch[0].group_name
          params[:load_balancer_names] ||= []
          batch.each do |item|
            params[:load_balancer_names] << {
              name: item.name
            }
          end
          batch[0].client.attach_load_balancers(params)
        end
        nil
      end

      # @param options ({})
      # @return [void]
      def batch_detach(options = {})
        batch_enum.each do |batch|
          params = Aws::Util.copy_hash(options)
          params[:auto_scaling_group_name] = batch[0].group_name
          params[:load_balancer_names] ||= []
          batch.each do |item|
            params[:load_balancer_names] << {
              name: item.name
            }
          end
          batch[0].client.detach_load_balancers(params)
        end
        nil
      end

      # @!endgroup

    end
  end
end