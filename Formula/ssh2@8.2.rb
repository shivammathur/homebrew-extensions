# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT82 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.4.1.tgz"
  sha256 "7bca5b23f731db9d8ed0aea5db9bb15da8ff133b0fbba96102b82e95da4d8764"
  head "https://github.com/php/pecl-networking-ssh2.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "807176b5cd6fa018ece423def32e60732858b169860ece52ef047c6f987e2ff4"
    sha256 cellar: :any,                 arm64_monterey: "b7c81518050083114c64b7ec92808f85476f2279f6738984c61a86878b5ddd2a"
    sha256 cellar: :any,                 arm64_big_sur:  "fee091cfd2172ca13d56430c47f870c5d1b8494244892ae62327c50a2295598e"
    sha256 cellar: :any,                 ventura:        "4125ce7042b82793b57b63ec2fd0c4bd6da3e1abcd923ec7a43fac6d8c7d2f3c"
    sha256 cellar: :any,                 monterey:       "3d5801bb3eadbd9ba45e6d56f239e769b0bbc281b27a5585ff13fdec0098014f"
    sha256 cellar: :any,                 big_sur:        "28034ced4b9ee9bbf4fb280b1c566092d9da777075b3bd110ddf2bb8723a0e16"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f26081cf1acdd62f71248687db859727283e3ee7f817dc8f127b4f1d9be4f084"
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
