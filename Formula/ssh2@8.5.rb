# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT85 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.6.1.tgz"
  sha256 "2212d8266df54654b282ca681ee9b82f312a776e801b667b288d80f3541741ed"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "0fcf47d1a5f67e282923a3dfa876a731cf1cdac8191aa0d46a9c5f04eba5b9f1"
    sha256 cellar: :any, arm64_tahoe:       "077f8f463488345a2b7c0fcf2d041ba9186c28d59a1365919ccfc6b9d6313cba"
    sha256 cellar: :any, arm64_sequoia:     "4f6c5e691b706baa085cb716f91ed472de2541a4b8f06d1d7f29eabd68fcdbda"
    sha256 cellar: :any, arm64_linux:       "12595f1732ed9a20fb26cca384256e685797f411fc3039f332530ffbca47a0f0"
    sha256 cellar: :any, x86_64_linux:      "b01eeca02dbe9363344bc8a8d1fdea1b9913cf1c3d0b3cdf147cea198ef0c79a"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Utils::Path.formula_opt_prefix("libssh2")}
    ]
    Dir.chdir "ssh2-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
