# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT70 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.4.tgz"
  sha256 "1b16ae5e17736e2ce892fd96145fa8b9e1724106458535d0c7e3d4093a9091a9"
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gearman/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "04026c96994631ab39ba3ae1ebe642cb25ac161d2d027ebfa47e7e855120727f"
    sha256 cellar: :any,                 arm64_sonoma:  "6acce20d44318b83ea6d62f6a3e134bd9fd6ba429d708549660c3baf9bfd22af"
    sha256 cellar: :any,                 arm64_ventura: "4a570abffd0af2d1a8929d27b6d8bacc1a2ee0301d049f3052921f09bfd51fbb"
    sha256 cellar: :any,                 ventura:       "1e2657e46f6005751f348c6ded4b230494d07d99aaeeb945ed79f94e1d368f6c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "edaf355bc9e7b24413b05eba4130e5d27649eef4ea31181f9afd3eee65de8a85"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8fd8691e86827a6f1726a6a0116c6c465e58fe8a98a4ccce9b611cbe4fead73b"
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
