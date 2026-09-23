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
  compatibility_version 1
  head "https://github.com/m6w6/ext-raphf.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/raphf/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "b25fa18526fbcfab4dd7d98b1c315db1154445fcece5dfde274e56db53188167"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "3323bce7c3b757bf140d60f5ba944a849d9957ac7039ab3294d3dab359e58929"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "8588f9fe3fa1049a84bf4c38cd06847f3f4b6d48432194cea51ea13b4ca90d4d"
    sha256 cellar: :any,                 arm64_linux:       "ae1a71ea18b09d78c3a61c9c037a9997ea59e7e4b37b01fd73f84607023870c3"
    sha256 cellar: :any,                 x86_64_linux:      "6ee7e582945161d88c38b0082d7401e850882c6f6520a82105c81912b1c5247c"
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
