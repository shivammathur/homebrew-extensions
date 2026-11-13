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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "e4bb2909b8dc742a904b9b5ccd174347dab02b5f4d7ce9d0f6d2f9c86167a4aa"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "be808e96d4882d476e99486554739562fcd5751c42073170140475380a387d41"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "cc07d22239134dbe728aa7e0e49406595d67b45329759674a5e72bc1e26268bd"
    sha256 cellar: :any,                 arm64_linux:       "5e4ac8cd2c67a5bd6cf76eb12e5fc54ee19bd0cd004fc038595aa3dbfecc58b5"
    sha256 cellar: :any,                 x86_64_linux:      "51b3644243b69eef4268b6f172865402c6c138b0fac93183bf429683b41f7436"
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
