# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT86 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.2.tgz"
  sha256 "7e782fbe7b7de2b5f1c43f49d9eb8c427649b547573564c78baaf2b8f8160ef4"
  revision 2
  compatibility_version 1
  head "https://github.com/m6w6/ext-raphf.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/raphf/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "1cdc4f2ed543b6d10b28690b7fe5e6203facd386f7d7c590a28e165d451ecf95"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "e695fec6da09f24bdf0132f3c727ea2563e8e57870d52ecf7948ac4f1946281b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "18816bf16844e6cff715dfa8e38775470820515d043893f721e24730f13a57ca"
    sha256 cellar: :any,                 arm64_linux:       "2e459092261d66a73475d3f117a4c26cb17a6069485663c903bd6711dd8533a1"
    sha256 cellar: :any,                 x86_64_linux:      "4016f8afb3f2bd3c9fecc423c555fa125d7bf4b329326d9630a093bfd6e19c51"
  end

  def install
    Dir.chdir "raphf-#{version}"
    patch_spl_symbols
    inreplace %w[src/php_raphf_api.h src/php_raphf_api.c], "ZEND_RESULT_CODE", "zend_result"
    inreplace "src/php_raphf_api.c", "zval_dtor", "zval_ptr_dtor_nogc"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
