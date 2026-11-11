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
  revision 3
  compatibility_version 1
  head "https://github.com/m6w6/ext-raphf.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/raphf/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "14092e764307ac7dbe4d756ee1a6879199e21ab6436eff89f8a031dc193d9285"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "55c685c381c63bc2533f254a110313cdb497f8a5c57a513dd16cf949569ac7d6"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "b4a01cf5be4a911b713e3a2bb5394cac3e56567d7891780bd7ced6fd76edccba"
    sha256 cellar: :any,                 arm64_linux:       "45996e1c55dfb3f463139c905727f053d786f9820d04d95aaa5b2b69fd53186d"
    sha256 cellar: :any,                 x86_64_linux:      "a1e79b8a3c3e81768d722fed042aae2e43e7e81ce56cad505bde2b7763e2face"
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
