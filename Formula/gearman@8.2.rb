# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT82 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.4.tgz"
  sha256 "1b16ae5e17736e2ce892fd96145fa8b9e1724106458535d0c7e3d4093a9091a9"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "ca460cd0c1931ab45de53170b68b9b47e14862df6fcb8064ee81986440237db2"
    sha256 cellar: :any,                 arm64_sonoma:  "f2418cef0ecf0be5be695605b5d5ea2d3c270f63fa9be5f5fb5a5086b58cc8ed"
    sha256 cellar: :any,                 arm64_ventura: "95da8b77a113a36cd8841988c929939f1177b28c625d75c37cc74d02f9346a91"
    sha256 cellar: :any,                 ventura:       "4a8bfe005ec9584f25d1e8de90ff4f71f38821c11331ba85af353ba746f8f34b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4a0d0d476464d91631c2c514adb3a0971b86fa6770eb87c55ab93944132b0d5c"
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
