# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT87 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.5.0.tgz"
  sha256 "796676e071b2c6502c4dbdacccd1a2b29e12bf81d5d514b7ba85ce37de232073"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "274be546760a0e1d6adcba27a75dc9812a02873f23071b6c1e2f5de91ddd9bab"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "e77a5611eb34ca232c9d8674f9883b55ff2ec5f38ad548e1e1fd84d3b8bc807b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "a4b831458a80ad54fde315242901fb8692f44fa8de7b336b9c4502a617daf9fa"
    sha256 cellar: :any,                 arm64_linux:       "e5843cdb684eba20f2bee923c81f2dc30a96dd45006bae6aeafe9ff33afb0de1"
    sha256 cellar: :any,                 x86_64_linux:      "3cb8b8e66644dc1ab3872b31420abea76b4e5c4cb01f4904beb9ceda6bcc8a2d"
  end

  def install
    Dir.chdir "opentelemetry-#{version}"
    patch_spl_symbols
    contents = File.read("otel_observer.c")
    inreplace "otel_observer.c" do |s|
      if contents.include?("zend_internal_arg_info *arg_info =")
        s.gsub! "zend_internal_arg_info *arg_info =", "zend_arg_info *arg_info ="
      end
      s.gsub! "    size_t len = strlen(arg_info->name);\n", "" if contents.include?("strlen(arg_info->name)")
      if contents.include?("if (len == ZSTR_LEN(arg_name) &&")
        old_arg_match = "if (len == ZSTR_LEN(arg_name) &&\n                " \
                        "!memcmp(arg_info->name, ZSTR_VAL(arg_name), len)) {"
        s.gsub! old_arg_match, "if (arg_info->name && zend_string_equals(arg_name, arg_info->name)) {"
      end
      if contents.include?("save_state->prev_exception = EG(prev_exception);")
        s.gsub! "save_state->prev_exception = EG(prev_exception);", "save_state->prev_exception = NULL;"
      end
      s.gsub! "EG(prev_exception) = NULL;\n", "" if contents.include?("EG(prev_exception) = NULL;")
      if contents.include?("EG(prev_exception) = save_state->prev_exception;")
        s.gsub! "EG(prev_exception) = save_state->prev_exception;\n", ""
      end
      s.gsub! "zval_dtor", "zval_ptr_dtor_nogc" if contents.include?("zval_dtor")
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
