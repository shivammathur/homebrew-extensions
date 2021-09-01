# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT81 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 15
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "6b5a99689cc175f4265ebbd967e65270e58a1df5a358c71352511bcdc1caf5a4"
    sha256 cellar: :any_skip_relocation, big_sur:       "a12bcb1d31595e838f79aecd53286fadfed2081ca874d7f27cad95b6dab3906a"
    sha256 cellar: :any_skip_relocation, catalina:      "02384709d799224d44312b6cb69bc6ca4bf4cbcaa73f95c3f62bc57d2d604292"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "12c008163f0240b142307d38eccd165cab1f0489ad6e8e49eaf0f22d03e9cfe9"
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
