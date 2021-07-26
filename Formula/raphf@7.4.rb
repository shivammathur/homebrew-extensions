# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT74 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "24e18099cb842677b79609ad30de747fa4eb7934d4b5cd800cb1a7a6fe837994"
    sha256 cellar: :any_skip_relocation, big_sur:       "ba37c42c75f6efb00b9d68c800f40944ff22189084dce55005f38045237f70c8"
    sha256 cellar: :any_skip_relocation, catalina:      "7ca2639cd4cbd8041a12d1e885453b3dc3e6029b1a3358dc7bfe35f477caefe1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b0e22cccabd68093118b8491640e5b243cd849817bc795dd4a17f55e5c97e6c9"
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
