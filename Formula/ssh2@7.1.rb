# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT71 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.4.1.tgz"
  sha256 "7bca5b23f731db9d8ed0aea5db9bb15da8ff133b0fbba96102b82e95da4d8764"
  head "https://github.com/php/pecl-networking-ssh2.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "dd493766f549e265b5b70d6762b7ba9b0c0ab40efbd3a4e2ecebdbe3f27bcec7"
    sha256 cellar: :any,                 arm64_monterey: "7dd3916f1b17cee26be324e489c08103b621513f1f2697d4de935ea6ede3db17"
    sha256 cellar: :any,                 arm64_big_sur:  "6ef12a04b808a5cd28558216b7ba74a1518419ef91d3549660b4f20fe5960ae2"
    sha256 cellar: :any,                 ventura:        "729da83fd8b1f5ea0197a2aba71c5e08764eebb8fad2292cfd520f496be20723"
    sha256 cellar: :any,                 monterey:       "db34e6271f49f93d9fb4a4794ba32225e23fab2c07a22ad5c16f82cc3890f0e5"
    sha256 cellar: :any,                 big_sur:        "df37cce7f6a22047343c336c176d9711e3d3b0fe324fd613dda0907847d4a219"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "301915772912e5e97c1d361183ce357499adc2e6822c40a9b12a30ccb380ee3b"
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
