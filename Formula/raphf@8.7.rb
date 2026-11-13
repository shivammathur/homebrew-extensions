# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT87 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "47cc8311db4174e575db9a8e873b3c32afd6d36bf1193b217f231f3b583a6e13"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "c4778528ffa2fa74eb4c529b972554c04ef2018dfa7386d746d9825062adbc25"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "75874d457b2b9d5052aec8a5567aab210dd526a14ed3a0f0a73512154e555b28"
    sha256 cellar: :any,                 arm64_linux:       "301d9c41268c17198cf9bbae08aa4c967ba1eaba6ee08987be4652d9d6cdcafb"
    sha256 cellar: :any,                 x86_64_linux:      "e81e1d78a1bd5cf735bdac0c536a7685cb1d06f308f296baa2e8cd7b416438ed"
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
