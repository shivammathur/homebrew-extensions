# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT72 < AbstractPhpExtension
  init
  desc "MaxMind DB Reader PHP extension"
  homepage "https://github.com/maxmind/MaxMind-DB-Reader-php-ext"
  url "https://pecl.php.net/get/maxminddb-1.13.1.tgz"
  sha256 "362839e6a0a50f6253d46ae11b3cae80520582e2b5528423aed9644577a3a93d"
  head "https://github.com/maxmind/MaxMind-DB-Reader-php-ext.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/maxminddb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "9f66d16437c1870bc389b070059ddda5c008419b6a3f23231d5bb9912b27fcab"
    sha256 cellar: :any,                 arm64_sequoia: "6d2c63b067ac6aafd12080d41c06176f5521b2c81e14fea0931e8af60868f08c"
    sha256 cellar: :any,                 arm64_sonoma:  "b6c6c09ccb53d86e0413dde7773bf233af1adb9cee9d5e6e2967446b4b3aaf56"
    sha256 cellar: :any,                 sonoma:        "89fdaa4bca8f948ff59619aeabdda5b5163c813677a94daf6f0fe2d8bc2a58fb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6fc5c94bfded80f67219313cdd4c20857ff7aa28318aa8ac1e4378c2ddbf7eb4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d23e4416efacb19d5711dcbb7c3a0a246b047ebb265952dfbfbc6828affa58f4"
  end

  depends_on "libmaxminddb"

  def install
    Dir.chdir "maxminddb-#{version}/ext"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-maxminddb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
