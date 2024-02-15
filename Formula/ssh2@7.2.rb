# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT72 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.4.1.tgz"
  sha256 "7bca5b23f731db9d8ed0aea5db9bb15da8ff133b0fbba96102b82e95da4d8764"
  head "https://github.com/php/pecl-networking-ssh2.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "04f61365bcd96bdbf55c023141f51297098216406c6f58a99cff0bd584172c25"
    sha256 cellar: :any,                 arm64_monterey: "05840122f6516ab6607cef24d00a314bd689dce4d609fc6ee2891883ebbfab65"
    sha256 cellar: :any,                 arm64_big_sur:  "25aa031302225acce2da4abc90ad041c367879c2672a00445ab3db46616334ae"
    sha256 cellar: :any,                 ventura:        "8b193f78e23160b335e2effebce641b5e1d35fb6950eb93d999a7cad42c004d0"
    sha256 cellar: :any,                 monterey:       "0c05e478fcaf1c78dec2862dd74d4c51c36d129ac27be29828f347ab307dfaee"
    sha256 cellar: :any,                 big_sur:        "90a4117144f733fb58fb149653f52269b214e248bc9b02c0ac7f04b4ced9ec03"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "763b65ecf85f7e0220654cc19d59ae91001e25be3b20632a0df3052f421a2be9"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Formula["libssh2"].opt_prefix}
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
