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
  revision 2
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "d7df98c6464e530aa37d5df346776bd4969fbf3b3707c4c9ba9b00b40f547425"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "179400d885079c1aac2156d7c464f4bcc7acaad753a058164dbcb8b732b99bff"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "70d3b447fc053a4fd394b19daa0465c50945bbef89915fbeadbd8a963282b11a"
    sha256 cellar: :any,                 arm64_linux:       "5b5d30332ee3e984a6067555a4f36fdd99121f16e85cbb50373142eeb396e78a"
    sha256 cellar: :any,                 x86_64_linux:      "584b6ea36685a3cfa3278d78f32e4acafcdd1c1d3a30b4a008862c2bc266a508"
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
