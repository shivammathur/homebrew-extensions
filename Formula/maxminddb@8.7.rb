# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT87 < AbstractPhpExtension
  init
  desc "MaxMind DB Reader PHP extension"
  homepage "https://github.com/maxmind/MaxMind-DB-Reader-php-ext"
  url "https://pecl.php.net/get/maxminddb-1.14.0.tgz"
  sha256 "c06351f1360bd651057ea73e0186d8fec744292839a4b49c71ce886072c4fff7"
  revision 2
  head "https://github.com/maxmind/MaxMind-DB-Reader-php-ext.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/maxminddb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "5e7708aadbafec826a7be94521d09e758c04f63aea0b61f7012f35add4e2ff67"
    sha256 cellar: :any, arm64_tahoe:       "8ee9645003828872824ae96234543f693f88e2d761bd901cbee95a93c14c9a6a"
    sha256 cellar: :any, arm64_sequoia:     "7002bc3929c448012424bdea1e385575d9edbb5e3e39a950855509a3f5856db5"
    sha256 cellar: :any, arm64_linux:       "2c895aa4b90feff346c15e2d853565e95cd37c125776fdc7e959ec0d3cd5eded"
    sha256 cellar: :any, x86_64_linux:      "9ceec923bd111a2dd3accad7f1b4485c7c6125db5e0b8be3a5b56f153b5f550a"
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
