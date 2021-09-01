# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT82 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "fce3afef17af8391c119fc9403d01d65109d65552dacbdff544e12d389b1bb1e"
    sha256 cellar: :any_skip_relocation, big_sur:       "4d7d0a42f5976b1dc804a58829c250f63ce181537ebb697c0a779d9d464a0ae2"
    sha256 cellar: :any_skip_relocation, catalina:      "84fe7ffd77c039e3ced22ec18220d2ba047fffd00e482f6fd31ad61e7c45b28c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fabb9bee732080f7f4613fd9a2085a545a40361c183bee090978da19c5abcdb6"
  end

  def install
    Dir.chdir "raphf-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
