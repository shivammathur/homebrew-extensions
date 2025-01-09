# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT84 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.4.tgz"
  sha256 "1b16ae5e17736e2ce892fd96145fa8b9e1724106458535d0c7e3d4093a9091a9"
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "5cb03f2c991a2bfc152cff584c09769f5ee5f9456e89d693e3cc3ba323cd0713"
    sha256 cellar: :any,                 arm64_sonoma:  "28d9bfccb9b8aa1311ff265b3a73dc9ff0814f9caa3550b3f7c8ae502afa4970"
    sha256 cellar: :any,                 arm64_ventura: "17f96020c95042d4fafd8d1b328a13304d14247caf2a9862048382c0bba44f2b"
    sha256 cellar: :any,                 ventura:       "004de6a5613b6b914b09d884fe90c3b661c97b30d6d4095fa06f478e134c2105"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0c9cf03ce813d5f59c63f77051d4519557f571a54583d828b6e3ea04a387f158"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
