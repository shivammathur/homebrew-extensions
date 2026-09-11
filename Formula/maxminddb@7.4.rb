# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT74 < AbstractPhpExtension
  init
  desc "MaxMind DB Reader PHP extension"
  homepage "https://github.com/maxmind/MaxMind-DB-Reader-php-ext"
  url "https://pecl.php.net/get/maxminddb-1.14.0.tgz"
  sha256 "c06351f1360bd651057ea73e0186d8fec744292839a4b49c71ce886072c4fff7"
  head "https://github.com/maxmind/MaxMind-DB-Reader-php-ext.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/maxminddb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "4561f490763b50f399baa3081bb7fdf540e3a6f1d63903c2474db4bbc7fa7190"
    sha256 cellar: :any, arm64_sequoia: "a7e696410d7ba94034852ee286b8a9ecb0e3a5970d60e6deeec84b13d363c42a"
    sha256 cellar: :any, arm64_sonoma:  "a022356036805e4b1d18e1585030dce4d68b581b19fc1516d62d2562644529d5"
    sha256 cellar: :any, arm64_linux:   "929d0f63297759b470fd123348c44a8d0fcb478420a5292a6081f11ce77b70a1"
    sha256 cellar: :any, x86_64_linux:  "822efcf69bb5c66deaa80a6acbe7cf84c9c3b86753bc0041e86c63bbb76347ba"
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
