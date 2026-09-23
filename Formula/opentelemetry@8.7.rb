# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT87 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.4.2.tgz"
  sha256 "a355329259f373c5c7327e66310481726cfabac50cb5483eba000bec791d5017"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "1f6e14ff7a1a6ebfbe8982ca5e554bd5f2ead2a00422a1643e565fb356d5b55c"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "05523486a130627a9e31114164f06207f2b38e59b66d72d6a75373e72e7be442"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "32f1efb684cf65e6039e9f84652583651561888b95c7f63452984aaed25eacc7"
    sha256 cellar: :any,                 arm64_linux:       "0f306faaed1ced42b02aff7080f0b1e1325fa15c5915c7080687266849289dfa"
    sha256 cellar: :any,                 x86_64_linux:      "8336ed4d55df01e712cceeec12a6de6fe508c39c667885122fa883b9bfe2e5ef"
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
