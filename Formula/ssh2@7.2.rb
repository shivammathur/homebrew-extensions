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
    sha256 cellar: :any,                 arm64_sequoia:  "786b36ca9cb8c172efa130e1d478370488d1ac8fde6db2325b0d54e9a03c17d2"
    sha256 cellar: :any,                 arm64_sonoma:   "ab78201229b0502c29e1d906ee9717f5ce82916f5f65f2a3371abe7738289e6d"
    sha256 cellar: :any,                 arm64_ventura:  "2e6c293cb035b94f8f2c441dfce8fd93172e729f24058e4ef53edb58f6e3cff1"
    sha256 cellar: :any,                 arm64_monterey: "dba3201eed1cb6032e8900c348589e4ba827736462dc5f6d7d6cdb5c21d6cfc5"
    sha256 cellar: :any,                 ventura:        "ddcfb11537b722774efe7a9236d747d55da7b821cdeff9194c068204d0781fab"
    sha256 cellar: :any,                 monterey:       "b99f803144dd0042ee001577ec2fab3d31eee14da15f9bcd928a161195f1afff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b89be56c35658d4fb563c26b9df6c15961bbc2b9809eb3b4951b43b6b54d17bd"
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
