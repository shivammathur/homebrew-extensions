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
  revision 1
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "534dbe89e5b4ec08111080fe9b025250c2d0cb4c575c5c5647e319ffe06f673b"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "a642f5be508fc53c2f365169c5e2ffd08ad133ffd37a0f00671850ab51cda42d"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "7fda1793827e1c9cd2e1c9869a08a6850706e7ac626a5d1cebf613a5e16ab2b1"
    sha256 cellar: :any,                 arm64_linux:       "6b8c9f5fad8464fc2b52f2e0552084288f4b442cfa6431055cadbff071f445ab"
    sha256 cellar: :any,                 x86_64_linux:      "56fc0d4737a81fafbe8c84e0c8bf530f5881bfe07cff9b35f01cba7146f8b48b"
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
